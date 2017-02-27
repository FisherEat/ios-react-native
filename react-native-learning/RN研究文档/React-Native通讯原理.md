#### React-Native通讯原理

##### 设置SPY_MODE标志为true

> ```javascript
> //MessageQueue.js，需要处于dev模式
> //http://localhost:8081/index.ios.bundle?platform=ios&dev=true为true
> let SPY_MODE = true; //
> MessageQueue.js在: node_modules/react-native/Libraries/Utilities
> ```
>
> 然后重新reload.js就可以看到如下的日志输出：
>
> ```shell
> N->JS : RCTDeviceEventEmitter.emit(["appStateDidChange",{"app_state":"active"}])
> N->JS : RCTDeviceEventEmitter.emit(["networkStatusDidChange",{"network_info":"wifi"}])
> ...
> ```

##### JS调用Native

> 1. `native（OC）`创建一个模块暴露给js层，这里创建一个`GLSpringboard`
>
> ```objective-c
> #import <Foundation/Foundation.h>
> #import "RCTRootView.h"
> #import "RCTBridgeModule.h"
> #import "RCTBridge.h"
> #import "RCTEventDispatcher.h"
>
> @interface GLSpringboard : NSObject <RCTBridgeModule>
>
> + (RCTRootView *)rctRootViewWithClassName:(NSString *)clssname bridge:(RCTBridge *)bridge;
>
> @end
>
> @implementation GLSpringboard
> RCT_EXPORT_MODULE(); 
>
> + (RCTRootView *)rctRootViewWithClassName:(NSString *)clssname bridge:(RCTBridge *)bridge
> {
> RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"rnToday_2" initialProperties:@{@"classname": clssname}];
> rootView.frame = [UIScreen mainScreen].bounds;
> return rootView;
> }
>
> RCT_EXPORT_METHOD(showNativeView:(NSDictionary*)params callback:(RCTResponseSenderBlock)callback) {
> GLNativeTestViewController *nativeVC = [GLNativeTestViewController new];
> [[AppDelegate appDelegate].navigationController pushViewController:nativeVC animated:NO];
> callback(@[@{@"data": @"backdata"}]);
> }
>
> - (dispatch_queue_t)methodQueue
> {
> return dispatch_get_main_queue();
> }
>
> 1.RCT_EXPORT_MODULE()
> 该宏是将native创建的模块暴露给js层，该宏定义具体实现如下：
> #define RCT_EXPORT_MODULE(js_name) \
> RCT_EXTERN void RCTRegisterModule(Class); \
> + (NSString *)moduleName { return @#js_name; } \
> + (void)load { RCTRegisterModule(self); }
>
> [RCTModuleClasses addObject:moduleClass];
> 首先将RCTRegisterModule这个函数定义为extern,这样该函数的实现对编译器不可见，但是链接的时候可以获取；同时声明一个moduleName函数，该函数返回该模块的js名称，如果没有指定，默认使用类名；最后声明（重载）一个load函数，该函数是所有NSObject类的根函数！然后调用RCTRegisterModule函数注册该模块，该模块会被注册添加到一个全局的数组RCTModuleClasses中。这个有点类似我们的navigator跳转，APP启动的时候会注册所有加入navigator协议的类。吼吼。
>
> 2.RCT_EXPORT_METHOD()
> 该宏定义具体实现如下：
> #define RCT_EXPORT_METHOD(method) \
> RCT_REMAP_METHOD(, method)
> #define RCT_REMAP_METHOD(js_name, method) \
> RCT_EXTERN_REMAP_METHOD(js_name, method) \
> - (void)method
> #define RCT_EXTERN_REMAP_METHOD(js_name, method) \
> + (NSArray<NSString *> *)RCT_CONCAT(__rct_export__, \
> RCT_CONCAT(js_name, RCT_CONCAT(__LINE__, __COUNTER__))) { \
> return @[@#js_name, @#method]; \
> }
> 要暴露给js调用的API接口需要通过该宏定义声明，该宏定义会额外的创建一个函数：上面转化而来就是这样
> + (NSArray *)__rct_export__230
> {
> return @[ @"", @"addEvent:(NSString *)name location:(NSString *)location" ];
> }
> 该函数以rct_export开头，同时加上该函数代码所在函数，该函数返回一个包含可选的js名称以及一个函数签名的数组，他们的作用后面会说到。
> ```
>
> 1. `RCTBridge`
>
> 为了桥接js跟native，native层引入了RCTBridge这个类负责双方的通讯，不过真正起作用的是RCTBatchedBridge这个类：
>
> ```objective-c
> //RCTBridge.m创建了RCTBatchedBridge对象
> [self createBatchedBridge];
> - (void)createBatchedBridge
> {
> self.batchedBridge = [[RCTBatchedBridge alloc] initWithParentBridge:self];
> }
> ```
>
> 这个类具体实现：
>
> ```objective-c
> - (void)start
> {
> dispatch_queue_t bridgeQueue = dispatch_queue_create("com.facebook.react.RCTBridgeQueue", DISPATCH_QUEUE_CONCURRENT);
>
> dispatch_group_t initModulesAndLoadSource = dispatch_group_create();
>
> // Asynchronously load source code
> //异步加载打包完成的js文件，也就是main.jsbundle，如果包文件在本地就直接加载，否则根据通过URL通过NSURLSession方式去下载
> dispatch_group_enter(initModulesAndLoadSource);
> __weak RCTBatchedBridge *weakSelf = self;
> __block NSData *sourceCode;
> [self loadSource:^(NSError *error, NSData *source) {
> if (error) {
> dispatch_async(dispatch_get_main_queue(), ^{
> [weakSelf stopLoadingWithError:error];
> });
> }
>
> sourceCode = source;
> dispatch_group_leave(initModulesAndLoadSource);
> }];
>
> // Synchronously initialize all native modules that cannot be loaded lazily
> //同步初始化需要暴露给js的native模块，这部分不能被懒加载，初始化类名
> [self initModulesWithDispatchGroup:initModulesAndLoadSource];
>
> if (RCTProfileIsProfiling()) {
> // Depends on moduleDataByID being loaded
> RCTProfileHookModules(self);
> }
>
> __block NSString *config;
> dispatch_group_enter(initModulesAndLoadSource);
> dispatch_async(bridgeQueue, ^{
> dispatch_group_t setupJSExecutorAndModuleConfig = dispatch_group_create();
>
> // Asynchronously initialize the JS executor
> //异步初始化JS executor js引擎
> dispatch_group_async(setupJSExecutorAndModuleConfig, bridgeQueue, ^{
> [weakSelf setUpExecutor];
> });
>
> // Asynchronously gather the module config
> //异步获取各个模块的配置信息
> dispatch_group_async(setupJSExecutorAndModuleConfig, bridgeQueue, ^{
> if (weakSelf.valid) {
> RCTPerformanceLoggerStart(RCTPLNativeModulePrepareConfig);
> config = [weakSelf moduleConfig];
> RCTPerformanceLoggerEnd(RCTPLNativeModulePrepareConfig);
> }
> });
>
> dispatch_group_notify(setupJSExecutorAndModuleConfig, bridgeQueue, ^{
> // We're not waiting for this to complete to leave dispatch group, since
> // injectJSONConfiguration and executeSourceCode will schedule operations
> // on the same queue anyway.
> //获取各模块的配置信息后，将这些信息注入到JS环境中 RCTPerformanceLoggerStart(RCTPLNativeModuleInjectConfig);
> [weakSelf injectJSONConfiguration:config onComplete:^(NSError *error) {
> RCTPerformanceLoggerEnd(RCTPLNativeModuleInjectConfig);
> if (error) {
> dispatch_async(dispatch_get_main_queue(), ^{
> [weakSelf stopLoadingWithError:error];
> });
> }
> }];
> dispatch_group_leave(initModulesAndLoadSource);
> });
> });
> //开始执行main.jsbundle
> dispatch_group_notify(initModulesAndLoadSource, dispatch_get_main_queue(), ^{
> RCTBatchedBridge *strongSelf = weakSelf;
> if (sourceCode && strongSelf.loading) {
> [strongSelf executeSourceCode:sourceCode];
> }
> });
> }
> ```
>
> 简单解释各个步骤的具体内容：
>
> `initModules`
>
> ```objective-c
> //RCTGetModuleClasses()返回之前提到的全局RCTModuleClasses数组，也就是该模块了如GLSpringboard load时会注册添加的数组(仔细查看该数组其实只保存了模块类的类名)
> NSArray<Class> *RCTGetModuleClasses(void)
> {
> return RCTModuleClasses;
> }
> //
> for (Class moduleClass in RCTGetModuleClasses()) {
> NSString *moduleName = RCTBridgeModuleNameForClass(moduleClass);
>
> // Check for module name collisions
> //查看模块名，防止出现冲突，并且保证每个模块类只有一个实例对象
> RCTModuleData *moduleData = moduleDataByName[moduleName];
> if (moduleData) { 
> if (moduleData.hasInstance) {
> // Existing module was preregistered, so it takes precedence
> continue;
> } else if ([moduleClass new] == nil) {
> // The new module returned nil from init, so use the old module
> continue;
> } else if ([moduleData.moduleClass new] != nil) {
> // Both modules were non-nil, so it's unclear which should take precedence
> RCTLogError(@"Attempted to register RCTBridgeModule class %@ for the "
> "name '%@', but name was already registered by class %@",
> moduleClass, moduleName, moduleData.moduleClass);
> }
> }
>
> // Instantiate moduleData (TODO: can we defer this until config generation?)
> moduleData = [[RCTModuleData alloc] initWithModuleClass:moduleClass
> bridge:self];
> moduleDataByName[moduleName] = moduleData;
> [moduleClassesByID addObject:moduleClass];
> [moduleDataByID addObject:moduleData];
> }
> //当创建完模块的实例对象之后，会将该实例保存到一个RCTModuleData对象中，RCTModuleData里包含模块的类名，名称，方法列表，实例对象、该模块代码执行的队列以及配置信息等，js层就是根据这个对象来查询该模块的相关信息。我们这里可以看到我们创建的GLSpringBoard模块以及其数据。
> ```
>
> 加载js代码，数据保存为`NSData`
>
> ```objective-c
> - (void)loadSource:(RCTSourceLoadBlock)_onSourceLoad
> {
> RCTPerformanceLoggerStart(RCTPLScriptDownload);
> NSUInteger cookie = RCTProfileBeginAsyncEvent(0, @"JavaScript download", nil);
>
> // Suppress a warning if RCTProfileBeginAsyncEvent gets compiled out
> (void)cookie;
>
> RCTSourceLoadBlock onSourceLoad = ^(NSError *error, NSData *source) {
> RCTProfileEndAsyncEvent(0, @"native", cookie, @"JavaScript download", @"JS async", nil);
> RCTPerformanceLoggerEnd(RCTPLScriptDownload);
>
> _onSourceLoad(error, source);
> };
>
> if ([self.delegate respondsToSelector:@selector(loadSourceForBridge:withBlock:)]) {
> [self.delegate loadSourceForBridge:_parentBridge withBlock:onSourceLoad];
> } else if (self.bundleURL) {
> [RCTJavaScriptLoader loadBundleAtURL:self.bundleURL onComplete:onSourceLoad];
> } else {
> // Allow testing without a script
> dispatch_async(dispatch_get_main_queue(), ^{
> [self didFinishLoading];
> [[NSNotificationCenter defaultCenter]
> postNotificationName:RCTJavaScriptDidLoadNotification
> object:_parentBridge userInfo:@{@"bridge": self}];
> });
> onSourceLoad(nil, nil);
> }
> }
> ```
>
> `setUpExecutor`
>
> react-native的js引擎在初始化的时候创建一个新的线程，该线程的优先级跟主线程的优先级一样，同时创建一个`runloop`，这样线程才能循环执行不退出。所以执行js代码不会影响到主线程，而`RCTJSExecutor`使用的是`JavaScriptCore`框架：（具体可以断点到这个类）
>
> ```objective-c
> //RCTJSCExecutor.m
> - (instancetype)init
> {
> NSThread *javaScriptThread = [[NSThread alloc] initWithTarget:[self class]
> selector:@selector(runRunLoopThread)
> object:nil];
> javaScriptThread.name = @"com.facebook.React.JavaScript";
> //设置该线程的优先级处于高优先级
> if ([javaScriptThread respondsToSelector:@selector(setQualityOfService:)]) {
> [javaScriptThread setQualityOfService:NSOperationQualityOfServiceUserInteractive];
> } else {
> javaScriptThread.threadPriority = [NSThread mainThread].threadPriority;
> }
> [javaScriptThread start];
> return [self initWithJavaScriptThread:javaScriptThread context:nil];
> }
> - (void)addSynchronousHookWithName:(NSString *)name usingBlock:(id)block
> {
> __weak RCTJSCExecutor *weakSelf = self;
> [self executeBlockOnJavaScriptQueue:^{
> //将该block函数添加到js的context中，javascriptcore会将block函数转成js function
> weakSelf.context.context[name] = block;
> }];
> }
>
> - (void)setUp
> {
> [self addSynchronousHookWithName:@"noop" usingBlock:^{}];
> [self addSynchronousHookWithName:@"nativeRequireModuleConfig" usingBlock:^NSString *(NSString *moduleName) {
> //获取该模块的具体配置信息，包含方法以及导出的常量等信息
> NSArray *config = [strongSelf->_bridge configForModuleName:moduleName];
> NSString *result = config ? RCTJSONStringify(config, NULL) : nil;
> return result;
> }];
> [self addSynchronousHookWithName:@"nativeFlushQueueImmediate" usingBlock:^(NSArray<NSArray *> *calls){
> [strongSelf->_bridge handleBuffer:calls batchEnded:NO];
> }];
> }
> //可以看到setup的时候会注册几个方法到js的context中供js调用，如‘nativeRequireModuleConfig’ ’nativeLoggingHook‘ 和‘nativeFlushQueueImmediate‘ ’nativePerformanceNow‘等方法。这些方法是以字符串的形式注册 ，当js调用这些方法时会执行对应的block,JavaScriptCore负责js function和native block之间的转换。
> //我们去node_modules/react-native/../NativeModules.js文件发现：global.nativeRequireModuleConfig
> const NativeModules = {};
> Object.keys(RemoteModules).forEach((moduleName) => {
> Object.defineProperty(NativeModules, moduleName, {
> enumerable: true,
> get: () => {
> let module = RemoteModules[moduleName];
> if (module && typeof module.moduleID === 'number' && global.nativeRequireModuleConfig) {
> const json = global.nativeRequireModuleConfig(moduleName);
> const config = json && JSON.parse(json);
> module = config && BatchedBridge.processModuleConfig(config, module.moduleID);
> RemoteModules[moduleName] = module;
> }
> return module;
> },
> });
> });
> ```
>
> `moduleConfig`
>
> ```objective-c
>
> - (NSString *)moduleConfig
> {
> NSMutableArray<NSArray *> *config = [NSMutableArray new];
> for (RCTModuleData *moduleData in _moduleDataByID) {
> if (self.executorClass == [RCTJSCExecutor class]) {
> [config addObject:@[moduleData.name]];
> } else {
> [config addObject:RCTNullIfNil(moduleData.config)];
> }
> }
>
> return RCTJSONStringify(@{
> @"remoteModuleConfig": config,
> }, NULL);
> }
> //从实现来看该过程仅仅是将模块的名称保存到一个数组中，并且将该数组转为一个json字符串，包含所有的模块名称，类似：
> {"remoteModuleConfig":[["GLSpringboard"],["RCTStatusBarManager"],["RCTSourceCode"],["RCTAlertManager"],["RCTExceptionsManager"],...]}
> ```
>
> `injectJSONConfiguration`
>
> ```
> - (void)injectJSONConfiguration:(NSString *)configJSON
> onComplete:(void (^)(NSError *))onComplete
> {
> if (!_valid) {
> return;
> }
>
> [_javaScriptExecutor injectJSONText:configJSON
> asGlobalObjectNamed:@"__fbBatchedBridgeConfig"
> callback:onComplete];
> }
> //该方法的实现在RCTJSCExecutor文件中。从上可以看出，当我们生成配置信息后，通过上面的函数将该json信息保存到js的全局对象 __fbBatchedBridgeConfig中，这样js层就知道我们提供了哪些模块，，不过细心的话你可能会发现给js的信息只有这些模块的名称，那js怎么调用native的方法的，其实这是react为了懒加载而采用的方式，具体我们下面说明。
> ```
>
> 当我们配置好native模块后，js层想要调用该native模块的方法如下所示：
>
> ```javascript
>
> var NativeBoard = NativeModules.GLSpringboard
> var params = {name: 'gaolong', 'password': 123}
> var callback = () => {};
> NativeBoard.showNativeView(params, function(callback){
> console.log(callback);
> });
> //其实native模块是保存到了NativeModules.js中，我们打开NativeModules.js文件发现：
> const BatchedBridge = require('BatchedBridge');
> const RemoteModules = BatchedBridge.RemoteModules;
> const NativeModules = {};
> Object.keys(RemoteModules).forEach((moduleName) => {
> Object.defineProperty(NativeModules, moduleName, {
> enumerable: true,
> //懒加载方式
> get: () => {
> let module = RemoteModules[moduleName];
> if (module && typeof module.moduleID === 'number' && global.nativeRequireModuleConfig) {
>
> //从native层获取该模块的具体配置信息，nativeRequireModuleConfig是之前注册到js global对象的方法，然后把config信息交给BatchedBridge处理
> const json = global.nativeRequireModuleConfig(moduleName);
> const config = json && JSON.parse(json);
> module = config && BatchedBridge.processModuleConfig(config, module.moduleID);
> RemoteModules[moduleName] = module;
> }
> return module;
> },
> });
> });
> 从上面的代码可以看出，如果你在js层没有使用native模块，那么这些模块是不会加载到js层的，只有使用了该模块，react才会去获取该模块的具体配置信息，然后加载到js,这是react懒加载的一个方式，让我们能够节约内存。下面我们看看如何获取模块的配置信息，而不仅仅是模块的类名：
> ```
>
> 模块配置信息
>
> ```objective-c
> //只会导出有__rct_export__前缀的方法，也就是之前RCT_EXPORT_METHOD这个宏定义提到的
> //RCTModuleData存放了配置信息：类名、模块名、方法名和config配置信息
> - (NSString *)name
> {
> return RCTBridgeModuleNameForClass(_moduleClass);
> }
> - (NSArray<id<RCTBridgeMethod>> *)methods
> {
> //拷贝该类的所有方法，然后过滤以__rct_export__开头的方法
> Method *methods = class_copyMethodList(object_getClass(_moduleClass), &methodCount);
> for (unsigned int i = 0; i < methodCount; i++) {
> Method method = methods[i];
> SEL selector = method_getName(method);
> if ([NSStringFromSelector(selector) hasPrefix:@"__rct_export__"]) {
> IMP imp = method_getImplementation(method);
> NSArray<NSString *> *entries =
> ((NSArray<NSString *> *(*)(id, SEL))imp)(_moduleClass, selector);
>
> [moduleMethods addObject:/*代表该方法的对象*/];
> }
> }
>
> //获取模块的具体配置信息，以数组形式返回，第一个为模块名称，第二个为需要导出的常量（如果有），第三个为导出的方法（如果有）
> //以MyModule为例，导出的config为：["MyModule",{"FirstDay":"Monday"},["addEvent","findEvents"]]
> - (NSArray *)config
> {
> //过滤获取以__rct_export__开头的方法
> for (id<RCTBridgeMethod> method in self.methods) {
> [methods addObject:method.JSMethodName];
> }
> NSMutableArray *config = [NSMutableArray new];
> [config addObject:self.name];
> if (constants.count) {
> [config addObject:constants];
> }
> if (methods) {
> [config addObject:methods];
> }
> if ([[config firstObject] isEqualToString:@"GLSpringboard"]) { //测试我自己的模块类的配置信息
> NSLog(@"%@", config);
> }
> return config;
> }
> //这是native导出的配置信息，该信息保存到了js的全局对象__fbBatchedBridgeConfig中，再去查看js代码中__fbBatchedBridgeConfig信息，，发现有我们的GLSpringboard对象和信息了。
> ```
>
> `BatchedBridge`  和 `MessageQueue`
>
> 上面我们说到js通过全局对象获取到模块的具体配置信息后，交给`BatchedBridge`处理。之前我们说的是native的bridge，不过js为了桥接native层也引入了`BatchedBridge`：
>
> ```javascript
> //node_modules/react-native/Libraries/BatchedBridge/BatchedBridge.js
> const MessageQueue = require('MessageQueue');
>
> const BatchedBridge = new MessageQueue(
> __fbBatchedBridgeConfig.remoteModuleConfig,
> __fbBatchedBridgeConfig.localModulesConfig,
> );
>
> // TODO: Move these around to solve the cycle in a cleaner way.
>
> const Systrace = require('Systrace');
> const JSTimersExecution = require('JSTimersExecution');
>
> BatchedBridge.registerCallableModule('Systrace', Systrace);
> BatchedBridge.registerCallableModule('JSTimersExecution', JSTimersExecution);
>
> if (__DEV__) {
> BatchedBridge.registerCallableModule('HMRClient', require('HMRClient'));
> }
>
> // Wire up the batched bridge on the global object so that we can call into it.
> // Ideally, this would be the inverse relationship. I.e. the native environment
> // provides this global directly with its script embedded. Then this module
> // would export it. A possible fix would be to trim the dependencies in
> // MessageQueue to its minimal features and embed that in the native runtime.
>
> Object.defineProperty(global, '__fbBatchedBridge', { value: BatchedBridge });
>
> module.exports = BatchedBridge;
> //我们看到BatchedBridge是MessageQueue的一个实例，而且是全局唯一一个实例，作为桥接native的一个关键点，我们断点到这个文件的__fbBatchedBridgeConfig:
> 首先看一下传递给MessageQueue的两个参数：
> __fbBatchedBridgeConfig.remoteModuleConfig,
> __fbBatchedBridgeConfig.localModulesConfig,
>
> __fbBatchedBridgeConfig我们之前提到过，是一个全局的js变量，__fbBatchedBridgeConfig.remoteModuleConfig就是之前我们在native层导出的模块配置表.
>
> ```
>
> `MessageQueue` 
>
> 下面是messageQueue中的一些实例变量以及API
>
> ```javascript
> //node_modules/react-native/Libraries/Utilities/MessageQueue.js
>
> //存储native提供的各个模块信息，
> this.RemoteModules = {};
> //存储js提供的各个模块信息
> this._callableModules = {};
> //用于存放调用信息队列，有三个数组，分别对应调用的模块，调用的函数和参数信息，也就是一个函数调用由这三个数组拼接而成
> this._queue = [[], [], [], 0];
> //以moduleID为key，value为moduleName，针对js提供的module
> this._moduleTable = {};
> //以moduleId为key，value为模块导出的方法，针对js提供的module
> this._methodTable = {};
> //回调函数数组
> this._callbacks = [];
> //回调函数对应的索引id
> this._callbackID = 0;
>
> let modulesConfig = this._genModulesConfig(remoteModules);
> this._genModules(modulesConfig);
> localModules && this._genLookupTables(
> this._genModulesConfig(localModules),this._moduleTable, this._methodTable
> );
>
> //以moduleId为key，value为moduleName，针对native提供的module
> this._remoteModuleTable = {};
> //以moduleId为key，value为模块导出的方法，针对native提供module
> this._remoteMethodTable = {};
> //可以看出这个队列里保存着js跟native的模块交互的所有信息。先看一下 _genModules方法，该方法会根据config解析每个模块的信息并保存到this.RemoteModules中：
> _genModules(remoteModules) {
> remoteModules.forEach((config, moduleID) => {
> this._genModule(config, moduleID);
> });
> }
> //_genModules会遍历所有的remoteModules，根据每个模块的配置信息和module索引ID来创建每个模块：
> _genModule(config, moduleID) {
> let moduleName, constants, methods, asyncMethods;
> //通过解构赋值的方式提取配置信息中的模块名称，常量(如果有)，方法名等
> [moduleName, constants, methods, asyncMethods] = config;
> let module = {};
> methods && methods.forEach((methodName, methodID) => {
> //历遍该config中的方法列表，根据配置信息为每个模块生成js function方法并添加到module对象，
> module[methodName] = this._genMethod(moduleID, methodID, methodType);
> });
> //常量信息assign到该module对象,并将module保存到this.RemoteModules中
> Object.assign(module, constants);
> this.RemoteModules[moduleName] = module;
> return module;
> }
> ```
>
> `_genMethod`
>
> 假如方法的`type`为`remoteAsync`，也就是异步方法，其实就是用一个`promise`对象(promise是js中的一种异步编程方式)来包装普通的方法，这里我们只看下普通方法的处理过程：
>
> ```javascript
> _genMethod(module, method, type) {
> let fn = null;
> let self = this;
> fn = function(...args) {
> let lastArg = args.length > 0 ? args[args.length - 1] : null;
> let secondLastArg = args.length > 1 ? args[args.length - 2] : null;
> let hasSuccCB = typeof lastArg === 'function';
> let hasErrorCB = typeof secondLastArg === 'function';
> hasErrorCB && invariant(
> hasSuccCB,
> 'Cannot have a non-function arg after a function arg.'
> );
> let numCBs = hasSuccCB + hasErrorCB;
> let onSucc = hasSuccCB ? lastArg : null;
> let onFail = hasErrorCB ? secondLastArg : null;
> args = args.slice(0, args.length - numCBs);
> return self.__nativeCall(module, method, args, onFail, onSucc);
> };
> }
> fn.type = type;
> return fn;
> }
> //可以看出该方法也比较简单，只是在参数列表中提取onFail和onSucc回调函数，并最终调用__nativeCall方法。
> __nativeCall(module, method, params, onFail, onSucc) {
> if (onFail || onSucc) {
> onFail && params.push(this._callbackID);
> this._callbacks[this._callbackID++] = onFail;
> onSucc && params.push(this._callbackID);
> this._callbacks[this._callbackID++] = onSucc;
> }
>
> this._queue[MODULE_IDS].push(module);
> this._queue[METHOD_IDS].push(method);
> this._queue[PARAMS].push(params);
>
> var now = new Date().getTime();
> //当两次调用间隔过小的时候只是先缓存调用信息
> if (global.nativeFlushQueueImmediate &&
> now - this._lastFlush >= MIN_TIME_BETWEEN_FLUSHES_MS) {
> global.nativeFlushQueueImmediate(this._queue);
> this._queue = [[], [], [], this._callID];
> this._lastFlush = now;
> }
> }
> //RCTJSCExecutor.m
> [self addSynchronousHookWithName:@"nativeFlushQueueImmediate" usingBlock:^(NSArray<NSArray *> *calls){
> [strongSelf->_bridge handleBuffer:calls batchEnded:NO];
> }];
> __nativeCall方法中，假如有回调参数onFail或onSucc，会将对应的callbackID保存到参数中，并将它们压入到_callbacks栈中；接着将模块，名称以及参数分别保存到_queue的三个数组中；接下来的关键就是调用nativeFlushQueueImmediate方法，该方法是之前RCTJSCExecutor setup的时候注册到js global的方法，因此它会执行相应的native block方法(javascriptcore框架会负责js function和block的转换)，可以看出_queue中的模块、方法以及参数信息最终会传递给native层，由native解析并执行相应的native方法。
> 我们也可以注意到这里react为了性能的优化，当js两次调用方法的间隔小于MIN_TIME_BETWEEN_FLUSHES_MS(5ms)时间，会将调用信息先缓存到_queue中，等待下次在一并提交给native层执行，可能这也就是这些参数设置成数组形式保存的原因。
> ```
>
> `handleBuffer`
>
> handleBuffer会将调用信息先按模块的队列分好：
>
> ```objective-c
> //RCTBatchedBridge.m
> - (void)handleBuffer:(id)buffer batchEnded:(BOOL)batchEnded
> {
>   NSArray *requestsArray = [RCTConvert NSArray:buffer];
>   //先将messageueue传递的参数提取出来分别放到moduleIDs、methodIDs和paramsArrays数组中，
>   NSArray<NSNumber *> *moduleIDs = [RCTConvert NSNumberArray:requestsArray[RCTBridgeFieldRequestModuleIDs]];
>   NSArray<NSNumber *> *methodIDs = [RCTConvert NSNumberArray:requestsArray[RCTBridgeFieldMethodIDs]];
>   NSArray<NSArray *> *paramsArrays = [RCTConvert NSArrayArray:requestsArray[RCTBridgeFieldParamss]];
>
>   //将调用的信息先安模块各自指定的队列分好
>   NSMapTable *buckets = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory
>                                                   valueOptions:NSPointerFunctionsStrongMemory
>                                                       capacity:_moduleDataByName.count];
>   [moduleIDs enumerateObjectsUsingBlock:^(NSNumber *moduleID, NSUInteger i, __unused BOOL *stop) {
>     RCTModuleData *moduleData = _moduleDataByID[moduleID.integerValue];
>     dispatch_queue_t queue = moduleData.methodQueue;
>     if (!set) {
>       set = [NSMutableOrderedSet new];
>       [buckets setObject:set forKey:moduleData.methodQueue];
>     }
>     [set addObject:@(i)];
>   }];
>   //按队列来批量执行相应的调用
>   for (dispatch_queue_t queue in buckets) {
>     dispatch_block_t block = ^{
>       RCTProfileEndFlowEvent();
>       NSOrderedSet *calls = [buckets objectForKey:queue];
>       @autoreleasepool {
>         for (NSNumber *indexObj in calls) {
>           NSUInteger index = indexObj.unsignedIntegerValue;
>           //在各自模块上根据参数执行指定的方法
>           [self _handleRequestNumber:index
>                             moduleID:[moduleIDs[index] integerValue]
>                             methodID:[methodIDs[index] integerValue]
>                               params:paramsArrays[index]];
>         }
>       }
>     };
>     if (queue == RCTJSThread) {
>       [_javaScriptExecutor executeBlockOnJavaScriptQueue:block];
>     } else if (queue) {
>       dispatch_async(queue, block);
>     }
>   }
> }
> ```
>
> _handleRequestNumber根据模块的ID、方法ID以及参数来调用具体的函数：
>
> ```objective-c
> - (BOOL)_handleRequestNumber:(NSUInteger)i
>                     moduleID:(NSUInteger)moduleID
>                     methodID:(NSUInteger)methodID
>                       params:(NSArray *)params
> {
>   RCTModuleData *moduleData = _moduleDataByID[moduleID];
>   id<RCTBridgeMethod> method = moduleData.methods[methodID];
>   [method invokeWithBridge:self module:moduleData.instance arguments:params];
> }
> ```
>
> 回调函数
>
> 当有回调函数的时候，之前看到__nativeCall会将callbackID放置在参数中，对应的回调函数插入到_callbacks中保存，js将该ID传递给native，native就是通过该ID来找到对应的回调函数的。
>
> ```objective-c
> RCT_EXPORT_METHOD(showNativeView:(NSDictionary*)params callback:(RCTResponseSenderBlock)callback) {
>   GLNativeTestViewController *nativeVC = [GLNativeTestViewController new];
>   [[AppDelegate appDelegate].navigationController pushViewController:nativeVC animated:NO];
>   callback(@[@{@"data": @"backdata"}]);
> }
> //生成的函数签名
> showNativeView:(RCTResponseSenderBlock)callback
> 比如GLSpringboard定义的回调函数，当通过函数签名如果发现参数的类型是RCTResponseSenderBlock，则js传递过来的参数就是回调函数的ID，native层就会根据该ID以及RCTResponseSenderBlock提供的参数来回调相应的js回调函数，整个调用过程可以简单的用下图表示。
>
> ```
>
> over