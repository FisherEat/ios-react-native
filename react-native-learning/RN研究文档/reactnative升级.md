#### ReactNative升级

1. 查看react-native版本

   ```sh
   $ npm info react-native 
   ```

2. 打开项目目录下的`package.json`摁键，然后在`dependencies`模块下找到`react-native`，将当前版本号改到想要的版本，然后：`npm install`

3. 新版本的npm包通常还会包含一些动态生成的文件，这些文件是在运行`react-native init`创建新项目时生成的，比如iOS和Android的项目文件。为了使老项目的项目文件也能得到更新（不重新init），你需要在命令行中运行：

   ```sh
   $ react-native upgrade
   ```

4. ​