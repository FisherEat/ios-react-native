#### React-Native研究

##### 安装教程

1. 安装brew

   ```shell
         # brew 是一个Mac下快速安装插件的工具，类似Linux的yum\apt等命令行包安装工具。安装方式

         $ shell
         $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
         $ 
         $
   ```

2. 安装nvm

   > ``` shell
   > brew install nvm
   > ```
   >
   > nvm即node version manager,用来管理和支持Mac下多版本的node.js 。
   >
   > 安装完后，根据终端提示，运行相关命令，即可配置相关环境变量，终端提示输入如下：
   >
   > ``` shell
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
   > ``` shell
   > vim ~/.bashrc
   > vim ~/.zshrc
   > vim ~/.bashrc_profile
   > ```
   >
   > 在系统根目录下生成这三个文件，并配置好 source ／nvm.h。
   >
   > ``` shell
   > $  mkdir ~/.nvm
   > $  export NVM_DIR=~/.nvm
   > $  source $(brew --prefix nvm)/nvm.sh ， 如果提示找不到nvm.sh,而cd到brew 目录下发现有这个文件，可以直接这么导入
   > $ source /usr/local/opt/nvm.sh 
   > ```
   > ​
   > ​
3. 安装最新的node 

   > 如果用brew或者其它方式安装过node, 可以先删除node
   >
   > ``` shell
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
   > ``` shell
   > nvm install node 
   > ```
   >
   > 将该node设置为默认的nvm管理的node
   >
   > ``` shell
   > nvm alias default node 
   > ```
   >
   > 安装好node,其包管理工具`npm`, `node package manager`也安装好了，可以参考其包管理工具的命令。以下是npm常用指令：
   >
   > ``` shell
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
   > 经过上面对"react-native-cli"与“react-native”的分析，可以看出Facebook应该是推荐“react-native”模块局部化，所以不论在React Native项目初始化的过程中，还是clone已有的React Native项目，都需要在当前项目下下载和安装“react-native”模块，使得React Native 项目占用的空间越来越大。
   >
   > over
   > ​
4. 安装watchman

   > ``` shell
   > brew install watchman
   > ```
   >
   > watchman为react代码发生变化时，完成相关的重建工具，实现LiveReload功能。
   > ​
   > ​
5. 安装flow

   > ``` shell
   > brew install flow 
   > ```
   >
   > flow为javasript类型检查器，实现静态类型检查
6. 安装react-native 

   > ``` shell
   > $ npm install -g react-native-cli
   > ```
   >
   > 因为react-native 安装后需要在所有目录都可使用，因此需要全局安装-
7. 安装nrm

   > ``` shell
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
     $ react-native init MyReactNativeProject
     # 分析项目目录结构，node_modules为react-native依赖的相关源代码，package.json为rn依赖管理配置文件，resources为资源目录，如图片资源
     # 通过package.json文件发现其实每次创建的新项目的react-native和react都是最新的版本。     
   ```
2. 启动

   > ``` objective-c
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

##### ECMASCRIPT语法

1. Babel命令行转码工具

             > 通过npm安装，babel用于命令行转码，将es6转成es5
             >
             > ``` shell
             > $ npm install --global babel-cli
             > ```
             >
             > Babel基本语法如下
             >
             > ``` shell
             > # 转码结果输出到标准输出
             > $ babel example.js
             >
             > # 转码结果写入一个文件
             > # --out-file 或 -o 参数指定输出文件
             > $ babel example.js --out-file compiled.js
             > # 或者
             > $ babel example.js -o compiled.js
             >
             > # 整个目录转码
             > # --out-dir 或 -d 参数指定输出目录
             > $ babel src --out-dir lib
             > # 或者
             > $ babel src -d lib
             >
             > # -s 参数生成source map文件
             > $ babel src -d lib -s
             > ```
             > ​
2. Styles

   > 用如下方式定义样式
   >
   > ``` javascript
   > var styles = StyleSheet.create({
   > base: {
   > width: 38,
   > height: 38,
   > },
   > background: {
   > backgroundColor: '#222222'
   > },
   > active: {
   > borderWidth: 2,
   > borderColor: '#00ff00',
   > },
   > });
   > ```
   >
   > Stylesheet.create构造器是可选的，使用样式
   >
   > ``` javascript
   > <Text style={styles.base}>NICE</Text>
   > <View sytle={[styles.base, styles.background]}></View>
   > ```
   >
   > https://facebook.github.io/react-native/docs/style.html#content
   >
   > 使用图片
   >
   > ``` javascript
   > //from local
   > <Image source={require('./myImage.png')}  style={width: 40, height: 40}/>
   > //from network
   > <Image source={{uri: 'https://facebook.github.io/react/img/logo_og.png'}} style={{width: 40, height: 40}}>
   >
   > ```

