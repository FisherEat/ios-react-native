#### 使用Pushy进行热更新

*Pushyreactnative.cn提供的付费项目，可以用来进行热更新。该平台的实现原理比起CodePush要简单些，有利于仿照该系统重写一个热更新平台。该热更新平台涉及iOS native端， 安卓native端和react-native端以及服务端增量更新。*

##### 参考文献

1. https://github.com/reactnativecn/react-native-pushy/blob/master/docs/guide3.md
2. https://github.com/reactnativecn/react-native-pushy
3. http://update.reactnative.cn/dashboard

##### 安装Pushy

在你的项目根目录下运行以下命令(不要输入开头的美元符号)：

```sh
#第一个命令每台电脑只需要执行一次
$ npm install -g react-native-update-cli rnpm
$ npm install --save react-native-update
$ rnpm link react-native-update
```

##### 配置Bundle URL(iOS)

// 文档建设中

在工程target的Build Phases->Link Binary with Libraries中加入libz.tbd、libbz2.1.0.tbd

在你的AppDelegate.m文件中增加如下代码：

```objective-c
// ... 其它代码

#import "RCTHotUpdate.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if DEBUG
  // 原来的jsCodeLocation
  jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
#else
  jsCodeLocation=[RCTHotUpdate bundleURL];
#endif
  // ... 其它代码
}
```

##### 登录与创建应用

在你的项目根目录下运行以下命令：

```sh
$ pushy login
email: <输入你的注册邮箱>
password: <输入你的密码>
#我依稀记得我的登录账号和密码分别是：
$ email: 1320681113@qq.com
$ password: gL13512740718
```

这会在项目文件夹下创建一个`.update`文件，注意不要把这个文件上传到Git等CVS系统上。你可以在`.gitignore`末尾增加一行`.update`来忽略这个文件。

登录之后可以创建应用。注意iOS平台和安卓平台需要分别创建：

```sh
$ pushy createApp --platform ios
App Name: <输入应用名字>
$ pushy createApp --platform android
App Name: <输入应用名字>

$ pushy createApp --platform ios
App Name: testHotUpdate 
Created app 1140
#这时我再刷新程序页面发现已经可以正常运行，不报错了，喜大普奔。
#运行pushy的testHotUpdate一直报错，提示说没有找到 "update.json"文件，去js/index.js发现确实需要import Update from '../../update.json'，因为我根本没有注册这个程序，所以没有生成update.json，于是我在该项目根目录下pushy login && pushy createApp --platfrom ios App Name: testHotUpdate之后再刷新程序发现已经可以正常运行。
```

如果你已经在网页端（指Pushy的网站http://update.reactnative.cn/dashboard，这里我发现我已经添加了一个应用`testHotUpdate`）或者其它地方创建过应用，也可以直接选择应用：

```sh
$ pushy selectApp --platform ios
1) 鱼多多(ios)
3) 招财旺(ios)

Total 2 ios apps
Enter appId: <输入应用前面的编号> 
```

选择或者创建国应用后，你讲可以在文件夹下看到`update.json`文件，其内容格式如下：

```sh
{
    "ios": {
        "appId": 1,
        "appKey": "<一串随机字符串>"
    },
    "android": {
        "appId": 2,
        "appKey": "<一串随机字符串>"
    }
}
```

你可以安全的把`update.json`上传到Git等CVS系统上，与你的团队共享这个文件，它不包含任何敏感信息。当然，他们在使用任何功能之前，都必须首先输入`pushy login`进行登录。

#### 添加热更新功能

*通过上部分的准备工作，该部分主要讲如何给工程添加热更新功能。*

##### 获取appKey

检查更新时必须提供你的`appKey`，这个值保存在`update.json`中，并且根据平台不同而不同。你可以用如下的代码获取：

```javascript
import React, {
  Platform,
} from 'react-native';

import _updateConfig from './update.json';
const {appKey} = _updateConfig[Platform.OS];
```

如果你不使用pushy命令行，你也可以从网页端查看到两个应用appKey，并根据平台的不同来选择。

##### 检查更新、下载更新

异步函数checkUpdate可以检测当前版本是否需要更新：

```javascript
checkUpdate(appKey)
    .then(info => {
    })
```

返回的info有三种情况：

