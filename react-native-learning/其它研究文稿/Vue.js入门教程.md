#### Vue.js入门教程

##### 安装Vue.js

1. 直接下载并用`<script>`标签引入，`Vue`会被注册为一个全局变量。重要提示：在开发时使用开发版本，http://cn.vuejs.org/guide/installation.html
2. 可以从 [jsdelivr](http://cdn.jsdelivr.net/vue/1.0.21/vue.min.js) 或 [cdnjs](http://cdnjs.cloudflare.com/ajax/libs/vue/1.0.21/vue.min.js) 获取（版本更新可能略滞后）。
3. 有些环境，如 Google Chrome Apps，强制应用内容安全策略 (CSP) ，不能使用`new Function()` 对表达式求值。这时可以用 [CSP 兼容版本](https://github.com/vuejs/vue/tree/csp/dist)。

##### `NPM`

使用Vue.js构建大型应用时推荐使用nmp安装，npm能很好的和诸如 [Webpack](http://webpack.github.io/) 或者[Browserify](http://browserify.org/) 的`CommonJS`模块打包器配合使用。Vue.js也提供配套工具开发单文件组件。

```shell
#最新稳定版本
$ npm install vue
# 最新稳定 CSP 兼容版本
$ npm install vue@csp
```

##### 命令行工具

Vue.js 提供一个[官方命令行工具](https://github.com/vuejs/vue-cli)，可用于快速搭建大型单页应用。该工具提供开箱即用的构建工具配置，带来现代化的前端开发流程。只需一分钟即可启动带热重载、保存时静态检查以及可用于生产环境的构建配置的项目：

```sh
# 全局安装 vue-cli,
#/Users/gaolong/.nvm/versions/node/v5.7.0/bin/vue -> /Users/gaolong/.nvm/versions/node/v5.7.0/lib/node_modules/vue-cli/bin/vue  /Users/gaolong/.nvm/versions/node/v5.7.0/lib
$ npm install -g vue-cli
# 创建一个基于 "webpack" 模板的新项目
$ vue init webpack my-project
# 安装依赖，走你
$ cd my-project
$ npm install
$ npm run dev
```

##### 开发版本

**重要**：发布到 NPM 上的 CommonJS 包 (`vue.common.js`) 只在发布新版本时签入 master 分支，所以这些文件在 dev 分支下跟稳定版本是一样的。想使用 GitHub 上最新的源码，需要自己编译：

```sh
git clone https://github.com/vuejs/vue.git node_modules/vue
cd node_modules/vue
npm install
npm run build
```

