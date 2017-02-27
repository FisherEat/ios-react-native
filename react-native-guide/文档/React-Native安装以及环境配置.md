#### React-Native安装以及环境配置

*建议使用typora打开该文档。重点参考这篇文档：http://kiwi.saylove.today/?p=124 ，下面是我自己的安装过程的总结，首先参考上面这篇文档！*

1. 安装brew

   ```shell
       # brew 是一个Mac下快速安装插件的工具，类似Linux的yum\apt等命令行包安装工具。安装方式

       $ shell
       $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
       $ 
       $
   ```

2. 安装nvm

   > ```shell
   > brew install nvm
   > ```
   >
   > nvm即node version manager,用来管理和支持Mac下多版本的node.js 。
   >
   > 安装完后，根据终端提示，运行相关命令，即可配置相关环境变量，终端提示输入如下：
   >
   > ```shell
   > You should create NVM's working directory if it doesn't exist:
   >
   > mkdir ~/.nvm
   >
   > Add the following to ~/.zshrc or your desired shell
   > configuration file:
   >
   > export NVM_DIR=~/.nvm
   > source $(brew --prefix nvm)/nvm.sh
   > ```
   >
   > 注意：source 方式可能找不到nvm.sh文件，或者在主目录先找不到shell的几个配置文件 .bashrc 或者 .zshrc 等，不能直接在终端输入这些指令，否则只能在这个进程中安装了。 最后我发现需要
   >
   > ```shell
   > vim ~/.bashrc
   > vim ~/.zshrc
   > vim ~/.bashrc_profile
   > ```
   >
   > 在系统根目录下生成这三个文件，并配置好 source ／nvm.h。
   >
   > ```shell
   > $  mkdir ~/.nvm
   > $  export NVM_DIR=~/.nvm
   > $  source $(brew --prefix nvm)/nvm.sh ， 如果提示找不到nvm.sh,而cd到brew 目录下发现有这个文件，可以直接这么导入
   > $ source /usr/local/opt/nvm.sh 
   > ```
   >
   > ​
   > ​

3. 安装最新的node 

   > 如果用brew或者其它方式安装过node, 可以先删除node
   >
   > ```shell
   > brew remove --force node 
   > sudo rm -r /usr/local/lib/node_modules
   >
   > brew prune
   > sudo rm -r /usr/local/include/node
   >
   > #检查brew是否正常
   > brew doctor
   > ```
   >
   > 安装最新的node
   >
   > ```shell
   > nvm install node 
   > ```
   >
   > 将该node设置为默认的nvm管理的node
   >
   > ```shell
   > nvm alias default node 
   > ```
   >
   > 安装好node,其包管理工具`npm`, `node package manager`也安装好了，可以参考其包管理工具的命令。以下是npm常用指令：
   >
   > ```shell
   > npm ls #查看当前目录下安装的包
   > npm ls -g #查看全局安装的包
   > npm install xxx #安装xxx包
   > npm uninstall xxx
   > npm info xxx 
   > npm install xxx --save #安装xxx包，并将xxx依赖命令写入package.json
   > npm update xxx
   >
   > #我的npm安装路径
   > ~/.nvm/versions/node/v5.6.0/lib/node_modules/npm
   >
   > #nvm是用来管理node版本的工具，因此可以循该路径找到node
   > #我的node执行的脚本bin
   > /Users/schiller/.nvm/versions/node/v5.6.0/bin/node 
   >
   > #我们用react-native init myRNDemo来初始化RN项目,react-native命令的原理：
   > $ cd ~/.nvm/versions/node/v5.6.0/lib/node_modules
   > $ ls -a
   > $ cd react-native-cli
   > $ ls -a 
   > .README.mdnode_modules
   > ..index.jspackage.json
   >
   > $ vi package.json
   > # package.json中有这么一段
   > "bin": {  "react-native": "index.js"
   > },
   > $ vi index.js 
   >
   > if (args[0] === 'init') {
   > if (args[1]) {
   > init(args[1]);
   > } else {
   > }
   > } else {
   > ......
   > }
   > 1、fs.writeFileSync(path.join(root, 'package.json'), JSON.stringify(packageJson));
   > 2、run('npm install --save react-native', function(e) {}
   > #代码1是动态生成package.json，代码2是本地安装react-native模块。因此react native初始化项目困难，都是npm惹的祸
   > ```
   >
   > 经过上面对"react-native-cli"与“react-native”的分析，可以看出Facebook应该是推荐“react-native”模块局部化，所以不论在React Native项目初始化的过程中，还是clone已有的React Native项目，都需要在当前项目下下载和安装“react-native”模块，使得React Native 项目占用的空间越来越大。
   >
   > over
   > ​

4. 安装watchman

   > ```shell
   > brew install watchman
   > ```
   >
   > watchman为react代码发生变化时，完成相关的重建工具，实现LiveReload功能。
   > ​
   > ​

5. 安装flow

   > ```shell
   > brew install flow 
   > ```
   >
   > flow为javasript类型检查器，实现静态类型检查

6. 安装react-native 

   > ```shell
   > npm install -g react-native-cli
   > ```
   >
   > 因为react-native 安装后需要在所有目录都可使用，因此需要全局安装-

7. 安装nrm

   > ```shell
   > npm install -g nrm 
   > nrm ls #查看有哪些可用的源地址
   > nrm use taobao #使用淘宝源
   > ```
   >
   > nrm为管理node包源地址的管理器，因为node包默认为从国外服务器获取，若不更换国内源，在安装时会非常慢

8. ​搭建私有npm，提交创建项目的速度和减少缓存

##### 起步，RN入门教程

1. 创建项目

   ```shell
       > ``` shell
       > react-native init MyReactNativeProject
       > ```
       >
       > 分析项目目录结构，node_modules为react-native依赖的相关源代码，package.json为rn依赖管理配置文件，resources为资源目录，如图片资源
       > 
   ```

2. 启动

   > ```objective-c
   > jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
   >
   > jsCodeLocation = [NSURL URLWithString:@"http://192.168.1.116:8081/index.ios.bundle?platform=ios&dev=false"];
   >
   > jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
   > ```
   >
   > 原理：
   >
   > ```
   > 从jsCodeLocation的链接地址来看react-native是从本地端口拉取index.ios.js来执行。如果将index.ios.js的名字改为test.ios.js，然后Appdelegate.m中的index.ios.bundle改为test.ios.bundle 重新执行编译通过，验证假设。
   > ```
   >
   > over.

3. 项目协作与迁移

   > 项目协作，迁移到新的服务器必须执行`nmp install `重新更新项目的配置，否则会报错。
   >
   > over.