#### 精通javascript

##### nodejs支持es6

```javascript
'use strict'//加上这句声明
$ node test.js
```

##### let和const

```javascript
{
	let b = 100;
	var c = 1;
}
console.log(b);//b is not defined
let命令所在的代码块内有效。
for循环的计数器，就很合适使用let命令。

var array = ['gaolong', 'xiaoming', 'xiaoli'];
for (let i = 0; i < array.length; i++) {}
console.log(i); //i is not defined, i只在for循环体内有效

var array = ['gaolong', 'xiaoming', 'xiaoli'];
var a = [];
for (let i = 0; i < array.length; i++) {
	a[i] = function () {
		console.log(i);
	}
}
a[2](); //此处数组中存放的是函数，所以可以直接执行a[i]();重点比较let i与 var i的不同

let不存在变量提升,var存在。即脚本未执行前var变量已经存在，只是值为undefined.

let暂时性死区，temporal dead zone
var tmp = 123;
if (true) {
	tmp = 'abc'; //referenceError。该区域已经被let 覆盖。
	let tmp; 
}
let不允许在相同作用域内，重复声明同一个变量。
因此，不能在函数内部重新声明参数。
ES5只有全局作用域和函数作用域，没有块级作用域.
因此会出现这两种情况：
第一：内层变量可能会覆盖外层变量。
var tmp = new Date();
function f() {
    console.log(tmp);
    if (false) {
        var tmp = 'hello wolrd';
    }
}
f(); //undefined ,该使用let
'use strict';
if (true) {
  function f() {}
}
f(); // ReferenceError: f is not defined,es6函数在块级作用域内，外部不能使用。
第二：用来计数的循环变量泄露为全局变量。

const
只读常量，不能改变。
'use strict';
const pi = 3.14159;
pi // 3.14159
pi = 3; typeerror: pi is read-only
//如果是常规模式，不会报错，但是赋值无效
//const 一旦声明就必须赋值，const foo，报错
const的作用域与let命令相同：只在声明所在的块级作用域内有效。
const命令声明的常量也是不提升，同样存在暂时性死区，只能在声明的位置后使用
const声明的常量，也与let一样不可重复声明。

对于复合类型的变量，变量名不指向数据，而是指向数据所在的地址。const命令只是保证变量名指向的地址不变，并不保证该地址的数据不变，所以将一个对象声明为常量必须非常小心。
const foo = {}
foo.prop = 123;
foo.prop ;// 123
foo = {} //type error ;foo is readonly
const a = [];
a.push('Hello');//ok
a.length = 0; //ok
a = ["schiller"]; //error
如果真的想将对象冻结，应该使用Object.freeze方法。

 全局对象属性
 全局对象是最顶层的对象，在浏览器环境指的是window对象，在Node.js指的是global对象。ES5之中，全局对象的属性与全局变量是等价的。
 var a = 1;
// 如果在Node的REPL环境，可以写成global.a
// 或者采用通用方法，写成this.a
window.a // 1

let b = 1;
window.b // undefined
上面代码中，全局变量a由var命令声明，所以它是全局对象的属性；全局变量b由let命令声明，所以它不是全局对象的属性，返回undefined。

```

##### 解构赋值