##### watchman take too long to load

> 这个错误facebook给出了官方的解决方法
>
> ```shell
> $ brew uninstall watchman
> $ brew install --HEAD watchman
> ```
>
> over.
> ##### 周末研究react总结



> 1. 完成一个Demo工程

##### React －Demo的基本

> 1. react-native各种控件的用法
> ```
> ScrollView 、滑动视图
> ListView、列表视图
> Text 、label、自定义LabelView
> TextInput 、输入框
> Image 、图片、网络图片与本地图片
> DataPickerIOS、日期栏
> NavigatorIOS导航栏、导航页面数据传递
> TouchableHighlight 按钮
> ActivityIndicatorIOS 指示器
> ```
>
> 1. react-native自定义类和使用自定义类
>
> ```javascript
> render 函数是用来渲染视图的函数
> StylesSheet.create创建css
> var object = React.createClass()创建react类
> exports 输出 该类，给外部使用，
> var DatePickerExample = require('./DatePickerExample');调用外部定义好的类
> constructor为构造函数
> componentDidMount() 生命周期函数
> getInitialState() ES5生命周期
> render()渲染仕途，类似 initwithframe ,addsubview
> var WithLabel = React.createClass({})  创建新的类
> <WithLabel label='Timezone:'>
> </WithLabel> 使用自定义的类
> module.exports = DatePickerExample;ES5输出该类
> node.js的目录结构
> ```
>
> 1. 细节总结
>
> over.

##### 下周任务

- 如何在已有项目中集成react-native

- 使用ES6语法来定义类、掌握ES6语法

- 掌握css布局

- 如何实现react和native页面的通讯

- 掌握基本react UI控件

- 熟悉和掌握node.js语法

- over.

##### ES6语法之类

> 1. 定义类
>
> ```javascript
> //定义类
> class Point {
> constructor(x, y) { //构造函数
> this.x = x;
> this.y = y;
> }
> toString() { //内部自定义函数
> return '('+this.x+', '+this.y+')';
> }
> }
> var point = new Point(2, 3); //定义类实例
> point.toString() // (2, 3)
> point.hasOwnProperty('x') // true
> point.hasOwnProperty('y') // true
> point.hasOwnProperty('toString') // false
> point.__proto__.hasOwnProperty('toString') // true
> ```
>
> 1. over

##### 组件的生命周期

> 所有组件名首字母必须大写，如`HelloReact`，不能写成 `helloReact`。
>
> `this.props`对象的属性与组件的属性一一对应，但有一个例外，就是`this.props.children`，它表示组件的所有子节点。如果当前组件没有子节点，它就是`undefined`，如果有一个节点，它的类型是`object`，如果有多个节点，数据类型就是`array`。可以通过`React.children`来处理`this.props.children`。
>
> 组件的属性可以接受任意值，字符串、对象、函数都可以。组件类的`PropTypes`属性，就是用来验证组件实例的属性是否符合要求。如下Demo:
>
> ```javascript
> var MyTitle = React.createClass({
> propTypes: {
> title: React.PropTypes.string.isRequired,
> },
> render: function() {
> return <h1> {this.props.title} </h1>;
> }
> }); 
> //该组件的title属性设置为string类型，而且是必须的。外部使用这个组件时对title赋值时必须是字符串。
> //可以用getDefaultProps方法用来设置组件属性的默认值。
> ```
>
> 组件的生命周期分为三个状态:
>
> ```javascript
> Mouting: 已经插入真实的DOM
> Updating: 正在被重新渲染
> Unmounting: 已经移出真实DOM
> ```
>
> React为每个状态都提供两种处理函数，`will`函数处理进入状态之前调用，`did`函数在进入状态之后调用，三种状态共计五种处理函数：
>
> ```javascript
> componentWillMount()
> componentDidMount()
> componentWillUpdate(Object nextProps, object nextState)
> componetDidUpdate(Object prevProps, object prevState)
> componetWillUnmount()
> ```
>
> 此外，React还提供两种特殊状态的处理函数：
>
> ```javascript
> componentWillReceiveProps(object nextProps): 已加载组件收到信的参数时调用
> shouldComponentUpdate(object nextProps, object nextState):组件判断是否重新渲染时调用
> ```
>
> 对于组件获取真实的`DOM`节点。
>
> 组件并不是真实的`DOM`节点，而是存在于内存中国年的一种数据结构，叫做虚拟`DOM(virtual DOM)`，只有当它插入文档以后，才会变成真实的`DOM`。根据React的设计，所有的DOM变动，都先在虚拟DOM上发生，然后再将实际发生的变动部分，反映在真实的`DOM`上，这种算法叫做 `DOM diff`，可以极大的提高网页的性能表现。、
>
> `this.state`属性：
>
> 组件和用户互动，是React 一大创新，将组件看成一个状态机，一开始有一个初始状态，然后用户互动，导致状态发生变化，从而触发重新渲染UI：
>
> ```javascript
> class Index extends Component {
> constructor(props) {
> super(props);
> this.state = { liked: false}
> }
> render() {
> const aTexts = this.state.liked ? 'shit' : 'noshit'
> return (
> <View style={styles.container}>
> <TouchableOpacity onPress={() => this.setState({liked: !this.state.liked})}>
> <Text style={styles.titletext}>React Native: {aTexts}</Text>
> </TouchableOpacity>
> </View>
> );
> }
> }
> //上述代码中是一个组件，在constructor方法中定义好state对象，这个对象可以通过 this.state来属性读取。当用户点击组件时，导致状态发生变化，this.setState方法就修改状态值，每次修改以后，自动调用this.render方法再次渲染组件。
> //this.props和this.state都用于描述组件的特性，可能会产生混淆。一个简单的区分方法是，this.props用来表示一旦定义，就不再发生变化的特性，而this.state是会随着用户互动而产生变化的特性。
> //用一个函数_onPress()来定义点击事件发生错误。错误原因不明。
> ```
>
> over.
> ##### react-native报错



