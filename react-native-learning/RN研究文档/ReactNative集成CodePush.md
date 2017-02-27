##### ReactNative集成CodePush

#### 注册CodePush准备工作

##### 安装CodePush cli

```sh
$ npm install -g code-push-cli
```

##### 注册CodePush账号

```sh
$ code-push register
#我用的是github的账号，github登陆
$ username: schillerGao
$ password: gL13512740718
#不同的地方登陆会生成不同的access key token,以供登录使用
```

然后选择github或者microsoft账号授权登录

##### 获取Access key Token,在终端输入，进行登录

```sh
pZhVI2YLjwr0rsBKSX-99kuDVzasNyGfqThbb //途牛公司
_TfHaNWF-Fa_gKS-aaZtbEBlVJr5NyGfqThbb  //家中
```

##### 登录成功后，我们就可以添加一个CodePush应用，下面的`WaMeiRN`为我的应用名称

```sh
$ code-push app add WaMeiRN	
```

##### 查看刚刚生成的应用

成功后我们可以看到有两个发布键值。一个Production是对应生产环境的，一个Staging是对应开发环境的，还可以添加其他的发布键值，这个值在我们后天的集成工程中要用到。

```sh
Successfully added the "WaMeiRN" app, along with the following default deployments:
┌────────────┬───────────────────────────────────────┐
│ Name       │ Deployment Key                        │
├────────────┼───────────────────────────────────────┤
│ Production │ 5oN5JLQyg1XjLVp0gbPZtggJmlJxNyGfqThbb │
├────────────┼───────────────────────────────────────┤
│ Staging    │ 4ffenKe0DpVPy2nZbGBhuqkSog0SNyGfqThbb │
└────────────┴───────────────────────────────────────┘

#CodePushTest
Successfully added the "CodePushTest" app, along with the following default deployments:
┌────────────┬───────────────────────────────────────┐
│ Name       │ Deployment Key                        │
├────────────┼───────────────────────────────────────┤
│ Production │ KCG9IuksYaoTo99xM_UwdFhZzdZVNyGfqThbb │
├────────────┼───────────────────────────────────────┤
│ Staging    │ Dx8yfybibGC6Ye7WceymkTxP_MZLNyGfqThbb │
└────────────┴───────────────────────────────────────┘

```

#### 集成CodePush到项目中

*在项目工程中安装CodePush，一般有两种方法，一种是Cocoapods接入，一种是手动接入*

##### Cocoapods引入

```sh
$ cd 工程目录
$ npm install "react-native-code-push" --save

#修改Podfile文件,注意path路径指向的是CodePush.podspec这个文件，查看这个文件发现其实是从 下面这个git仓库获取源码的。
# s.source  = { :git => 'https://github.com/Microsoft/react-native-code-push.git', :tag => "v#{s.version}-beta" }
pod 'CodePush', :path => '../node_modules/react-native-code-push'
$ cd ...
$ pod intstall --no-repo-update --verbose

#如果报以下错误
 No podspec found for `CodePush` in `./node_modules/react-native-code-push`
原因是path路径不对哦 0.0
```

##### 手动引入

*在命令行下，cd到整个工程的根目录，安装CodePush*

```sh
$ npm install "react-native-code-push" --save
```

##### 查看`package.json`看是否安装正确，新增了以下引用！

```json
    "react-native-code-push": "^1.10.6-beta",
    "react-native-datetime": "^0.1.1",
    "react-native-geocoder": "^0.3.1",
    "react-native-keyboard-spacer": "^0.1.6",
    "react-native-maps": "^0.3.1",
    "react-native-modalbox": "^1.3.2",
    "react-native-navbar": "^1.2.2",
    "react-native-progress": "^2.2.2",
    "react-native-storage": "0.0.16",
    "react-native-store": "^0.4.1",
    "react-native-tab-navigator": "^0.2.16"


# 我的rnToday_2应用只增加了这么一行
  "react-native-code-push": "^1.11.0-beta",
```

##### 导入CodePush.xcodeproj

用XCode打开iOS工程文件，然后将`node_module/react-native-code-push/ios/CodePush.xcodeproj` 这个文件拖进工程文件的Libraries文件夹下。

##### 导入Apple静态库

进入工程的target，选择"Build Phases"，然后添加静态库 libCodePush.a，以及libz.tbd。

##### 配置`Header Search Paths`

. 添加完毕后，到“build Setting”选项卡里，修改“Header Search Paths”的目录，添加多一个路径：

```javascript
$(SRCROOT)/../node_modules/react-native-code-push
#这一步一定要配置，否则编译不过
```

##### 启动项目

*启动项目之前注意要npm install ,因为react和native代码发生了变化。*

```sh
$ cd xxx
$ npm install 
```

以上操作，即可成功集成CodePush。

##### 更改代码，Native集成

*在WNSpringboard，即jsCodeLocation存在的地方将该参数修改由CodePush来指定*

```objective-c
#import "CodePush.h"
NSURL *jsCodeLocation;
 
#ifdef DEBUG
  jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
#else
    jsCodeLocation = [CodePush bundleURL];
#endif
```

#####  修改info.plist文件

*在info.plist文件中，添加多一个键值，CodePushDeploymentKey，然后值对应为已经注册号的应用的Production或者Staging的DeploymentKey*

##### 修改JS代码

*在需要启动代码更新的位置里面，引用CodePush，并且调用CodePush的更新接口，这里一般选择componentDidMount()这个方法里面。*

```javascript
// Import the JavaScript module for CodePush:
import codePush from "react-native-code-push";
// Call the sync method from within the componentDidMount lifecycle event, to initiate a background update on each app start:

codePush.sync();
```