```javascript
//注意，解构赋值在node环境中暂且无法运行，具体原因待探究，可以使用新建rn项目 //跑来测试
ES6允许按照一定模式，从数组和对象中提取值，对变量进行赋值，这被称为解构（Destructuring）。
var [a, b, c] = [1, 2, 3];
let [x, y, ...z] = ['a'];
// x = 'a', y = undefined, z = []
如果解构不成功，变量的值就等于undefined。
如果等号右边不是数组，严格的说不是可遍历结构，那将会报错。
//报错
let [foo] = 1;
let [foo] = false;
let [foo] = NaN;
let [foo] = undefined;
let [foo] = null;
let [foo] = {};
上面的表达式都会报错，因为等号右边的值，要么转为对象以后不具备Iterator接口（前五个表达式），要么本身就不具备Iterator接口（最后一个表达式）
事实上，只要某种数据结构具有Iterator接口，都可以采用数组形式的解构赋值。
function* fibs() {
  var a = 0;
  var b = 1;
  while (true) {
   yield a;
    [a, b] = [b, a+b]; 
  }
}
var [first ,second, third, fourth, fifth, sixth] = fibs();
sixth //5
默认值
var [foo = true] = [];
foo //true
ES6内部使用严格相等运算符（===），判断一个位置是否有值。所以，如果一个数组成员不严格等于undefined，默认值是不会生效的。
如：
[x, y = 'b'] = ['a']; // x='a', y='b'
[x, y = 'b'] = ['a', undefined]; // x='a', y='b'
var [x = 1] = [null] //x = null

对象的解构赋值
解构赋值还可以用于对象
var {foo, bar} = {foo: 'aaa', bar: 'bbb'};
// foo = 'aaa', bar = 'bbb'
对象的解构与数组有一个重要的不同。数组的元素是按次序排列的，变量的取值由它的位置决定；而对象的属性没有次序，变量必须与属性同名，才能取到正确的值，如：
var {foo, bar} = {bar:'aaa', foo: 'bbb'};
//foo = "bbb", bar='aaa'
对象的解构赋值的内部机制，是先找到同名属性，然后再赋给对应的变量。真正被赋值的是后者，而不是前者。
var {foo: baz} = {foo:'aaa', bar:'bbb'}
//baz = 'aaa' //foo  error, foo is not defined
//类似var { foo: foo, bar: bar } = { foo: "aaa", bar: "bbb" };
变量的声明和赋值是一体的
对于let和const来说，变量不能重新声明，所以一旦赋值的变量以前声明过，就会报错。
let foo;
let {foo} = {foo:1} //erro, duplicate declaration of foo
上面代码中，解构赋值的变量都会重新声明，所以报错了。不过，因为var命令允许重新声明，所以这个错误只会在使用let和const命令时出现。如果没有第二个let命令，上面的代码就不会报错。
let foo;
({foo} = {foo:1}) //ok
//允许嵌套s
var obj = {
      p: [
        "Hello",
        {y: 'world'} 
      ]
    };
 var {p:[x, {y}]} = obj;
//对象的解构也可以指定默认值，默认值生效的条件是，对象的属性值严格等于undefined

字符串的解构赋值
const [a, b,c,d, e] = 'hello';//a ='h', ...
类似数组对象都有一个length
let {length : len} = 'hello';
len // 5
数值和布尔值得解构赋值
解构赋值时，如果等号右边是数值和布尔值，则会先转为对象。
let {toString: s} = 123;
s === Number.prototype.toString // true
let {toString: s} = true;
s === Boolean.prototype.toString // true
 
函数参数的解构赋值
function add([x,y]) {
  return x + y;
} 
var arr = [[1, 2], [3, 4]].map(([a, b]) => a + b);

函数的解构也可以使用默认值
function move ({x = 0, y = 0} = {}) {
  return [x ,y];
}
move({x: 3, y: 8});  //[3,8]
move({x: 3}); //[3,0]
move({}); //[0,0]
move(); // [0,0]

function move({x, y} = { x: 0, y: 0 }) {
  return [x, y];
}

move({x: 3, y: 8}); // [3, 8]
move({x: 3}); // [3, undefined]
move({}); // [undefined, undefined]
move(); // [0, 0]
上面代码是为函数move的参数指定默认值，而不是为变量x和y指定默认值，所以会得到与前一种写法不同的结果。
```

##### 解构赋值用途