> 1. OnlyChild报错
>
> ```javascript
> 报错：React Native: Fix for "Invariant Violation: onlyChild Must Be Passed a Children With Exactly One Child"
> 原因：某些组件必须有且仅有一个子组件，否则报错
> return (
> <TouchableHighlight>
> </TouchableHighlight>
> ); // Error: onlyChild must be passed a children with exactly one child
> return (
> <TouchableHighlight>
> <Text>foo</Text>
> </TouchableHighlight>
> ); // OK
> return (
> <TouchableHighlight>
> <Text>foo</Text>
> <Text>bar</Text>
> </TouchableHighlight>
> ); // Error: onlyChild must be passed a children with exactly one child
> ```
>
> 1. over

##### node.js学习笔记

> 1. node常用命令
>
> ```javascript
> $ node /user/helloworld.js
> ```
>
> 1. node REPL(Read-eval-print loop)模式
>
> 2. 创建HTTP服务器(前提是你已经安装好node)
>
> ```javascript
> var http = require('http');
>
> http.createServer(function(request, response) {
> response.writeHead(200, {'Content-Type': 'text/html'});
> response.write('<h1>Node.js</h1>');
> response.end('<p>Hello world</p>');
> }).listen(3000);
> console.log("HTPP server is listening at port 3000");
> #运行这段代码，然后在浏览器中访问：http://127.0.0.1:3000
> ```
>
> 1. `supervisor`解决调试问题
>
> ```javascript
> $ npm info supervisor
> $ npm install supervisor
> $ supervisor helloworld.js
> ```
>
> 1. 异步 `I/O`与`事件式编程`
>
> ```javascript
> 1.阻塞与线程
> 2.同步I/O或阻塞式I/O
> 3.异步I/O或非阻塞式I/O
> 4.事件循环
> #异步读取文件，异步I/O通过回调函数实现
> var fs = require('fs');
> fs.readFile('/Users/schiller/Desktop/file.txt', 'utf-8', function(error, data) {
> 	if(error) {
> 	  console.log(error);
> }else { 
> console.log(data);
> }
> });
> console.log('end');
> #我们会发现先打印end 再打印file.txt的content
> #同步读取文件，阻塞之后再读取
> var fs = require('fs');
> var data = fs.readFileSync('file.txt', 'utf-8'); 
> console.log(data);
> console.log('end.');
> ```
>
> 1. `express`框架研究
>
> ```shell
> $ npm install -g express 
> $ /Users/gaolong/.nvm/versions/node/v5.7.0/lib
> $ 仔细阅读Readme.md文档
> $ npm install -g express-generator@4
> $ express fisrtExpressDemo
> $ cd firstExpressDemo && npm install  //install
> dependencies
> $ npm start //启动应用
> $ 浏览器输入 'http://localhost:3000'
> $ DEBUG=firstExpressDemo:* npm start //run the app 
> #examples
> $ git clone git://github.com/expressjs/express.git --depth 1
> $ cd express
> $ npm install
> $ node examples/content-negotiation
> ```
>
> 1. `react-native`学习计划
>
> ```javascript
> 1.持续学习ES6，了解ES5
> 2.RN官方文档
> 3.node.js了解js服务器编程，了解RN调试
> ```
>
> 1. JavaScript高级特性
>
> ```javascript
> 1.作用域
> var v1 = 'v1';
> var f1 = function() {
> console.log(v1); //v1
> }
>
> var v2 = "global";
> var f2 =function() {
> console.log(v2);//undefined,javascript会先搜索f2作用域
> v2 = "scope";
> }
>
> var f = function() {
> var scope = 'f0';
> (function() {
> var scope = 'f1';
> (function() {
> console.log(scope); //f1 ,这里取得的是其父作用域的值
> })();             //函数作用域的嵌套关系是定义时决定的，不是调用时决定的
> })();
> };
> f();
>
> #全局作用域与全局对象
> global对象、window对象、DOM对象 
> 2.闭包
> var generateClosure = function() {
> var count = 0;
> var get = function() {
> count++;
> return count;
> };
> return get;
> };
>
> var counter = generateClosure();
> console.log(counter()); //1
> console.log(counter()); //2
> console.log(counter()); //3
> #当一个函数返回它内部定义的一个函数时，就产生一个闭包，闭包不但包括被返回的函数，还包括这个函数的定义环境。上例中couter和generateClosure()的局部变量就是一个闭包。
> #闭包用作：嵌套的回调函数、实现私有成员
> 3.对象
> var foo = {};
> foo.pro_1 = 'bar';
> foo.prop_2 = false;
> foo.prop_3 = function() {
> return 'Hello world';
> };
> foo['pro_4'] = '关联数组';
> console.log(foo.prop_3);
> console.log(foo.pro_4);
> console.log(foo['pro_4']);
> #使用关联数组创建、访问对象成员、使用对象初始化器创建对象
> #构造函数创建对象
> function User(name, uri) {
> this.name = name;
> this.uri = uri;
> this.display = function() {
> console.log(this.name);
> console.log(this);
> }
> }
> var someUser = new User('gaolong', 'http://gaolong.com');
> console.log(someUser.name);
> someUser.display();
> #this指针是引用所属的对象
> #call、aplly的功能是允许一个对象去调用另一个对象的成员函数！！！
> #call 和apply的功能是一致的，区别在于call以参数表来接收被调用函数的参数，而apply以数组来接收被调用函数的参数。
> #bind
> var someGirl = {
> name: 'beauty',
> func: function() {
> console.log(this.name);
> }
> };
> var foo = {
> name: 'ugly',
> };
> foo.func = someGirl.func;
> foo.func(); //ugly
>
> foo.func1 = someGirl.func.bind(someGirl);
> foo.func1(); //beauty
>
> func = someGirl.func.bind(foo);
> func();//ugly
> func2 = func;
> func2(); //ugly
> #原型
> 1.构造函数内定义的属性继承方式与原型不同,子对象需要显式调用父对象才能继承构 造函数内定义的属性。
> 2.构造函数内定义的任何属性,包括函数在内都会被重复创建,同一个构造函数产生的 两个对象不共享实例。
> 3.构造函数内定义的函数有运行时闭包的开销,因为构造函数内的局部变量对其中定义 的函数来说也是可见的。
> function FooMe() {
> var innerVar = 'hello tomorrow';
> this.prop1 = 'gaolongxiaoxiao';
> this.func1 = function () {
> innerVar = '';
> }
> }
> FooMe.prototype.prop2 = 'Carbo';
> FooMe.prototype.func2 = function () {
> console.log(this.prop2);
> }
> var foo1 = new FooMe();
> var foo2 = new FooMe();
> console.log(foo1.func1 == foo2.func1); //false
> console.log(foo1.func2 == foo2.func2); //true
> //除非必须用构造函数闭包，否则尽量用原型定义成员函数，因为这样可以减少开销
> //尽量在构造函数内定义一般成员，尤其是对象数组，因为用原型定义的成员是多个实例共享的。
> #原型链
> 特殊对象：Object 、 Function
> Object.prototype是所有对象的祖先，Function.prototype是所有函数的原型，包括构造函数。
> 用户创建的对象：new 显式构造的对象
> 构造函数对象：普通的构造函数,即通过 new 调用生成普通对象的函数。
> 原型对象：特指构造函数 prototype 属性指向的对象
> 这三类对象中每一类都有一个 __proto__ 属 性,它指向该对象的原型,从任何对象沿着它开始遍历都可以追溯到 Object.prototype。
> function FooYou() {
>
> }
> Object.prototype.name = 'My Object';
> FooYou.prototype.name = 'Bar';
> var obj = new Object();
> var foo = new FooYou();
> console.log(obj.name); //'My Object'
> console.log(foo.name); // 'Bar'
> console.log(foo.__proto__.name); // 'Bar'
> console.log(foo.__proto__.__proto__.name); // 'My Object'
> console.log(foo.__proto__.constructor.prototype.name); // 'Bar'
>
> foo: __proto__ 
> FooYou:__proto__.prototype
> Foo.prototype:__proto__.constructor
> Function: __proto__ & prototype
> Function.prototype: __proto__ & constructor
> obj: __proto__
> Object: __proto__.protype 
> Object.prototype: __proto__ & constructor
>
> __proto__是实例为获取其类的原型而设置的一个属性！！！
>
> 在 JavaScript 中,继承是依靠一套叫做原型链(prototype chain)的机制实现的。属性 继承的本质就是一个对象可以访问到它的原型链上任何一个原型对象的属性。例如上例的foo 对象,它拥有 foo. __proto__ 和 foo. __proto__.__proto__ 所有属性的浅拷 贝(只复制基本数据类型,不复制对象)。所以可以直接访问foo.constructor(来自foo. __proto__,即Foo.prototype),foo.toString(来自foo. __proto__.__proto__, 即Object.prototype)。 
>
> console.log(foo.__proto__); //FooYou { name: 'Bar'}
> console.log(FooYou.prototype); //FooYou{ name: 'Bar'}
> console.log(FooYou.prototype.__proto__); //{name: 'My Object'}
> console.log(FooYou.prototype.__proto__.constructor); //[Function : Ojbect]
> console.log(FooYou.prototype.__proto__.prototype); // null
> console.log(FooYou.prototype.__proto__.__proto__); // undefined
> console.log(foo.prototype); //undefined
>
> #对象的复制
> 浅拷贝VS深拷贝
> 浅拷贝：共享对象属性
> Object.prototype.clone = function() {
> var newObj = {};
> for (var i in this) {
> newObj[i] = this[i];
> }
> return newObj;
> }
>
> var obj = {
> name: 'gaolongxiaohua',
> likes: ['node', 'OC']
> };
>
> var newObj = obj.clone();
> obj.likes.push('python');
> console.log(obj.likes); //[ 'node', 'OC', 'python' ]
> console.log(newObj.likes); //[ 'node', 'OC', 'python' ]
> 深拷贝：递归实现、对象中可能有对象
> Object.prototype.deepClone = function() {
> var newOjb = {};
> for (var i in this) {
> if (typeof(this[i]) == 'object' || typeof(this[i]) == 'function') {
> newObj[i] = this[i].deepClone();
> }else {
> newObj[i] = this[i];
> }
> }
> return newObj;
> }
>
> Array.prototype.deepClone = function() {
> var newArray = [];
> for (var i=0; i < this.length; i++) {
> if (typeof(this[i]) == 'object' || typeof(this[i]) == 'function') {
> newArray[i] = this[i].deepClone();
> }else {
> newArray[i] = this[i];
> }
> }
> return newArray;
> }
>
> Function.prototype.deepClone = function() {
> var that = this;
> var newFunc = function() {
> return that.apply(this, arguments);
> };
> for (var i in this) {
> newFunc[i] = this[i];
> }
> return newFunc;
> };
>
> var obj33 = {
> name: 'xiaohua',
> likes: ['hua', 'shit'],
> display: function() {
> console.log('chishi');
> }
> };
>
> var newObj33 = obj.deepClone();
> newObj33.likes.push('shishishihis');
> console.log(obj33.likes); //['hua', 'shit']
> console.log(newObj33.likes);// ['hua', 'shit','shishishihis']
> #注意:这种实现方式对于循环引用无法生效，甚至出现循环递归
> ```
>
> 1. 原型链
>
> ![屏幕快照 2016-04-25 下午2.19.46](/Users/schiller/Desktop/屏幕快照 2016-04-25 下午2.19.46.png)
>
> 1. over
> 2. over

#### RN组件、API

> 1. `PixelRatio`
>
>    ```javascript
>    static get() //返回设备的像素密度
>    static getFontScale() //返回字体大小缩放比例
>    static getPixelSizeForLayoutSize(layoutSize:number)//将一个布局尺寸转换成像素尺寸
>    ```
>
> 2. ​