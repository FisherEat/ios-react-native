

http://reactnative.cn/docs/0.25/android-setup.html#content   

ReactNative中文网

http://kiwi.saylove.today/?p=124

龙—》整理集成





mac10默认安装jdk1.6版本过低需要使用jdk1.7  路径配置在/System/Library 安装包路径~/androiddev...





1Android集成开发环境下载：http://tools.android-studio.org/index.php/sdk

2由于google服务器的问题 mac需要设置代理服务http://zhidao.baidu.com/link?url=k3txi1ho5LyzbQqEmHHvYoecdwHwW38_lR4u96acQa_OLOFy-UO0I7xIjFm_QTl8rfbuKMyfTbu8WhQgZWqoLMulu8xaUmG9H6KZm8xJVUO需要将服务器地址设置为mirrors.neusoft.edu.cn 端口号为80

mac android react-native 安装连接 http://www.mamicode.com/info-detail-1098914.html






React Native Android环境搭建
大致步骤：搭建Android开发环境-------》搭建Node环境------>配置React——Native项目环境
所有工具软件在/user/tw/DestTop/AndroidDev

1：搭建java环境 mac系统默认为jdk1.6  安装jdk1.7 软件在~/DeskTop/AndroidDev/javaDev
   安装后目录在/system/Library/javamarchines
   检验是否安装成功使用java -version查看版本信息

2：搭建Android开发环境
   Android环境主要包括AndroidStudio2.0+AndroidSDK+Gradle+NDK软件在目录~/DeskTop/AndroidDev/androidtool
   (1)使用http://tools.android-studio.org/index.php/sdk下载AndroidStudio+AndroidSDK
   (2)下载AndroidSDK后打开sdkManager下载Android2.3---Android6.0的API 如果不能翻墙需要配置代理服务器IP为mirrors.neusoft.edu.cn 端口号为80 详情见链接http://zhidao.baidu.com/link?url=k3txi1ho5LyzbQqEmHHvYoecdwHwW38_lR4u96acQa_OLOFy-UO0I7xIjFm_QTl8rfbuKMyfTbu8WhQgZWqoLMulu8xaUmG9H6KZm8xJVUO,react-native需要有API23必须下载，最低API为16也就是Android4.0
   (3)下载gradle2.4 react-native最低要求gradle2.2
   (4)下载NDKR10(非必须)为以后Android项目使用JNI配置
   (5)以上软件已下载，还需要配置环境变量~/.bash_profile 文件 
     #android sdk path
     export PATH=$PATH:/Users/tw/Desktop/AndroidDev/androidtool/android-sdk-macosx/tools:/Users/tw/Desktop/AndroidDev/androidtool/android-sdk-macosx/platform-tools

    #nvm
    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh

    #gradle2.4
    export GRADLE_HOME=/Users/tw/Desktop/AndroidDev/androidtool/gradle-2.4
    export PATH=$PATH:$GRADLE_HOME/bin

    #android ndk
    export PATH=$PATH:/Users/tw/Desktop/AndroidDev/androidtool/android-ndk-r10d
    到此Android环境搭建已经完成 可以用Androi Studio创建Demo工程 SDK一定要全部下载最新下载，要不然各种编译问题

3：mac环境下搭建node环境主安装安装nvm, Node.js, watchman, flow
   (1)安装nvm(node version manager) brew install nvm  
   (2)安装结束后参见上面的环境变量配置nvm
   (3)安装最新的node,使用nvm install node
   (4)将该node设置为nvm默认管理的node,使用nvm alias default node
   (5)安装watchman，使用brew install watchman
  （6）安装flow，使用brew install flow
   (7)安装react-native,使用npm install -g react-native-cli
   (8)安装nrm,使用npm install -g nrm;nrm ls#查看可用的源地址;nrm use taobao #使用淘宝源

4：创建React_Native工程
   (1)react-native init YourNameNativeProject
   (2)到工程根目录下启动node本地服务,node start
   (3)用androidstudio打开工程下的Android项目，需要等几分钟去下载依赖库Extend Libraries
   (4)在androdistudio运行项目，通过adb devices命令行确认已经有设备连接，如果出现红屏页面说明差不多了
  （5）最后一步就需要摇晃手机，出现devsetting页面的时候设置ip和端口号列入:192.168.0.100:8081
   这样React_Native环境已经Ok了


Window搭建Node环境 搭建Android环境省略
介绍准确的参考http://bbs.reactnative.cn/topic/10/%E5%9C%A8windows%E4%B8%8B%E6%90%AD%E5%BB%BAreact-native-android%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83
1：window搭建node顺序
   (1)搭建C++编译环境安装使用了Cygwin 默认安装下载就行
   （2）下载Python，默认安装，应为后面的nodejs下载安装编译需要运行python脚本否则会报错
   （3）下载安装node.js 链接https://nodejs.org/en/ 默认安装后就会有node环境
   （4）建议设置npm镜像以加速后面的过程（或使用科学上网工具）。
      npm config set registry https://registry.npm.taobao.org --global
      npm config set disturl https://npm.taobao.org/dist --globa
  （5）安装react-native命令行工具
       npm install -g react-native-cli

   
      
   















    

   


  