```javascript
1、交换变量的值
[x, y] = [y, x]; 
2、 从函数返回多个值
// 返回一个数组
 
function example() {
  return [1, 2, 3];
}
var [a, b, c] = example();
 
// 返回一个对象
 
function example() {
  return {
    foo: 1,
    bar: 2
  };
}
var { foo, bar } = example();
3、 函数参数的定义
// 参数是一组有次序的值
function f([x, y, z]) { ... }
f([1, 2, 3])
// 参数是一组无次序的值
function f({x, y, z}) { ... }
f({z: 3, y: 2, x: 1})
4、 提取JSON数据
var jsonData = {
  id: 42,
  status: "OK",
  data: [867, 5309]
}
let { id, status, data: number } = jsonData;
 
console.log(id, status, number)
// 42, OK, [867, 5309]
 
5、 函数参数的默认值
jQuery.ajax = function (url, {
  async = true,
  beforeSend = function () {},
  cache = true,
  complete = function () {},
  crossDomain = false,
  global = true,
  // ... more config
}) {
  // ... do stuff
}; 
6、 遍历Map结构  
var map = new Map();
map.set('first', 'hello');
map.set('second', 'world');
 
for (let [key, value] of map) {
  console.log(key + " is " + value);
}
// first is hello
// second is world
 
如果只想获取键名，或者只想获取键值，可以写成下面这样。    
// 获取键名
for (let [key] of map) {
  // ...
}
 
// 获取键值
for (let [,value] of map) {
  // ...
}    
7、 输入模块的指定方法    
const { SourceMapConsumer, SourceNode } = require("source-map"); 
```

##### 字符串的扩展

```javascript
字符的Unicde表示法
codePointAt() //如果确实要处理字符
String.fromCodePoint()
字符串的遍历器接口
at();
'abc'.at(0) // "a"
'𠮷'.at(0) // "𠮷"
normalize()
includes(), startsWidth(),endsWith()
传统上，JavaScript只有indexOf方法，可以用来确定一个字符串是否包含在另一个字符串中。ES6又提供了三种新方法:
includes()：返回布尔值，表示是否找到了参数字符串。
startsWith()：返回布尔值，表示参数字符串是否在源字符串的头部。
endsWith()：返回布尔值，表示参数字符串是否在源字符串的尾部。
var s = 'Hello world!';

s.startsWith('Hello') // true
s.endsWith('!') // true
s.includes('o') // true
//第二个参数表示搜索位置
var s = 'Hello world!';
s.startsWith('world', 6) // true
s.endsWith('Hello', 5) // true
s.includes('Hello', 6) // false
repeat()
repeat方法返回一个新字符串，表示将原字符串重复n次。

es7提供补齐padStart(), padEnd()
'x'.padStart(5, 'ab').// 'ababx'
'x'.padEnd(4, 'ab').// 'xabab'

模板字符串
标签模板、实例模板：暂不讨论

String.raw();

```

##### 正则扩展

```javascript
RegExp构造函数
var regex = new RegExp('xyz', 'i');
//等价
var regex = /xyz/i
或者
var regex = new RegExp(/xyz/i);
=> var regex = /xyz/i
es6:
new RegExp(/abc/ig, 'i').flags //'i'

字符串的正则方式：
字符串对象共有4个方法，可以使用正则表达式：match()、replace()、search()和split()。

正则匹配难度比较大，暂时不讨论
```

##### 数值类型

