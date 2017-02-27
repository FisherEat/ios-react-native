#### 现有Native项目集成react-native

##### 现有项目集成react-native

> *已有项目添加RN有两种方式（已知），一种是通过pod直接安装，pod search react搜索相关的包，进行安装即可，但是目录这个发布方式，安装的包都比较旧，所以采用第二种方式比较合适，具体步骤如下：*
>
> 这里提供一个参考项目：MyGLDemo，https://github.com/schillerGao/MyGLDemos.git  记得启动时先`npm install`
>
> 这里提供一篇详细的参考文档：http://kiwi.saylove.today/?p=124 已有项目添加react-native
>
> 可以先参考官方的文档：http://reactnative.cn/docs/0.24/embedded-app-ios.html#content，再与本文档比较对比，本文档以记录踩过的坑为主。
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
> "react": "0.14.5", 
> "react-native": "^0.22.1",
> }
> }
>
> #注：依赖中必须导入react和react-native两个框架，而且两个框架的版本需要控制。
> ```
>
> 1. 添加入口文件：在项目根目录下添加`index.ios.js`，添加好后，在当前添加相关注册代码。
> 2. 项目Podfile中添加相关依赖：
>
> 其中path目录指向安装好的react-native路径。subspecs指定需要安装的模块，这里尽量将相关模块都安装，以免影响后期升级。添加后，在当前目录下，运行`pod install`安装react-native相关依赖：
>
> ```shell
> //在你的podfile文件中添加这么一段，通过私有库的形式加载reactnative依赖
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
>
> //细心的你去node_modules/react-native/Libraries目录下发现其实上面这些react的原生组件都在这个Libraries目录下，因此是可以通过Cocoapods私有库的形式加载到我们的native项目的。我们可以根据需要集成的想要的native组件，但是facebook是希望我们尽量全部导入这些native组件，以免后期升级还需再次导入。
> ```
>
> 1. 使用react-native：添加一个UIView，在View中添加react-native入口视图（我的MyGLDemo是在ForthViewController即第四个tab中集成rn的），代码如下：
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
>
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
> 1. 启动项目(我的MyGLDemos中有这么一个脚本，作用如下：)
>
> ```shell
> //native项目中的集成react还是需要node服务器来调试代码的，因此需要npm 启动react-native
> $ cd /项目目录
> $ cd node_modules/react-native
> $ npm run start 
> #通过上述方式启动node server
>
> 也可以用下面这个脚本start.sh(在项目的package.json存在的目录下创建这个脚本即可，每次启动app是 执行一下该脚本  sh start.sh)
> #!/bin/bash
>
> ################
> #
> # created by schiller
> #
> ################
>
> set -e
> set -x
>
> CURRENT_WORK_DIR=`echo ${0%/*}`
>
> if [ -d ${CURRENT_WORK_DIR} ];then
> cd ${CURRENT_WORK_DIR}
> fi
>
> SCRIPT_PATH=`pwd`
> cd "${SCRIPT_PATH}"
>
> npm_run()
> {
> cd node_modules/react-native
> npm run start
> }
>
> npm_run
> ```
>
> 1. over.

#### 