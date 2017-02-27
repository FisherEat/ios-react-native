### React-Native研究文档 At Office

*react-native热部署技术必然普及到各个 app模块中，无论是集成到现有app中，还是成为一项与H5共存的技术，对于前端开发人员来说，该技术必须掌握。对于大型项目而言，热部署技术会非常方便实时更新活动内容、更新产品种类，其利处不言而喻*

#### 开发环境搭建

#### 运行Facebook 的UIExplorer项目

> ```javascript
> 真机调试该项目时，报 'no url script' 错误，原因是我只注释了jsCodeUrlLocation,并没有按照facebook的提示方法将 js文件转化成main.bundle文件。具体步骤在UIExplorer的AppDelegate的注释中。
>
> /**
> * OPTION 2
> * Load from pre-bundled file on disk. To re-generate the static bundle, `cd`
> * to your Xcode project folder and run
> *
> * $ curl 'http://localhost:8081/Examples/UIExplorer/UIExplorerApp.ios.bundle?platform=ios' -o main.jsbundle
> *
> * then add the `main.jsbundle` file to your project and uncomment this line:
> * significant:when you generate it ,after that, you should add the `main.jsbundle` file to your project!!!
> */
> sourceURL = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
> ```

#### 项目结构目录

##### 新建项目目录结构

> 新建项目目录结构如下
>
> ```shell
> ├── node_modules #js依赖库
> ├── android      #android项目
> ├── index.android.js #安卓项目启动文件
> ├── ios          #ios项目
> ├── index.ios.js #ios项目启动文件
> ├── package.json #依赖库引用文件，作用类似 iOS中的Spec文件
> ├── app #自己创建的文件，可以将js文件放置在此
> ```
>
> voe

##### package.json文件详解

> 1. 详细内容可以参考这里:https://github.com/ericdum/mujiang.info/issues/6/
>
> 2. package.json文件用于创建项目，如果你这个项目想做成开源项目，必须配置好这文件，别人再引用 `npm info xxx` `npm install XXX` 。所以该文件可以被高度定制。
>
> ```shell
> {
> "name": "rnToday_2",
> "version": "0.0.1",
> "private": true,
> "scripts": {
> "start": "node node_modules/react-native/local-cli/cli.js start"
> },
> "dependencies": {
> "react": "^0.14.7",
> "react-native": "^0.22.2",
> "react-native-progress": "^2.2.2",
> "react-native-modalbox": "^1.3.2"
> }
> }
>
> #必须的字段有：
> name 、version
> ```
>
> 1. 该文件要求是严格的json，否则会报错。
>
> 2. over

#### ES6语法部分

##### 基本字符串

##### 数组以及数组遍历