```javascript
二进制和八进制的表示
ES6提供了二进制和八进制数值的新的写法，分别用前缀0b（或0B）和0o（或0O）表示。
0b111110111 === 503 // true
0o767 === 503 // true
Number.isFinite() , NumberisNaN()
ES6在Number对象上，新提供了Number.isFinite()和Number.isNaN()两个方法，用来检查Infinite和NaN这两个特殊值。
Number.isFinite()用来检查一个数值是否非无穷（infinity）。
Number.isFinite(15); // true
Number.isFinite(0.8); // true
Number.isFinite(NaN); // false
Number.isFinite(Infinity); // false
Number.isFinite(-Infinity); // false
Number.isFinite('foo'); // false
Number.isFinite('15'); // false
Number.isFinite(true); // false
Number.isNaN()用来检查一个值是否为NaN。
它们与传统的全局方法isFinite()和isNaN()的区别在于，传统方法先调用Number()将非数值的值转为数值，再进行判断，而这两个新方法只对数值有效，非数值一律返回false。

Number.parseInt(), Number.parseFloat()
// ES5的写法
parseInt('12.34') // 12
parseFloat('123.45#') // 123.45

// ES6的写法
Number.parseInt('12.34') // 12
Number.parseFloat('123.45#') // 123.45

Number.isInteger()
Number.isInteger()用来判断一个值是否为整数。
Number.isInteger(25) // true
Number.isInteger(25.0) // true //js中25和25.0采用同样的存储方式
Number.isInteger(25.1) // false 
Number.isInteger("15") // false
Number.isInteger(true) // false

//js中这样部署 Number.isInteger();
(function (global) {
  var floor = Math.floor,
    isFinite = global.isFinite;

  Object.defineProperty(Number, 'isInteger', {
    value: function isInteger(value) {
      return typeof value === 'number' && isFinite(value) &&
        value > -9007199254740992 && value < 9007199254740992 &&
        floor(value) === value;
    },
    configurable: true,
    enumerable: false,
    writable: true
  });
})(this);

ES6在Number对象上面，新增一个极小的常量Number.EPSILON。
Number.EPSILON
// 2.220446049250313e-16
Number.EPSILON.toFixed(20)
// '0.00000000000000022204'

//JavaScript能够准确表示的整数范围在-2^53到2^53之间（不含两个端点），超过这个范围，无法精确表示这个值。
Number.MAX_SAFE_INTEGER和Number.MIN_SAFE_INTEGER
Number.isSafeInteger()则是用来判断一个整数是否落在这个范围之内

Math对象的扩展
Math.trunc() 、 Math.sign() 、Math.cbrt() 、Math.clz32
Math.imul()、Math.fround()、Math.hypot()、
对数方法
Math.expm1()//Math.expm1(x)返回ex - 1，
Math.log1p()、Math.log10()、Math.log2()
三角方法
指数运算符
let a = 2;
a **= 2;
// 等同于 a = a * a;

let b = 3;
b **= 3;
// 等同于 b = b * b * b;

```

##### 数组的扩展

```javascript
Array.from() //将类似数组的对象转成真正的数组
let arrayLike = {
  '0': 'a',
  '1': 'b',
  '2': 'c',
  length: 3,
};
// ES5的写法
var arr1 = [].slice.call(arrayLike); // ['a', 'b', 'c']

// ES6的写法
let arr2 = Array.from(arrayLike); // ['a', 'b', 'c']
Array.from('hello') ;// ['h', 'e'...];

Array.from(arrayLike, x => x * x);
// 等同于
Array.from(arrayLike).map(x => x * x);
Array.from([1, 2, 3], (x) => x * x)
// [1, 4, 9]

Array.of方法用于将一组值，转换为数组。
Array.of(3,11,8) //[3， 11，8];

copyWithin()
数组实例的copyWithin方法，在当前数组内部，将指定位置的成员复制到其他位置（会覆盖原有成员），然后返回当前数组。target、start、end三个参数
[1, 2, 3, 4, 5].copyWithin(0, 3)// [4, 5, 3, 4, 5]

find的()和findIndex//数组实例的find方法，用于找出第一个符合条件的数组成员
[1, 4, -5, 10].find((n) => n < 0)// -5
[1, 5, 10, 15].findIndex(function(value, index, arr) {
  return value > 9;
}) // 2
fill方法使用给定值，填充一个数组。
['a', 'b', 'c'].fill(7)
// [7, 7, 7]
new Array(3).fill(7)
// [7, 7, 7]
fill方法还可以接受第二个和第三个参数，用于指定填充的起始位置和结束位置。
['a', 'b', 'c'].fill(7, 1, 2);// ['a', 7, 'c']
数组实例的entries(), keys(), values()

```

##### 函数的扩展

