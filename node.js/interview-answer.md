
1. `基本类型` 和 `引用类型` 的 `区别` 是什么？（20分）

  基本类型：值是不可变的; 不可以添加属性和方法; 赋值是简单赋值; 比较是值的比较; 存放在栈区的

2. 以下 `console.log` 输出是什么？（40分 = 7 * 2 + 6 * 1 + 20）

  ```js
  console.log(true === new Boolean(true), true == '1', false == '0') 
  // false true true
  console.log([] + [] + 0, {} === !{}) // 0 false
  console.log(true && 'A', false && 'A') // A false
  ```

  ```js
  var v = 'Hello'
  ;(function() {
      console.log(v) // undefined
      var v = 'World'
  })()
  ```

  ```js
  for (var i = 0; i < 5; i++) {
      setTimeout(() => console.log(new Date, i), 1000)
  }
  console.log(new Date, i)
  // 5 5 5 5 5 5 有 6 个 5 就是正确的答案
  ```

3. 以下 `console.log` 输出 是什么？代码存在什么问题？（40分 = 10分 + 10分 + 20分）

  ```js
  function Base(name){
    this.sex = 0
    this.name = name || 'base'
    this.hello = function () { console.log(`hello ${name}`) }
  }
  Base.prototype.say = function() { console.log(`name: ${this.name}`) }
  function Extend(name, num) {
    this.num = num || 0
  }
  Extend.prototype = new Base()
  var one = new Extend('one', 2)
  console.log(one.name, one.sex, one.num, one.say(), one.hello())
  // name: base | hello undefined | base 0 2 undefined undefined
  // name: one  | hello one       | one  0 2 undefined undefined
  ```

  请写出 `one.toString` 的 `原型链` 查找路径： `one --> Extend.prototype --> （请补充） --> null`
  
  `one --> Extend.prototype --> Base.prototype --> Object.prototype --> null`
