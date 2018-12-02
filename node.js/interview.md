# 笔试题

* [一道常被人轻视的前端JS面试题](https://www.cnblogs.com/xxcanghai/p/5189353.html)
* [80% 应聘者都不及格的 JS 面试题](https://juejin.im/post/58cf180b0ce4630057d6727c)

## JavaScript

1. `原始类型`有哪些？`引用类型`有哪些？`原始类型`和`引用类型`有什么差异？

2. `undefined` 与 `null` 的区别？

3. 实现 `type() {}` 函数，可以识别 `基本类型`（包括`undefined` `null`）和 任意 `引用类型`。

4. 以下内容输出？

  ```js
  console.log([] + [] + 0)
  console.log([[]] + 0)
  console.log([[1, 2, 3]] + 0 + true + false)
  console.log([] + {} + 0)
  console.log(0 + {} + [] + 0)
  console.log([] == [])
  console.log([] === [])
  console.log(undefined == null)
  console.log('dd is ' + ('test' === 'test') ? 'test' : 'other')

  var v = 'Hello'
  (function(){
      console.log(v)
      var v = 'World'
  })()
  ```

5. 什么是 `数据属性`？什么是 `访问器属性`？有什么用途？

6. 如何防止对象的属性被修改？

7. `new` 操作符 都做了什么？

8. 实现函数 `function mul(){}`，实现如下效果：

  ```js
  console.log(mul(2)(3)(4)) // output : 24 
  console.log(mul(4)(3)(4)) // output : 48
  ```

9. Prototype Chain

  ```js
  function Foo(y) { this.y = y; }
  Foo.prototype.x = 10;
  Foo.prototype.calculate = function (z) {
    return this.x + this.y + z;
  };
  var b = new Foo(20);
  var c = new Foo(30);
  ```

  以下实例中哪些具有相等关系？例如：`b.__proto__ === Foo.prototype`

  * `null`
  * `Function` | `Function.prototype` | `Function.__proto__`
  * `Object` | `Object.prototype` | `Object.__proto__` | `Object.__proto__.__proto__`
  * `Foo` | `Foo.prototype` | `Foo.prototype.calculate` | `Foo.__proto__`
  * `b.__proto__` | `b.__proto__.calculate` | `b.calculate`


10. `try...catch...finally` 为什么无法捕获异常？

11. 使用过哪些异步流程控制库？

12. 请实现简单的 `co` 函数，自动执行 `Generator` 函数

13. 以下代码的输出

  ```js
  for (var i = 0; i < 5; i++) {
      setTimeout(function() {
          console.log(new Date, i);
      }, 1000);
  }

  console.log(new Date, i);
  ```

## Node.js

1. Node.js 特性特点


2. 哪些工具可以用来保证一致的编程风格？


3. 请使用 `http` 模块实现一个 `WebServer`，实现接收上传的文件数据（无需保存文件）


4. 实现 `function md5()` 函数


5. `setTimeout` 是如何工作的？