```javascript
javascript中函数就是对象。对象是键值对的集合并拥有一个连接到原型对象的隐形连接,对象连接到Object.prototype，函数连接到Function.prototype.
函数是对象。
函数字面量：保留字function 、函数名（可省略，用于递归）、参数、执行域
var add = function(a, b) {
  return a+b;
}
//箭头函数
var sum = (c, d) => {return c+d};
方法调用模式:当一个函数是一个对象的属性时
var myObject = {
  value: 0,
  increment: function (inc) {
    this.value += typeof inc === 'number' ? inc : 1;
  }
};
myObject.increment(); 
alert(myObject.value);// 1;
函数调用模式：当一个函数并非一个对象的属性时。
当函数以此模式调用时，this被绑定到全局对象。这是语言设计上的一个错误。正确的设计应该是当内部函数被调用时，this应该仍然绑定到外部函数的this变量。
var sum = add(3,4);
//解决的办法是：如果该方法定义一个变量并给它赋值this,那么内部函数就可以通过这个变量访问到外部函数的this.
//给myObject增加一个double方法。
myObject.double = function () {
  var that = this;//如果不这么赋值会发生意想不到的错误，内部函数无法访问到外部的this,内部函数访问的是全局的this,就有bug.
  var helper = function () {
  that.value = add(that.value, that.value);
 }
  helper();//以函数形式调用helper.
};
myOjbect.double(); //myOjbect.value = 2, 否则是1.

构造器调用模式：
var Quo = function (string) {//创建一个Quo名的构造器函数。并构造一个带有status属性的对象。
    this.status = string;
 } 
Quo.prototype.get_status = function() {//给Quo的所有实例提供一个方法。
     return this.status;
};
var myQuo = new Quo("confused"); //new 构造一个Quo实例
alert(myQuo.get_status());

Apply调用模式
javascript是函数式的面向对象的语言，所以函数可以拥有方法。
apply方法让我们构建一个参数数组并用其去调用函数，apply方法接收两个参数，一个是将被绑定给this的值，第二个是参数数组。
var array = [3, 5];
var sum = add.apply(null, array);//sum = 8
var statusObject = {
  status: 'A-OK',
};
var status = Quo.prototype.get_status.apply(statusObject); //status : 'A-OK'

函数参数：arguments数组是默认的。
返回值：
异常：

给函数添加方法：Function.prototype.method = function() {}

递归：
```

##### ES6函数

```javascript
箭头函数：
var f = v => v， 等同于： var f = function(v) {return v;};
var geetTmpItem = id => ({id:id, name: 'Tmp'});//返回对象时
const full = ({first, last}) => first + '' + last;//变量解构

```

##### Class类

