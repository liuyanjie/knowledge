
1. `基本类型` 和 `引用类型` 的 `区别` 是什么？

2. 以下 `console.log` 输出是什么？

  ```js
  console.log(true === new Boolean(true), true == '1', false == '0') 
  console.log([] + [] + 0, {} === !{})
  console.log(true && 'A', false && 'A')
  ```

  ```js
  var v = 'Hello'
  ;(function() {
      console.log(v)
      var v = 'World'
  })()
  ```

  ```js
  for (var i = 0; i < 5; i++) {
      setTimeout(() => console.log(new Date, i), 1000)
  }
  console.log(new Date, i)
  ```

3. 以下 `console.log` 输出 是什么？代码存在什么问题？

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
  ```

  请写出 `one.toString` 的 `原型链` 查找路径： `one --> Extend.prototype --> （请补充） --> null`