1. `{expired: true}`：该应用包(原生部分)已过期，需要前往应用市场下载新的版本。
2. `{upToDate: true}`：当前已经更新到最新，无需进行更新。
3. `{update: true}`：当前有新版本可以更新。info的`name`、`description`字段可 以用于提示用户，而`metaInfo`字段则可以根据你的需求自定义其它属性(如是否静默更新、 是否强制更新等等)。另外还有几个字段，包含了完整更新包或补丁包的下载地址， react-native-update会首先尝试耗费流量更少的更新方式。将info对象传递给downloadUpdate作为参数即可。

##### 切换版本

downloadUpdate的返回值是一个hash字符串，它是当前版本的唯一标识。

你可以使用`switchVersion`函数立即切换版本(此时应用会立即重新加载)，或者选择调用 `switchVersionLater`，让应用在下一次启动的时候再加载新的版本。

##### 首次启动、回滚

在每次更新完毕后的首次启动时，`isFirstTime`常量会为`true`。 你必须在应用退出前合适的任何时机，调用`markSuccess`，否则应用下一次启动的时候将会进行回滚操作。 这一机制称作“反触发”，这样当你应用启动初期即遭遇问题的时候，也能在下一次启动时恢复运作。

你可以通过`isFirstTime`来获知这是当前版本的首次启动，也可以通过`isRolledBack`来获知应用刚刚经历了一次回滚操作。 你可以在此时给予用户合理的提示。

##### 完整示例

```javascript
import React, {
  Component,
} from 'react';

import {
  AppRegistry,
  StyleSheet,
  Platform,
  Text,
  View,
  Alert,
  TouchableOpacity,
  Linking,
} from 'react-native';

import {
  isFirstTime,
  isRolledBack,
  packageVersion,
  currentVersion,
  checkUpdate,
  downloadUpdate,
  switchVersion,
  switchVersionLater,
  markSuccess,
} from 'react-native-update';

import _updateConfig from './update.json';
const {appKey} = _updateConfig[Platform.OS];

class MyProject extends Component {
  componentWillMount(){
    if (isFirstTime) {
      Alert.alert('提示', '这是当前版本第一次启动,是否要模拟启动失败?失败将回滚到上一版本', [
        {text: '是', onPress: ()=>{throw new Error('模拟启动失败,请重启应用')}},
        {text: '否', onPress: ()=>{markSuccess()}},
      ]);
    } else if (isRolledBack) {
      Alert.alert('提示', '刚刚更新失败了,版本被回滚.');
    }
  }
  doUpdate = info => {
    downloadUpdate(info).then(hash => {
      Alert.alert('提示', '下载完毕,是否重启应用?', [
        {text: '是', onPress: ()=>{switchVersion(hash);}},
        {text: '否',},
        {text: '下次启动时', onPress: ()=>{switchVersionLater(hash);}},
      ]);
    }).catch(err => { 
      Alert.alert('提示', '更新失败.');
    });
  };
  checkUpdate = () => {
    checkUpdate(appKey).then(info => {
      if (info.expired) {
        Alert.alert('提示', '您的应用版本已更新,请前往应用商店下载新的版本', [
          {text: '确定', onPress: ()=>{info.downloadUrl && Linking.openURL(info.downloadUrl)}},
        ]);
      } else if (info.upToDate) {
        Alert.alert('提示', '您的应用版本已是最新.');
      } else {
        Alert.alert('提示', '检查到新的版本'+info.name+',是否下载?\n'+ info.description, [
          {text: '是', onPress: ()=>{this.doUpdate(info)}},
          {text: '否',},
        ]);
      }
    }).catch(err => { 
      Alert.alert('提示', '更新失败.');
    });
  };
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          欢迎使用热更新服务
        </Text>
        <Text style={styles.instructions}>
          这是版本一 {'\n'}
          当前包版本号: {packageVersion}{'\n'}
          当前版本Hash: {currentVersion||'(空)'}{'\n'}
        </Text>
        <TouchableOpacity onPress={this.checkUpdate}>
          <Text style={styles.instructions}>
            点击这里检查更新
          </Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('MyProject', () => MyProject);
```

现在，你的应用已经可以通过update服务检查版本并进行更新了。下一步，你可以开始尝试发布应用包和版本，请参阅[发布应用](https://github.com/reactnativecn/react-native-pushy/blob/master/docs/guide3.md)