```javascript
1.ES5写法
function Point(x, y) {
	this.x = x;
	this.y = y;
}
Point.prototype.toString = function() {
	return '(' + this.x + ',' + this.y + ')';
};
console.log(Point.prototype);[ 'toString' ]

2.ES6写法
class Point {
	constructor(x, y) {//默认方法
		this.x = x;
		this.y = y;
	}
	toString() {
		return '(' + this.x + ',' + this.y + ')';
	}
    get prop () {//定义getter和setter函数
        return 'shit-get';
    }
    set prop(value) {
        console.log('setter'+value);
    }
    static classMethod() {//静态方法
        return 'Hello, world';
    }
}
var point = new Point(8,0);
console.log(point.toString());//(8.0)
console.log(typeof point);//object
console.log(typeof Point);//function
console.log(Point.classMethod());//调用静态方法
类的所有方法都定义在类的prototype属性上面,在类的实例上面调用方法，其实就是调用原型上的方法,如下
point.constructor = Ponit.prototype.constructor//true

3.类的内部所有定义的方法，都是不可枚举的（non-enumerable),这与ES5不一致。
console.log(Point.prototype);// Point{}
console.log(Object.getOwnPropertyNames(Point.prototype));//[ 'constructor', 'toString' ]
console.log(point.hasOwnProperty('x'));//true
console.log(point.hasOwnProperty('toString'));//false
console.log(point.__proto__.hasOwnProperty('toString'));//true
4.同ES5,类的所有实例共享一个原型对象
point1.__proto__ = point2.__proto__
可以通过__proto__为Class添加方法。
point.__proto__.printName = function(){};
//同
Point.prototype.printName = function(){};

4.以上更改类慎用

5.class继承
class ColorPoint extends Point{}
子类必须在constructor方法中调用super方法，否则新建实例会报错。

6.类的prototype和__proto__
（1）子类的__proto__属性，表示构造函数的继承，总是指向父类。
（2）子类prototype属性的__proto__属性，表示方法的继承，总是指向父类的prototype属性。
class A{} class B extends A{}
B.__proto__ === A;//true
B.prototype.__proto__ === A.prototype;//true
Object.getPrototypeOf方法可以用来从子类上获取父类:
Object.getPrototypeOf(B) == A//true

7.super关键字
super这个关键字，有两种用法，含义不同。
（1）作为函数调用时（即super(...args)），super代表父类的构造函数。
（2）作为对象调用时（即super.prop或super.method()），super代表父类。注意，此时super既可以引用父类实例的属性和方法，也可以引用父类的静态方法。

8.实例的__proto__属性
子类实例的__proto__属性的__proto__属性，指向父类实例的__proto__属性。也就是说，子类的原型的原型，是父类的原型。
因此，通过子类实例的__proto__.__proto__属性，可以修改父类实例的行为。

9.ES6允许原生构造函数的继承
class MyArray extends Array {
  constructor(...args) {
    super(...args);
  }
}
但是es5是不能够直接继承原生构造函数的。
Boolean()/Number()/String()/Array()/Date()/Function()/RegExp()/Error/Object()

9.Class的getter、setter
写法见上2。

10.class的generator函数
class Foo {
	constructor(...args) {
		this.args = args;
	}
	* [Symbol.iterator]() {
		for (let arg of this.args) {
			yield arg;
		}
	}
}
for (let x of new Foo('hello', 'world')) {
	console.log(x);
}
如果某个方法之前加上星号（*），就表示该方法是一个Generator函数。
Symbol.iterator方法返回一个Foo类的默认遍历器，for...of循环会自动调用这个遍历器.

11.Class的静态方法
类相当于实例的原型，所有在类中定义的方法，都会被实例继承。
如果在一个方法前，加上static关键字，就表示该方法不会被实例继承，而是直接通过类来调用，这就称为“静态方法”。
代码见上2。
父类静态方法可以被子类继承，且可以从super对象调用。

12.Class静态属性和实例属性
class Foo {
}
Foo.prop = 1;
Foo.prop // 1
只有之中方法定义可行。es6类内部不能定义静态属性。
目前，es6的实例属性也只能定义在方法或者constructor方法里。es7允许。

13.newTarget属性
14.Mixin模式
Mixin模式指的是，将多个类的接口“混入”（mix in）另一个类。它在ES6的实现如下。
class DistributedEdit extends mix(Loggable, Serializable) {
  // ...
}
```

##### Promise对象