> 1. `Array.from()`
>
> ```javascript
> #该方法用来将类似数组的对象和可遍历对象(set、map)转化为真正的数组
> let arrayLike = { '0': 'a', '1': 'b', '2': 'c', length: 3}
> //es5
> var arr1 = [].slice.call(arrayLike); // ['a', 'b', 'c']
> //es6 
> var arr2 = Array.from(arrayLike); //['a', 'b', 'c']
> Array.from('hello');
> //['h', 'e', 'l', 'l', 'o']
> #扩展运算符也可以将某些数据结构转为数组，但是无length的对象除外
> #该函数可以接受第二个参数
> Array.from(arrayLike, x => x * x) 
> //等同于
> Array.from(arrayLike).map(x => x * x)
>
> ```
>
> 1. `Array of`
>
> ```javascript
> #该函数用于将一组值转为数组
> Array.of(3, 11, 8) //[3， 11， 8]
> #该方法用来弥补数组构造函数Array()的不足
> ```
>
> 1. ``copyWithin`
>
> ```javascript
> #指定复制
> Array.prototype.copyWithin(target, start = 0, end = this.length)
> [1, 2, 3, 4, 5].copyWithin(0, 3)
> // [4, 5, 3, 4, 5]
> // 将3号位复制到0号位
> [1, 2, 3, 4, 5].copyWithin(0, 3, 4)
> // [4, 2, 3, 4, 5]
> ```
>
> 1. `find()` & `findIndex()`
>
> ```javascript
> #找出第一个符合条件的数组成员。
> [1,2,3,4,5,-1].find((n) => n < 0)
> // -1
> [1, 5, 10, 15].find(function(value, index, arr) {
> return value > 9;
> }) // 10
> [1, 5, 10, 15].findIndex(function(value, index, arr) {
> return value > 9;
> }) // 2
> ```
>
> 1. `fill`
>
> ```javascript
> #fill方法用来给定值，填充一个数组
> ['a', 'b', 'c'].fill(7)
> // [7, 7, 7]
> new Array(3).fill(7)
> // [7, 7, 7]
> ```
>
> 1. `entries()`& `keys()` & `values()`
>
> ```javascript
> #keys()是对键名的遍历、values()是对键值的遍历，entries()是对键值对的遍历。
> for(let index of ['a', 'b'].keys()) {
> console.log(index);
> }
> //0
> //1
> for (let elem of ['a', 'b'].values()) {
> console.log(elem);
> }
> //'a'
> //'b'
> for (let [index, elem] of ['a', 'b'].entries()) {
> console.log(index, elem);
> }
> //0 'a'
> //1 'b'
> #如果不是用for...of 循环。可以手动点用遍历器对象的next方法，进行遍历
> let letter = ['a', 'b', 'c'];
> let entries = letter.entries();
> console.log(entries.next().value); // [0, 'a']
> console.log(entries.next().value); // [1, 'b']
> console.log(entries.next().value); // [2, 'c']
> ```
>
> 1. `includes()`
>
> ```javascript
> #Array.prototype.includes方法返回一个布尔值，表示某个数组是否包含给定的值，与字符串的includes方法类似。
> [1,2,3].includes(2); //true
> [1,3,NaN].includes(NaN); //true
> [1, 2, 3].includes(3, 3);  // false
> [1, 2, 3].includes(3, -1); // true
> #等同于
> if (arr.indexOf(el) !== -1) {
> // ...
> }
> #几种方法
> // forEach方法
> [,'a'].forEach((x,i) => log(i)); // 1
> // filter方法
> ['a',,'b'].filter(x => true) // ['a','b']
> // every方法
> [,'a'].every(x => x==='a') // true
> // some方法
> [,'a'].some(x => x !== 'a') // false
> // map方法
> [,'a'].map(x => 1) // [,1]
> // join方法
> [,'a',undefined,null].join('#') // "#a##"
> // toString方法
> [,'a',undefined,null].toString() // ",a,,"
> ```
>
> 1. `数组推导`
>
> ```javascript
> [for (i of [1, 2, 3]) i * i];
> // 等价于
> [1, 2, 3].map(function (i) { return i * i });
> [for (i of [1,4,2,3,-8]) if (i < 3) i];
> // 等价于
> [1,4,2,3,-8].filter(function(i) { return i < 3 });
> //数组推导支持if语句
> var years = [ 1954, 1974, 1990, 2006, 2010, 2014 ];
> [for (year of years) if (year > 2000) year];
> // [ 2006, 2010, 2014 ]
> ```
>
> 1. `数组的map方法`
>
> ```javascript
> #原型方法如下
> var mappedArray = array.map(callback[, this.Object]);
> callback: 要对每个数组元素执行的回调函数
> thisObject: 在执行回调函数时定义的this对象
> var array = ['gaolong', 'xiaoming', 'xiaohua', 'xiaohong'];
> array.map((element, index , this) => {
> console.log(element);
> })
> ```
>
> 1. over

##### Set和Map属性

> 1. Set顾名思义就是集合，不存在相同的数据
>
> ```javascript
> var s = new Set()
> [2,34,4,5,5,6,2,2,2,3].map(x => s.add(x))
> for (let i of s){console.log(i)}
> //2,34,4,5,6
> set可以接受数组进行初始化
> set.add(value)
> set.delete(value)
> set.size
> set.has(value)
> set.clear()
> set.keys()
> set.values()
> set.entries()
> forEach()
> let set = new Set([1, 2, 3]);
> set.forEach((value, key) => console.log(value * 2) ) //2, 4, 6
> 扩展运算... 
> let set = new Set(['red', 'green', 'blue'])
> let arr = [...set] //['red', 'green', 'blue']
> let a = new Set([1, 2, 3]);
> let b = new Set([4, 3, 2]);
> // 并集
> let union = new Set([...a, ...b]);
> // [1, 2, 3, 4]
> // 交集
> let intersect = new Set([...a].filter(x => b.has(x)));
> // [2, 3]
> // 差集
> let difference = new Set([...a].filter(x => !b.has(x)));
> // [1]
>
> ```
>
> 1. `WeakSet`
>
> ```javascript
> #WeakSet的成员只能是对象，里面的对象都是弱引用，即垃圾回收机制不考虑WeakSet对该对象的引用
> var a = [[1,2], [3,4]];
> var ws = new WeakSet(a);
> WeakSet.add(obj)
> WeakSet.delete(obj)
> WeakSet.has(obj)
> ```
>
> 1. `Map`
>
> ```javascript
> #js的对象，本质上是键值对的集合，但是只能用自付出啊你当作键。Map结构的键可以是各种类型的值(包括对象)。
> var m = new Map();
> var o = {p: "Hello world"};
> m.set(o, "content");
> m.get(o) //"content"
> m.has(o) //true
> m.delete(o)//true
> #作为构造函数，Map也可以接受一个数组作为参数,该数组的成员是一个个表示键值对的数组
> var map = new Map([["name"], "张三"], ["title", "Author"]);
> map.size //2,
> map.has("name") //true
> map.get("title") //true
> map.get("title") //"Author"
> #Map构造函数接受数组作为参数时，实际上是执行的是下面的算法
> var items = [
> ["name", "gaolong"]
> ["age", 18]
> ];
> var map = new Map();
> items.forEach(([key, value]) => map.set(key, value))
> #map中的键根据引用不同而不同，即内存地址不一样、即使字符串一样也是不同的键
> #实例方法
> map.size //返回总数
> map.set(key, value) //如果key已经有值，则键值会被更新，否则就新生成该键。
> let map = new Map().set(1, 'a').set(2, 'b').set(3, 'c');//链式写法
> map.get(key)
> map.has(key)
> map.delete(key)
> map.clear() //删除所有
> //遍历
> let map = new Map([['F', 'no'], ['T', 'yes']])
> for (let key of map.keys()) {
> console.log(key) 
> }//"F" , "T"
> for (let value of map.values()) {
> console.log(value)
> }
> for (let item of map.entries()) {
> console.log(item[0], item[1]);
> }// "F" "no"; "T" "yes"
> //或者
> for (let [key, value] of map.entries()) {
> console.log(key, value);
> }
> //简写
> for (let [key, value] of map) {
> console.log(key,value);
> }
> //map结构转数组结构
> let map = new Map([
> [1, 'one'],
> [2, 'two'],
> [3, 'three'],
> ]);
> [...map.keys()]
> // [1, 2, 3]
> [...map.values()]
> // ['one', 'two', 'three']
> [...map.entries()]
> // [[1,'one'], [2, 'two'], [3, 'three']]
> [...map]
> // [[1,'one'], [2, 'two'], [3, 'three']]
> //Map实现filter方法过滤数据
> let map0 = new Map() 
> .set(1, 'a')
> .set(2, 'b')
> .set(3, 'c')
> let map1 = new Map(
> [...map0].filter(([k, v]) => k < 3)
> )
> //输出{1 => 'a', 2 => 'b}
> ```
>
> 1. `Map与其他数据结构互相转换`
> ```javascript
> #map转为数组
> let map = new Map().set(true, 3).set({foo: 3}, ['abc'])
> [...map]
> #map 转为对象
> function strMapToObj(strMap) {
> let obj = Object.create(null);
> for (let [k,v] of strMap) {
> obj[k] = v;
> }
> return obj;
> }
> let myMap = new Map().set('yes', true).set('no', false);
> strMapToObj(myMap)
> //{yes: true, no:false}
> function objToStrMap(obj) {
> let strMap = new Map();
> for (let k of Object.keys(obj)) {
> strMap.set(k, obj[k]);
> }
> return strMap;
> }
> objToStrMap({yes: true, no: false})
> // [ [ 'yes', true ], [ 'no', false ] ]
> #map转为JSON
> 对于map的键名都是字符串的情况，可以转为对象json
> function strMapToJson(strmap){
> return JSON.stringify(strMapToObj(strmap));
> }
> let myMap = new Map().set('yes', true).set('no', false);
> strMapToJson(myMap)
> //{"yes": true, "no":flase}
> 对于map的键名有非字符串，这时可以选择转为 数组json
> function mapToArrayJson(map) {
> return JSON.stringify([...map]);
> }
> let myMap = new Map().set(true, 7).set({foo: 3}, ['abc']);
> mapToArrayJson(myMap)
> // '[[true,7],[{"foo":3},["abc"]]]'
> #json 转map
> function jsonToStrMap(jsonStr) {
> return objToStrMap(JSON.parse(jsonStr));
> }
> jsonToStrMap('{"yes":true,"no":false}')
> // Map {'yes' => true, 'no' => false}
> ```
>
> 1. `WeakMap`
> 2. over

##### 变量以及属性

##### 函数

##### 类

##### Symbol类、Promise类

##### 异步实现

#### react-native调试

##### 调试

1. 使用模拟器调试时，通过快捷键 ` control + ⌘ + z`或者` D + ⌘ `选择调试项。

##### 刷新

1. 选择开发者菜单中的`Reload`项或者模拟器上按下`⌘ + r`即可重新加载应用的js代码。如果增加了新资源，则需要重新编译才能生效。
2. 对于`⌘ + r`刷新失效，是因为模拟器Keyboard没有打开`Connect Hardware keyboard`，勾选上打开就好了。

##### Chrome开发者工具

1. 在Chrome中调试js代码，需要在开发者菜单中选择`Debug in Chrome`，这会打开一个新的[http://localhost:8081/debugger-ui](http://localhost:8081/debugger-ui) tab页。在Chrome下，按下 `⌘ + option + i`来打开开发工具控制台。打开[有异常时暂停（Pause On Caught Exceptions）](http://stackoverflow.com/questions/2233339/javascript-is-there-a-way-to-get-chrome-to-break-on-all-errors/17324511#17324511)选项，能够获得更好的开发体验。还可以查看断点。调试非常方便。

##### React开发工具

##### 实时刷新

1. iOS平台上选择开发菜单中的`Enable Live Reload`即可开启js代码自动刷新。

##### FPS每秒帧数监视器

#### react-native基本原理

#### react-native布局篇

##### flex布局详解

> 1. flex是弹性沙盒，按比例布局，具体的css特性有：
>
> ```javascript
> content: {
> flex: 1,
> flexDirection: 'row'/'column'
> }
> #css中View/Text组件的横向和纵向布局，flex是比例值。
> <View style={styles.style_0}>
> <View style={styles.style_1}></View>
> <View style={styles.style_1}></View>
> <View style={{flex:10}}></View>
> </View>
> style_0:{
> flex:1,
> },
> style_1:{
> flex: 5,
> height:40, 
> borderWidth: 1,  
> borderColor: 'red',
> }
> #当一个(元素)组件，定义了flex属性时，表示改元素是可伸缩的。当然flex的属性值是大于0的时候才伸缩，其他小于和等于0的时候不伸缩，例如：flex:0, flex:-1等。上面的代码，最外层的view是可伸缩的，因为没有兄弟节点和他抢占空间。里层是3个view,可以看到三个view的flex属性加起来是5+5+10=20,所以第一个view和第二个view分别占1／4伸缩空间， 最后一个view占据1／2空间。
>
> #alignSelf:对齐方式
> alignSelf主要有四种对齐方式：flex-start,flex-end,center,auto,stretch。
> #alignItems(水平垂直居中)是alignSelf的变种，两者功能相似，可用于#水平居中。
> #justifyContent用于垂直居中，属性较多.
>
> ```
>
> 1. css属性是父视图为子视图在其中的布局在而设置的。
>
> 2. `Flexbox`
> ```javascript
> $ flexDirection : 'row' ,'column'
> $ justifyContent: 'flex-start', 'center', 'flex-end', 'space-between', 'space-around'
> $ alingItems: 'flex-start', 'center', 'wrap'
> ```
>
> 1. over
> ```javascript
> $
> ```
>
> 1. over
>    ​

#### react-native基本组件

##### Component的生命周期

##### 导航栏(TabBarIOS)

> *TabBarIOS用来实现抽屉布局,目前github上有很多优秀的tabbar组件，但是我们这里自己实现，用fabebook react-native提供的TabBarIOS TabBarIOS*
>
> 1. ​

##### 视图

##### 文本

> 1. TextInput组件的一些参数
>
> | 属性名/方法                         | react                                |      |
> | ------------------------------ | ------------------------------------ | ---- |
> | autoCorrect\autoFocus\editable | 自动纠错\自动聚焦\相当于readyOnly               |      |
> | onChangeText                   | 有点类似PC的onInput事件，但传入的是value值，而不是事件对象 |      |
> | onChange                       | onChange，输入内容改变时触发                   |      |
> | keyboardType                   | 用于弹出一个输入法的面板                         |      |
> | maxLength \multiline\password  | 最大长度\用它实现text\实现密码                   |      |
> | onBlur                         | onBlurs                              |      |
> | clearButtonMode                | iOS独有                                |      |
>
> 1. over.

##### 图片

##### ActivityIndicator

##### DatePickerIOS

##### ListView

> 1. ListView如果被其他View包着，必须定义父元素flexbox
> 2. ​

##### 动画

##### 按钮

> 1. react native提供四个组件让包裹在其中的东西能拥有可点击的能力
>
> `TouchableHighlight`、`TouchableNativeFeedback`、`TouchableOpacity`
>
> `TouchableWithoutFeedback`。想与原生保持一致就用第二个。
>
> 1. react按钮的事件处理，按钮关联了四个事件
>
> 2. 按钮按下事件：onPress，按下并松开按钮，会触发。
> 3. 按钮长按事件：onLongPress ，按钮按住不松开，会触发。
> 4. 按钮按下事件：onPressIn ，按下按钮不松开，会触发。
> 5. 按钮松开事件：onPressOut，按下按钮后松开，或按下按钮后移动手指到按钮区域外，会触发。
>
> 6. `this.state`，按钮绑定事件报错
>
> 按钮绑定事件报`this.state is not a function`的错误。原因是没有将this传给按钮。需要这么绑定事件：`this._onPress.bind(this)`。后面添加`bind(this)`
>
> 1. over.

#### 集成react-native到现有项目

##### 现有项目集成react-native

> *已有项目添加RN有两种方式（已知），一种是通过pod直接安装，pod search reac搜索相关的报，进行安装即可，但是目录这个发布方式，安装的包都比较旧，所以采用第二种方式比较合适，具体步骤如下：*
>
> 1. 在项目的根目录下添加`package.json文件`，添加好后，在当前目录下运行`npm install` 安装相关依赖，需要在项目根目录导入react和react-native两个框架。
>
> ```shell
> {
> "name": "Demos",
> "version": "0.0.1",
> "private": true,
> "scripts": {
> "start": "react-native start"
> },
> "dependencies": {
> "react": "0.4.5", 
> "react-native": "^0.22.1",
> }
> }
>
> #注：依赖中必须导入react和react-native两个框架，而且两个框架的版本需要控制。
>
> ```
>
> 1. 添加入口文件：在项目根目录下添加`index.ios.js`，添加好后，在当前添加相关注册代码。
>
> 2. Podfile中添加相关依赖：
>
> 其中path目录志向安装好的react-native路径。subspecs指定需要安装的模块，这里尽量将相关模块都安装，以免影响后期升级。添加后，在当前目录下，运行`pod install`安装react-native相关依赖。
>
> ```shell
> pod 'React', :path => './node_modules/react-native', :subspecs => [
> 'Core',
> 'RCTImage',
> 'RCTNetwork',
> 'RCTText',
> 'RCTWebSocket',
> 'ART',
> 'RCTActionSheet',
> 'RCTGeolocation',
> 'RCTPushNotification',
> 'RCTSettings',
> 'RCTVibration',
> 'RCTLinkingIOS',
> ]
> ```
>
> 1. 使用react-native：添加一个UIView，在View中添加react-native入口视图，代码如下：
>
> ```javascript
> jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
> //jsCodeLocation = [NSURL URLWithString:@"http://192.168.1.116:8081/index.ios.bundle?platform=ios&dev=false"];
> //jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
> RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation                                                    moduleName:@"XTMedic"                                  initialProperties:@{@"classname": classname}  launchOptions:nil];
> rootView.frame = [UIScreen mainScreen].bounds;
> [self.view addSubView:rootView]
> ```
>
> 1. 恶心的报错，package.json文件配置不全！！！
> ```shell
> 有好几个恶心的报错：
> "Unable to resolv module LinkedStateMixin from /User/gaolong/Desktop/TextRN_Native/node_modules/react-native/Libraries/react-native/react-native.js:Unable to find this module map or any of the node_modules directories under /User/node_modules/LinkedStateMixin and its parent directoies"
>
> "This might be relate to https://github.com/facebook/react-native/issues/4968 To resolve try the following: 
> 1. Clear wathman watched: `watchman watch-del-all`
> 2. Delete the `node_modules` folder `rm -rf node_modules && npm install`
> 3.Reset packager cache: `rm -fr $TMPDIR/react-*` or `npm start -- --reset-    -cache`"
>
> 这个报错的解决方案与报错的内容不符，一直没有解决。
> 不过原因可能是：
> 1.package.json文件配置不正确
> 配置的dependencies不全，react和react-native都要配置，因为react-native有依赖react的库！
> 2.Podfile文件，React的路径配置不正确
> 配置的React路径 './node_modules/react-native'
> 3.React 的js文件 没有语法错误
> 4.node配置中没有react依赖库
> 服务器系统配置的node不正确，路径等问题导致无法调试，考虑重新配置node\npm 等
> 5.
> 注：最后小编发现，尝试对项目中不配置react,只配置react-native，发现报错！！！，如果版本不一致呢，比如react-native依赖react，而导入的react的版本比较老，也可能报错！
> ```
>
> 1. 启动项目
>
> ```shell
> $ cd /项目目录
> $ cd node_modules/react-native
> $ npm run start 
> #通过上述方式启动node server
> ```
>
> 1. over.

#### 新项目使用react-native热部署

#### React与Native的交互

*用react写出的页面要展示在app中，首先需要给react页面一个容器，在AppDelegate或者viewcontroller中这样实现rootviewcontroller.view = react.view 或者 [self.view addSubView react.rootview]，rootview使用RCTRootView初始化并且指定classname的视图。*

##### react跳native && react向native传递数据 && 回调数据

> 1. react页面

##### native跳react && native向react传递数据

> 1. native跳到react页面，需要给react一个容器，即ViewController，或者是UIScreen.
>
> ```javascript
> if (classname == 'Home') {
> componet = MainHomeComponent;
> title = '首页';
> }else if (classname == 'Search' {
> componet = SearchHomeComponent;
> }
> #根据native传过来的不同的classname来显示不同的component
> ```
>
> 1. over.

##### react调用原生方法

> 1. react调用原生方法使用的是 `NativeModules`模块
>
>    ```javascript
>    #react写法
>    var NativeBoard = NativeModules.GLSpringBoard
>    pushToNative() {
>           var params = {code: 10000, msg: 'success'}
>           callback = () => {}
>           NativeBoard.showNativeView(params, function(callback){
>               console.log(callback)
>           })
>     }
>    #native写法
>    @interface GLSpringBoard : NSObject<RCTBridgeModule>//加上这个委托
>    RCT_EXPORT_MODULE(); 
>    RCT_EXPORT_METHOD(showNativeView:(NSDictionary*)params callback:(RCTResponseSenderBlock)callback) {
>        [UIManager showViewControllerWithName:NSStringFromClass([GLButtonDemoViewController class]) params:@{@"className": @""}];
>    }
>    - (dispatch_queue_t)methodQueue
>    {
>        return dispatch_get_main_queue();
>    }
>    //native和react的方法名和参数必须一致，否则会报错
>    ```
>
> 2. over

#### 经典报错

##### 空格引起的报错或者显示错误

> 1. `} from 'react-native'`这个字段和前面的`}`要保持空格，否则报错
> 2. `return <Text>`要保持空格，而且不能超过一个空格，否则显示错误。
> 3. `#ff0o00`  `#ffd5f` 这种颜色都是报错，因为`o`不是颜色值、颜色必须要为3个或者6个字符串
> 4. 遇到一个报错，发现是0.0
> ```javascript
> import React , {
> Text,
> Image,
> }from 'react-native';
> 发现 from 字段和 } 之间没有空格导致报错，找不到react-native 这个模块
> ```
>
> 1. ​
>
>

