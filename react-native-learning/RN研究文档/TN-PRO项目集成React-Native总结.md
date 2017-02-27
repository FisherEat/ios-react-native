#### TN-PRO项目集成React-Native总结

*TN-Pro807版本中集成RN，该集成过程中有许多坑，现在将集成过程详细描述。*

#### 集成过程

##### 配置package.json，`npm install`

```sh
#package.json文件配置如下：
{
  "name": "reactTuNiu",
  "version": "0.0.1",
  "private": true,
  "scripts": {
      "start": "react-native start"
  },
  "dependencies": {
      "react": "^0.14.5",
      "react-native": "^0.21.0"
  }
}
#执行npm install导入node_modules
```

##### 配置`Podfile`，`pod install --no-repo-update --verbose`

```sh
#Podfile文件配置如下：
pod 'React', :path => './node_modules/react-native', :subspecs => [
    'Core',
    'RCTImage',
    'RCTNetwork',
    'RCTText',
    'RCTWebSocket',
    'ART',
    'RCTActionSheet',
    'RCTGeolocation',
    'RCTPushNotification',
    'RCTSettings',
    'RCTVibration',
    'RCTLinkingIOS',
]
#根据查看React.spec查找我们需要的React库的私有库。
#执行pod install --no-repo-update --verbose方式导入native代码
#该方式导入的是从node_modules/react-native/Libraries中软链接和.h文件合集，所以实际上native代码还是在node_modules文件夹中。
```

##### 使用与集成react

```objective-c
#创建TNSpringBoard文件，用于桥接和管理native与react的通讯
/**
*.h文件
*/
#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
@class RCTRootView;
@class RCTBridge;

@interface TNSpringBoard : NSObject<RCTBridgeModule>

+ (RCTRootView *)rctRootViewWithClassName:(NSString *)className bridge:(RCTBridge *)bridge params:(NSDictionary *)params;

@end

/**
 *.m文件
 */
  
#import "TNSpringBoard.h"
#import "RCTRootView.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
@implementation TNSpringBoard
RCT_EXPORT_MODULE();

+ (RCTRootView *)rctRootViewWithClassName:(NSString *)className bridge:(RCTBridge *)bridge params:(NSDictionary *)params {
    if (!params) {
        params = [NSDictionary dictionary];
    }
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"Demos" initialProperties:@{@"className" :className, @"params": params}];
    rootView.frame = [UIScreen mainScreen].bounds;
    return rootView;
}
RCT_EXPORT_METHOD(showNativeView:(NSDictionary*)params callback:(RCTResponseSenderBlock)callback) {
    //[[GLUIManager sharedManager] showViewControllerWithName:NSStringFromClass([GLButtonDemoViewController class]) params:@{@"className": @""}];
    [ForthViewController push];
}

RCT_EXPORT_METHOD(query:(NSString *)queryData successCallback:(RCTResponseSenderBlock)responseSender) {
    NSString *ret = @"ret";
    responseSender(@[ret]);
}
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}
@end
```

##### 使用React创建View

```objective-c
#使用ReactView
<RCTBridgeDelegate>
- (void)initReactView
{
    _bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
    RCTRootView *rootView = [TNSpringBoard rctRootViewWithClassName:@"ForthReactView" bridge:_bridge params:nil];
    rootView.frame = self.view.bounds;
    [self.view addSubview:rootView];
}
- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
    //jsCodeLocation = [NSURL URLWithString:@"http://192.168.1.116:8081/index.ios.bundle?platform=ios&dev=false"];
    //jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
    return jsCodeLocation;
}
```

##### 启动react-native与调试脚本`npm_run.sh`

```sh
#创建启动react-native的脚本，方便调试
#!/bin/bash
################
#
# created by schiller
#
################
set -e
set -x
CURRENT_WORK_DIR=`echo ${0%/*}`
if [ -d ${CURRENT_WORK_DIR} ];then
   cd ${CURRENT_WORK_DIR}
fi
SCRIPT_PATH=`pwd`
cd "${SCRIPT_PATH}"
npm_run()
{
  cd node_modules/react-native
  npm run start
}
npm_run
```

##### 代码版本控制的两种方式

- 在集成过程中我们就是否将 node_modules纳入版本控制纠结了许久。对比两种方式，主要是：

  ```
  如果将node_modules纳入版本控制，pod install直接软链接node_modules里的native代码。方便调试和使用，其他不要开发rn的人无需操心。关键问题在于node_modules多达9万个文件，实在是没有纳入版本控制的必要；
  如果不将node_modules纳入版本控制，则pod install必须放开权限，因为要用到node_modules里的native代码，放开权限是一方面，另一方面导致比较大的学习成本，每个人都需要执行pod install导入我们的代码，否则编译不过。
  ```

- `.gitignore`

  ```
  #如果忽略掉node_modules，应该在.gitignore中加入node_modules	
  ```
  ​