```javascript
1.Promise含义、基本用法
var promise = new Promise(function(resolve, reject) {
	console.log('fuck');
	var shit = 'g';
	if ('st') {
		resolve('shit');
	}else {
		reject('go');
	}
});
console.log(promise);
promise.then(function(value) {//使用、success、resolved
	console.log('we did it.');
}, function(error) {//failure、rejected
});
Promise对象三种状态：Pending、Resolved、Rejected
then方法可以接受两个回调函数作为参数。第一个回调函数是Promise对象的状态变为Resolved时调用，第二个回调函数是Promise对象的状态变为Reject时调用。其中，第二个函数是可选的，不一定要提供。这两个函数都接受Promise对象传出的值作为参数。
console.log(Object.getOwnPropertyNames(promise.__proto__));
//[ 'constructor', 'chain', 'then', 'catch' ]

2.Promise对象实例
var getJSON = function(url) {
  var promise = new Promise(function(resolve, reject){
    var client = new XMLHttpRequest();
    client.open("GET", url);
    client.onreadystatechange = handler;
    client.responseType = "json";
    client.setRequestHeader("Accept", "application/json");
    client.send();

    function handler() {
      if (this.readyState !== 4) {
        return;
      }
      if (this.status === 200) {
        resolve(this.response);
      } else {
        reject(new Error(this.statusText));
      }
    };
  });

  return promise;
};

getJSON("/posts.json").then(function(json) {
  console.log('Contents: ' + json);
}, function(error) {
  console.error('出错了', error);
});

3.Promise.prototype.then()
console.log(Object.getOwnPropertyNames(promise.__proto__));//[ 'constructor', 'chain', 'then', 'catch' ]
then方法的第一个参数是Resolved状态的回调函数，第二个参数（可选）是Rejected状态的回调函数。
then方法返回的是一个新的Promise实例（注意，不是原来那个Promise实例）。因此可以采用链式写法，即then方法后面再调用另一个then方法。
getJSON("/posts.json").then(function(json) {
  return json.post;
}).then(function(post) {
  //...
});
面的代码使用then方法，依次指定了两个回调函数。第一个回调函数完成以后，会将返回结果作为参数，传入第二个回调函数。

4.Promise.prototype.catch()
Promise.prototype.catch方法是.then(null, rejection)的别名，用于指定发生错误时的回调函数。
getJSON("/posts.json").then(function(posts) {
  //...
}).catch(function(error) {
    // 处理 getJSON 和 前一个回调函数运行时发生的错误
  console.log('发生错误！', error);
});//如果状态变为Rejected则会调用catch方法指定回调函数。处理错误。

5.Promise.all()
用于将多个Promise实例包装成一个新的Promise实例。只要数组中其中一个状态被reject,则返回一个reject实例。
var promises = [1,3,4,5,90,8].map(function(id) {
  return getJSON("/post/" + id + ".json");
});
Promise.all(promises).then(function(post){
//...
}).catch(function(reason){
  /...
});

6.Promise.race()
同上、方法
7.Promise.resolve()
该方法将现有对象转化为Promise对象。
Promise.resolve('foo')
//等价于
new Promise(resolve => resolve('foo'));
8.Promise.reject()
Promise.reject(reason)方法也会返回一个新的Promise实例，该实例的状态为rejected。用法与上面一致
var p = Promise.reject('出错了');
=> var p = new  Promise((resolve, reject) => reject('出错了'))；
p.then(null, function(s) {
  console.log(s);
});//出错了
9.done()和finally()

Promise对象的回调链，不管以then方法或catch方法结尾，要是最后一个方法抛出错误，都有可能无法捕捉到（因为Promise内部的错误不会冒泡到全局）。因此，我们可以提供一个done方法，总是处于回调链的尾端，保证抛出任何可能出现的错误.
10.应用
const preloadImage = function (path) {
  return new Promise(function (resolve, reject) {
    var image = new Image();
    image.onload  = resolve;
    image.onerror = reject;
    image.src = path;
  });
};
async函数与Promise、Generator函数一样，是用来取代回调函数、解决异步操作的一种方法。它本质上是Generator函数的语法糖。async函数并不属于ES6，而是被列入了ES7，但是traceur、Babel.js、regenerator等转码器已经支持这个功能，转码后立刻就能使用。
```
##### Set和Map结构

```javascript
1.Set,不会重复添加元素
var s = new Set();
[1,2,1,5,5,8,6,2,7].map(x=>s.add(x));
for(let i of s){log(i)}//1,2,5,6,7,8
2.常用操作
var set = new Set([1,2,3,4,4]);
[...set];//[1,2,3,4]
set.size; 4
[...new Set(array)];//去除数组重复成员
向Set加入值的时候，不会发生类型转换，5和'5'不同，NaN等于自身
两个对象总是不等：set.add({}); set.size =1,set.add({}),set.size=2;

2.属性和方法
属性：constructor、size
方法：操作方法和遍历方法
get(key);
set(key,value);
add(value)
delete(value)
has(value)
clear()
Array.from(set)=>array
keys();
values();
entries();
forEach();set.forEach((value, key)=>console.log(value*2));
扩展运算符内部用for...of循环，所以也可以用于Set结构,数组的map和filter方法也可以用于Set了。
let a = new Set([1, 2, 3]);
let b = new Set([4, 3, 2]);
// 并集
let union = new Set([...a, ...b]);
// [1, 2, 3, 4]
// 交集
let intersect = new Set([...a].filter(x => b.has(x)));
// [2, 3]
// 差集
let difference = new Set([...a].filter(x => !b.has(x)));
// [1]
3.WeakSet
4.Map
JavaScript的对象（Object），本质上是键值对的集合（Hash结构），但是只能用字符串当作键。这给它的使用带来了很大的限制.
Map也是键值对，但是键的范围不限于字符串，各种类型的值都可以当做对象。
var m = new Map();
var o = {p: 'Hello world'};
m.set(o, 'content');
m.get(o);//"content"
m.has(o)//true
m.delete(o)//true
m.has(o)//false
var map = new Map([['name', '张三'], ['title', 'Author']]);//接受数组做参数
3.与其他类型的互相转化
let myMap = new Map().set(true, 7).set({foo: 3}, ['abc']);
[...myMap]；// [ [ true, 7 ], [ { foo: 3 }, [ 'abc' ] ] ]
转为对象：
function strMapToObj(strMap) {
  let obj = Object.create(null);
  for (let [k,v] of strMap) {
    obj[k] = v;
  }
  return obj;
}

```

