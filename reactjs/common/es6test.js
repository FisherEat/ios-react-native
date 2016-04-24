/**
 * created by schiller
 */

/**
 * function 函数
 */

console.log([1,2,3].map(x => x * x));

//箭头函数与解构赋值
function push(array, ...items) {
  array.push(...items);
}

/**
 * object 对象
 */

//this对象，js语言，在对象中使用this必须非常小心
var handler = {
    id: "123456",
    init: function() {
        document.addEventListener("click",
          event => this.doSomething(event.type), false);
    },

    doSomething: function(type) {
        console.log("Handling " + type + "for " + this.id);
    }
}

/**
 * function 函数
 */

/**
 * class 类
 */

/**
 * array,set数组、集合
 */

export default {
    push,
    handler,
}