#### 集成CodePush案例说明

##### code-push常用指令

```sh
$ code-push login #登录
$ code-push logout 
$ code-push access-key ls 
$ code-push access-key rm <accessKey>
$ code-push app add <appName>

#code-push app相关命令
$ code-push app add 
$ code-push app remove/rm
$ code-push app list/ls
$ code-push app transfer 
#安装CodePush插件

#查看历史版本
$ code-push deployment history WaMeiRN Staging

#打包
$ react-native bundle --minify --entry-file ./index.ios.js --platform ios --bundle-output ./codepush.jsbundle --dev false
#code-push发布
$ code-push release <appName> <bundle目录> <targetBinaryVersion>
[--deploymentName <deploymentName>]默认staging
[--description <description>]更新描述（string）默认为null
[--mandatory]是否强制更新，默认false
[--disabled] 该版本客户端是否可以获得更新，默认为false
[--rollout]此更新推送的用户的百分比（string），默认值为null

#如：
$ code-push release WaMeRN  ~/WaMeiRN/codepush.jsbundle 1.0.0

$ code-push patch <appName> <deploymentName>
#如：
$ code-push patch WaMeiRN Production --des "Updated description" -r 50

#促进更新
$ code-push promote <appName> <sourceDeploymentName> <destDeploymentName>

–description, –des 描述 [string] [默认值: null]
–disabled, -x 该促进更新，客户端是否可以获得更新 [boolean] [默认值: null]
–mandatory, -m 是否强制更新 [boolean] [默认值: null]
–rollout, -r 此促进更新推送用户的百分比 [string] [默认值: null]

$ code-push promote WaMeiRN Staging Production 
```

##### 在需要热更新的工程中集成CodePush

*根据我上面的步骤，将CodePush集成到工程。*

##### 将原始bundle包打入工程

*这一步比较关键，我们需要通过react-native命令生成包，并且将该原始包打入工程。调试时注意将jsCodeLocation改为bundle加载方式，并且关掉Chrome调试器（这一步坑坏哥哥了）*

```sh
#打包
react-native bundle --minify --entry-file ./index.ios.js --platform ios --bundle-output ./main.ios.jsbundle --assets-dest ./
```

##### CodePush发布更新包

*这一步要格外注意版本号。有完整的版本号管理机制。另外一个注意点是info.plist文件中bundle version string的配置，要是三位字符串。如1.0.0*

```sh
$ code-push release WaMeiRN  ~/WaMeiRN/codepush.jsbundle 1.0.0 
#如果你的app bundle version = 1.0.0，首先将一个bundle直接打进你的app中，你code-push 的版本也应该是 1.0.0 ，然后将你更改后的js打成bundle，设置为 code-push的版本也是 1.0.0 ，push后估计过20分钟到半个小时再去刷新页面发现有更新了。
```

##### 再次运行1.0.0版本App，如果更新了就说明大功告成

*如果没有成功，可能是你发布的是Deployment版是Staging版，然后更新速度比较慢，需要等一两个小时再次去更新页面。第二个是你的js代码要配置好Codepush 异步更新代码。*

##### js更新机制

| iOS版本 | CodePush提交的release 版本 |                                          |
| ----- | --------------------- | ---------------------------------------- |
| 1.0.0 | 1.0.0                 | 会自动下载                                    |
| 0.0.9 | 1.0.0                 | An update is available but it is targeting a newer binary version than you are currently running.较新版本，不会自动下载 |
| 1.0.1 | 1.0.0                 | 不作处理                                     |

##### 坑

（1）这里有个坑，我在使用他们的方法打包资源并上传的时候，通过更新，app无法加载出资源文件！

所以我打包和上传的方式如下，MoxieSDKRN是我在CodePush注册的APP名称

```sh
1.打包 (图片＋js代码)
react-native bundle --entry-file index.ios.js --bundle-output ./bundle/main.jsbundle --platform ios --assets-dest ./bundle --dev false
2.上传
code-push release MoxieSDKRN ./bundle 1.0.0
```

 （2）这里另外一个坑是：

如上面的博客所说，你APP内plist文件写的版本号可能是1.0.0，所以你的reactjs打包上传的版本也要是1.0.0（而不是1.0.1这样递增），你需要和APP保持一致，然后服务器会根据你最新上传的且和APP一样的版本作为最新版。

查看版本记录可以使用下面的命令。

```sh
$ code-push deployment history CodePushTest Staging

result :
┌───────┬──────────────┬─────────────┬───────────┬─────────────┬───────────────────
│ Label │ Release Time │ App Version │ Mandatory │ Description │ Install Metrics       │
├───────┼──────────────┼─────────────┼───────────┼─────────────┼───────────────────
│ v1    │ an hour ago  │ 1.0.0       │ Yes       │             │ Active: 100% (1 of  │
│       │              │             │           │             │ Total: 1              │
└───────┴──────────────┴─────────────┴───────────┴─────────────┴───────────────────

```

##### 控制更新：

（1）弹窗提示更新

codePush.sync({ updateDialog: true, installMode: codePush.InstallMode.IMMEDIATE });

（2）下次启动时更新

codePush.sync();

##### 参考文档

1. http://www.codexiu.cn/android/blog/13978/
2. http://hammercui.github.io/post/react-native-android%E5%AE%9E%E6%88%98%EF%BC%9A4-CodePush/#JavaScript代码
3. https://github.com/Microsoft/code-push/tree/master/cli
4. https://github.com/Microsoft/react-native-code-push/blob/master/README.md