##### Module

```javascript
1.前言
JavaScript语言一直没有分模块的东西，社区解决方案是CommonJS和AMD两种。
静态优化、运行时加载。
es5、CommonJS模块
let {stat, exits, readFile } = require('fs');
上述代码中实质上是整体加载fs模块生成一个对象，然后从对象中读取三个方法。为运行时加载。
es6、Module
import {stat, exits, readFile} from 'fs';
上述代码的实质是从fs中加载3个方法，其他方法不加载，为编译时加载。

2.use strict
严格模式主要有以下限制。

变量必须声明后再使用
函数的参数不能有同名属性，否则报错
不能使用with语句
不能对只读属性赋值，否则报错
不能使用前缀0表示八进制数，否则报错
不能删除不可删除的属性，否则报错
不能删除变量delete prop，会报错，只能删除属性delete global[prop]
eval不会在它的外层作用域引入变量
eval和arguments不能被重新赋值
arguments不会自动反映函数参数的变化
不能使用arguments.callee
不能使用arguments.caller
禁止this指向全局对象
不能使用fn.caller和fn.arguments获取函数调用的堆栈
增加了保留字（比如protected、static和interface）

3.export命令
export 可输出函数、类、变量
export var firstName = 'Mike';
export default Home;
export {firstName, lastName, year};
export function mutiply(x, y) {
  return x * y;
}
export {f};//f为function
通常情况下，export输出的变量就是本来的名字，但是可以使用as关键字重命名。
function v1(){...}
export {v1 as streanV1};
另外，export语句输出的接口，与其对应的值是动态绑定关系，即通过该接口，可以取到模块内部实时的值。
export var foo = 'bar';
setTimeout(() => foo = 'baz', 500);上面代码输出变量foo，值为bar，500毫秒之后变成baz

4.import
import {firstName, lastName, year} from './profile';
import {lastName as surname} from './profile';//使用as关键字重命名

5.模块的整体加载
//circel.js
export function area(){}
export function name(){}
//main.js
import {area, name} from './circle'
整体加载：使用 * as关键字
import * as circle from './circle'
console.log(circle.area);

6.export default命令
为了给用户提供方便，让他们不用阅读文档就能加载模块，就要用到export default命令，为模块指定默认输出。
export default function() {log('foo')}; //export_default.js
import  customname from './export_default'
 customName();//'foo'
 
7.模块的继承

```

##### Generator函数

```javascript
1.属性
Generator函数有多种理解角度。从语法上，首先可以把它理解成，Generator函数是一个状态机，封装了多个内部状态。
执行Generator函数会返回一个遍历器对象，也就是说，Generator函数除了状态机，还是一个遍历器对象生成函数。返回的遍历器对象，可以依次遍历Generator函数内部的每一个状态。
function* helloworldGenerator() {
	yield 'hello';
	yield 'world';
	return 'ending';
}
var hw = helloworldGenerator();
hw.next();//hello,done
hw.next();//world;
hw.next();//ending
hw.next();//undefined
2.for...of循环
for(let v of helloworldGenerator()) {
  console.log(v);//1 2 3 4 5
}

```