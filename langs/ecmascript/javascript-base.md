# JavaScript Base

JavaScript 基础知识整理

## 数据类型


### 基本类型 [Primitive](https://developer.mozilla.org/en-US/docs/Glossary/Primitive)

`Undefined、Null、Boolean、Number、String、Symbol(ES2015)`

原始类型 和 原始值

基本类型的值 是不可变的，我们无法给它们添加属性。

基本类型的值 不是一个对象，也没有方法。


```js
var str = '~~~~~';
str.prop = '!!!!!';
str.prop; // undefined

var num = 10;
num.prop = 11;
num.prop; // undefined

var bool = true;
bool.prop = '';
bool.prop // undefined

'---'.charAt === String.prototype.charAt
(12345).toString(); // 使用数字调用方法时需要用用括号括起来
```


#### `Boolean`、`Number`、`String`、`Symbol`

  * 这三种基本类型分别存在 `Boolean()`、`Number()`、`String()` 内建函数
  * 平时使用的时候大都使用的是字面量形式，字面量并不是对象
  * 当需要的时候，它们也会被转换成对象，也就是会被转换成 **基本类型的包装类型**

  `valueOf()` 方法返回 原始值

#### `Undefined`、`Null`

  * 并不存在 `Undefined()` 和 `Null()` 内建函数，只存在 `Undefined` 和 `Null` 类型的内建对象 `undefined` 和 `null`
  * ECMAScript 认为 `undefined` 是从 `null` 派生出来的，所以把它们定义为 **值** 相等的，但是类型不等，相同的地方是都可以视为布尔值的 `false`
  * 这两个类型无 **包装类型**


`undefined` 与 `null` 的区别：

1. `null` 表示 **没有对象**，即该处不应该有值
    * 作为函数的参数，表示该函数的参数不是对象
    * 作为对象原型链的终点

1. `undefined` 表示 **缺少值**，即应该有一个值但是 **未定义/未赋值**
    * 变量被声明了，但没有赋值时，该变量 `undefined`
    * 调用函数时，参数没有提供，该参数 `undefined`
    * 对象没有赋值的属性，该属性 `undefined`
    * 函数没有返回值时，返回 `undefined`


### 引用类型

`Object、Function、String、Number、Error、Regexp、Map、Set` ...

JavaScript 中一切都可以被当做对象！但是只有引用类型才是真正的对象，基本类型除了 `null` 和 `undefined` 之外，都可以像对象一样使用，因为他们有包装类型。


#### Object{} - 对象

```js
var obj = {};
var boolObj = new Object({});
console.log(obj instanceof Object);         // true
console.log(boolObj instanceof Object);     // true
console.log(obj === boolObj);               // false
console.log(typeof obj);                    // object
console.log(typeof boolObj);                // object
```


#### Function - 函数对象


Function 是一个构造函数，用于创建一个函数对象：

```js
var foo = new Function ([arg1[, arg2[, ...argN]],] functionBody)

var foo = new Function () {}
```

function 是一个关键字可以声明一个函数对象：

```js
// 函数声明
function foo() {}

// 函数表达式
var foo = function () {}

// 每一个函数对象都继承 Function 构造函数的原型对象。
Function.prototype.foo = 1

var bar = function () {}
bar.foo // 1
```


#### Array[] - 复合类型 （引用，指针）


数组是对象，能够添加属性：

```js
var arr = [1, 2, 3];
arr.i = 4;
console.log(arr); // [1, 2, 3, i: 4]
for(var a in arr) {
  console.log(a, arr[a]);
}
// 0 1
// 1 2
// 2 3
// i 4
```

```js
var foo = [1, 2, 3, 4, 5, 6];
foo.length = 3;
foo; // [1, 2, 3]

foo.length = 6;
foo.push(4);
foo; // [1, 2, 3, undefined, undefined, undefined, 4]
```


#### 类数组对象


一个JS数组是特殊的, 因为：

1. 它的 `length` 属性有些特殊行为：
    1. 当新的元素添加到列表中，其值自动更新；
    1. 设置这一属性可以扩展或截断数组。
1. 数组是 `Array` 的实例，可以调用不同的 `Array` 方法。

以上都是JS数组的独特特性，但它们不是一个数组的最基本的特性。


把任何具有一个 `length属性` 及相应的 `非负整数属性` 的 `对象` 作为一种数组, 称之为 `"类数组"`。


这种 `类数组` 的对象出现频率不高，而且也不能在它们之上 调用数组方法 或者通过 `length` 属性期待特殊的行为1)2), 但仍然可以用遍历一个真正数组的代码来遍历它们。


事实上很多数组算法对于类似数组的对象和真正的数组对象都是适用的, 只要不尝试对数组添加元素或者改变 `length属性`, 就可以把类似数组的对象当作真正的数组来对待。

特别地，函数中的 `Arguments` 对象就是一个 `类数组` 的对象; 而 `getElementsByTagName()` 返回的DOM结点列表也是类似数组的对象。


如下创建一个类似数组，然后遍历该类似数组:

```js
var a = {};
var i = 0;
// 不小心就引进了一个小bug
while(i++ < 10) { a[i] = i * i; }
while(i < 10) { a[i] = i * i; i++; }

a.length = i;

var total = 0;
for(var j = 0, len = a.length; j < len; j++) {
  total += a[j];
}
```


### 类型识别


#### 识别方法


* `typeof` (typeof x)（只能用于除`null`以外的原始类型）

  返回值：首字母小写的字符串形式

  * 可以识别 `基本类型`，`null` 除外
  * 不能识别 `内置对象类型` (`Function` 除外)
  * 不能识别 `自定义类型`
  * 可以识别 `undefined`
  * 不能识别 `null`，因为 `null` 被识别为 `object`


* `instanceof` (`x instanceof X`)，（不能用于原始类型）

  返回值：`true` 或 `false`

  * 不能识别 `基本类型`，会返回 `false`。 `(true instanceof Boolean) -> false`
  * 可以识别 `内置对象类型`
  * 可以识别 `自定义类型` 及其 `父类型`
  * 不能识别 `undefined`、`null`，因为无 `Undefined`、`Null` 包装类型


* `Object.prototype.toString` （自定义类型需要实现 `toString` 方法方可识别）

  eq.
  ```js
  function type(obj) {
    return Object.prototype.toString.call(obj).slice(8, -1).toLowerCase();
  }
  ```

  返回值：`[object TypeX]` 的字符串形式

  * 可以识别 `基本类型`
  * 可以识别 `内置对象类型`
  * 可以识别 `自定义类型`，但是需要重载 `toString` 方法
  * 可以识别 `undefined`、`null`


* `.prototype.constructor` （不能用于 `null` 和 `undefined` ）

  eq.
  ```js
  String.prototype.constructor.name
  ```

  ```js
  function type(obj) {
    return obj.__proto__.constructor.toString().replace(/^function (\w+)\(\).+$/, '$1');
  }
  ```

  返回值：`function TypeX(){[native code]}` 或者 `function TypeX(){}`
  
  * 可以识别 `基本类型`
  * 可以识别 `内置对象类型`
  * 可以识别 `自定义类型`
  * 不能识别 `undefined`、`null`，会报错，因为 不存在方法



#### Example


* Number

```js
var num = 0;
var numObj = new Number(0);
console.log(typeof num);                    // number
console.log(typeof numObj);                 // object
console.log(num instanceof Object);         // false
console.log(num instanceof Number);         // false
console.log(numObj instanceof Object);      // true
console.log(numObj instanceof Number);      // true
console.log(num === numObj);                // false
```


* String

```js
var str = '';
var strObj = new String('');
console.log(typeof str);                    // string
console.log(typeof strObj);                 // object
console.log(str instanceof Object);         // false
console.log(str instanceof String);         // false
console.log(strObj instanceof Object);      // true
console.log(strObj instanceof String);      // true
console.log(str === strObj);                // false
```


* Boolean

```js
var bool = true;
var boolObj = new Boolean(true);
console.log(typeof bool);                   // boolean
console.log(typeof boolObj);                // object
console.log(bool instanceof Object);        // false
console.log(bool instanceof Boolean);       // false
console.log(boolObj instanceof Object);     // true
console.log(boolObj instanceof Boolean);    // true
console.log(bool === boolObj);              // false
```


* Undefined Null

```js
console.log(typeof undefined);              // undefined
console.log(undefined instanceof Object);   // false
console.log(typeof null);                   // object
console.log(null instanceof Object);        // false
console.log(undefined === null);            // false
console.log(undefined == null);             // true
var undefined = 'foo';                      // 可以重新赋值
console.log(undefined, typeof undefined);   // foo 'string'
console.log(void(0) === undefined);         // true
```


* Function

```js
var objPrototype = Object.prototype;
console.log(objPrototype);                          // {}
console.log(objPrototype.__proto__);                // null
console.log(objPrototype.toString());               // [object Object]
console.log(objPrototype.valueOf());                // object
console.log(typeof objPrototype);                   // object
console.log(Object.prototype instanceof Object);    // false !

console.log(typeof Object);                         // function
console.log(Object);                                // [Function: Object]
console.log(Object instanceof Object);              // true
console.log(Object instanceof Function);            // true !

console.log(typeof Function);                       // function
console.log(Function);                              // [Function: Function]
console.log(Function instanceof Object);            // true
console.log(Function instanceof Function);          // true ！

console.log(Object.__proto__ === Function.prototype);
console.log(Function.__proto__ === Function.prototype);

console.log(Function.prototype.__proto__ === Object.prototype);

console.log(Object.__proto__.__proto__ === Object.prototype);
console.log(Function.__proto__.__proto__ === Object.prototype);

console.log(Object.prototype.__proto__);
```


### 类型转换


#### 显式转换


JavaScript 提供了以下转型函数：

* 转为数值类型：`Number(mix)、parseInt(string,radix)、parseFloat(string)`
* 转为字符串类型：`toString(radix)、String(mix)`
* 转为布尔类型：`Boolean(mix)`



- `Number(mix)` 函数，可以将任意类型的参数mix转换为数值类型。其规则为：


Type        | Example
------------|---------------------------------------
Boolean     | Number(true)->1 Number(false)->0
Number      | Number(num)->num
Null        | Number(null)->0
Undefined   | Number(undefined)->NaN
String      | Number('012345')->12345 Number('012345.6789')->12345.6789 Number('')->0 Number('A-Z')->NaN
Object      | 调用对象的valueOf()方法，依据前面的规则转换返回的值。如果转换的结果是NaN，则调用对象的toString()方法，再依据前面的规则转换返回的值。


下表列出了对象的 `valueOf()` 的返回值：


Type        | `valueOf()`
----------- |---------------------------------------
`Array`     | 数组的元素被转换为字符串，这些字符串由逗号分隔，连接在一起，其操作与 Array.toString 和 Array.join 方法相同。
`Boolean`   | Boolean 值是
`Date`      | 存储的时间是从 1970 年 1 月 1 日午夜开始计的毫秒数 UTC
`Function`  | 函数本身
`Object`    | 对象本身
`String`    | 字符串值
`Number`    | 数字值


Example：

```js
Number(new Array().valueOf());
Number(new Array().toString());
Number(new Array());
Number(new Array([1, 2, 3]).valueOf());
Number(new Array([1, 2, 3]).toString());
Number(new Array([1, 2, 3]));
Number(new Boolean(true).valueOf());
Number(new Boolean(true).toString());
Number(new Boolean(true));
Number(new Date().valueOf());
Number(new Date().toString());
Number(new Date());
Number(new Function());
```


- `parseInt(string, radix)` 将字符串转换为整数类型。

  它也有一定的规则：

  * 忽略字符串前面的空格，直至找到第一个非空字符。
  * 如果第一个字符不是数字符号或者负号，返回 `NaN`。
  * 如果第一个字符是数字，则继续解析直至字符串解析完毕或者遇到一个非数字符号为止。
  * 如果上步解析的结果以 `0` 开头，则将其当作八进制来解析；如果以 `0x` 开头，则将其当作十六进制来解析。
  * 如果指定 `radix` 参数，则以 `radix` 为基数进行解析。


- `parseFloat(string)` 将字符串转换为浮点数类型。

  它的规则与 `parseInt` 基本相同，但也有点区别：字符串中第一个小数点符号是有效的，另外 `parseFloat` 会忽略所有前导 `0`，如果字符串包含一个可解析为整数的数，则返回整数值而不是浮点数值。


- `toString(radix)` 方法。

  除 `undefined` 和 `null` 之外的所有类型的值都具有 `toString()` 方法，转换成字符串表示。


  ```js
  console.log([1, 2, 3].toString())       // 1, 2, 3
  console.log(true.toString())            // true
  console.log(new Date().toString(10))    // Wed Aug 17 2016 13:52:21 GMT+0800 (中国标准时间)
  console.log({}.toString())              // [object Object]
  ```


- `String(mix)` 将任何类型的值转换为字符串：

  * `null` -> "null"
  * `undefined` -> "undefined"
  * 调用 `toString()` 方法，返回结果，如果没有 `toString()`，则报异常，无法转换。


- `Boolean(mix)` 函数，将任何类型的值转换为布尔值。

  * `false`：`false、''、0、NaN、null、undefined`
  * `true` : 除了以上转换问 `false` 的


#### 隐式转换

在某些情况下，即使我们不提供显示转换，JavaScript 也会进行自动类型转换，主要情况有：


- 用于检测是否为非数值的函数：`isNaN(mix)`

  `isNaN()` 函数，经测试发现，该函数会尝试将参数值用 `Number()` 进行转换，如果结果为 `“非数值”` 则返回 `true`，否则返回 `false`。


- 递增递减操作符（包括前置和后置）、一元正负符号操作符，其规则与 `Number()` 规则基本相同

  * 如果是包含有效数字字符的字符串，先将其转换为数字值（转换规则同 `Number()`），在执行加减1的操作，字符串变量变为数值变量。
  * 如果是不包含有效数字字符的字符串，将变量的值设置为 `NaN`，字符串变量变成数值变量。
  * 如果是布尔值 `false`，先将其转换为 `0` 再执行加减 `1` 的操作，布尔值变量编程数值变量。
  * 如果是布尔值 `true`，先将其转换为 `1` 再执行加减 `1` 的操作，布尔值变量变成数值变量。
  * 如果是浮点数值，执行加减 `1` 的操作。
  * 如果是对象，先调用对象的 `valueOf()` 方法，然后对该返回值应用前面的规则。如果结果是 `NaN`，则调用 `toString()` 方法后再应用前面的规则。对象变量变成数值变量。
  

- 加减乘除运算符、取模运算符

  * 如果一个操作数为 `NaN`，则结果为 `NaN`
  * `Infinity+Infinity -> Infinity`
  * `-Infinity+(-Infinity) -> -Infinity`
  * `Infinity+(-Infinity) -> NaN`
  * `+0+(+0) -> +0`
  * `(-0)+(-0) -> -0`
  * `(+0)+(-0) -> +0`

  加号运算操作符在 JavaScript 也用于字符串连接符，所以加号操作符处理字符串是有所不同：

  * 如果两个操作值都是字符串，则将它们拼接起来
  * 如果只有一个操作值为字符串，则将另外操作值转换为字符串，然后拼接起来
  * 如果一个操作数是对象、数值或者布尔值，则调用 `toString()` 方法取得字符串值，然后再应用前面的字符串规则。对于 `undefined` 和 `null`，分别调用 `String()` 显式转换为字符串。
  * 可以看出，加法运算中，如果有一个操作值为字符串类型，则将另一个操作值转换为字符串，最后连接起来。


- 逻辑操作符（!、&&、||）

  * 逻辑非 `!` 操作符首先通过 `Boolean()` 函数将它的操作值转换为布尔值，然后求反。
  * 逻辑与 `&&` 操作符，如果一个操作值不是布尔值时，遵循以下规则进行转换：
    - 如果第一个操作数经 `Boolean()` 转换后为 `true`，则返回第二个操作值，否则返回第一个值（不是Boolean()转换后的值）
    - 如果有一个操作值为 `null`，返回 `null`
    - 如果有一个操作值为 `NaN`，返回 `NaN`
    - 如果有一个操作值为 `undefined`，返回 `undefined`
  * 逻辑或（||）操作符，如果一个操作值不是布尔值，遵循以下规则：
    - 如果第一个操作值经 `Boolean()` 转换后为 `false`，则返回第二个操作值，否则返回第一个操作值（不是 `Boolean()` 转换后的值）
    - 对于 `undefined`、`null` 和 `NaN` 的处理规则与逻辑与（&&）相同


- 关系操作符（<, >, <=, >=）

  * 如果两个操作值都是数值，则进行数值比较
  * 如果两个操作值都是字符串，则比较字符串对应的字符编码值
  * 如果只有一个操作值是数值，则将另一个操作值转换为数值，进行数值比较
  * 如果一个操作数是对象，则调用 `valueOf()` 方法（如果对象没有 `valueOf()` 方法则调用 `toString()` 方法），得到的结果按照前面的规则执行比较
  * 如果一个操作值是布尔值，则将其转换为数值，再进行比较
  * 注：`NaN` 是非常特殊的值，它不和任何类型的值相等，包括它自己，同时它与任何类型的值比较大小时都返回 `false`。


- 相等操作符（==）
  
  * 如果一个操作值为布尔值，则在比较之前先将其转换为数值
  * 如果一个操作值为字符串，另一个操作值为数值，则通过 `Number()` 函数将字符串转换为数值
  * 如果一个操作值是对象，另一个不是，则调用对象的 `valueOf()` 方法，得到的结果按照前面的规则进行比较
  * `null` 与 `undefined` 是相等的
  * 如果一个操作值为 `NaN`，则相等比较返回 `false`
  * 如果两个操作值都是对象，则比较它们是不是指向同一个对象



## void


* `void UnaryExpression` 按如下流程解释:

  * 令 `expr` 为解释执行 `UnaryExpression` 的结果
  * 调用 `GetValue(expr)`
  * 返回 `undefined`

* 注意：`GetValue` 一定会被调用，即使它的值不会被用到，但是这个表达式可能会有副作用(side-effects)。

* 为什么要用 `void`？`undefined` 不是保留字，可以重新赋值。采用 `void` 方式获取 `undefined` 便成了通用准则。


[谈谈JavaScript中的void操作符](https://segmentfault.com/a/1190000000474941)



## Operator

运算符优先级


## Object


ECMAScript 做为一个高度抽象的面向对象语言，是通过对象来交互的。
一个对象就是属性集合，并拥有一个独立的 `原型对象`，这个 `原型对象` 可以是一个 `对象` 或者 `null`。
一个对象的 `原型对象` 是以对象内部的 `[[Prototype]]` 属性来引用的。


在示意图里边我们将会使用 `__<internal-property>__` 下划线标记来替代两个括号，对于 `prototype` 对象来说是：`__proto__`。


让我们看一个关于对象的基本例子。


对于以下代码：

```js
var foo = {
  x: 10,
  y: 20
};
```

我们拥有一个这样的结构，两个显式的属性和一个隐藏的 `__proto__` 属性，这个属性是对 `Object.prototype` 的引用。

![basic-object](images/basic-object.png)


这些 `prototype` 有什么用？

让我们以 `原型链` 的概念来回答这个问题。



## 原型链（prototype-chain）


* `原型对象` 也是简单的对象，所以他可以拥有自己的原型，如果一个原型对象的 `原型` 是一个非 `null` 的引用，延续下去，原型对象连成的链，就形成了 `原型链`。
* `原型链` 是一个用来实现 `继承` 和 `共享` 属性的有限长度的 `对象链`。
* `原型链` 是为了实现代码重用而设计的，在基于类的系统中，这个代码重用风格叫作 `继承`。


ECMAScript 中没有类的概念，但是代码重用的风格并没有太多不同，ECMAScript 通过原型链来实现，即 **原型继承(prototype based inheritance)**，这种继承方式叫作 **委托继承(delegation based inheritance)**。


ES5标准化了一个实现原型继承的新的可选方法，使用 `Object.create` 函数：

```js
var a = {k: 'v'};
var b = Object.create(a, {y: {value: 20}});
var c = Object.create(a, {y: {value: 30}});
```


ES6标准化了 `__proto__` 属性，并且可以在对象初始化的时候使用它，如下面的用法。
`b` 和 `c` 可以访问到 `a` 对象中定义的 `calculate()` 方法，是通过原型链 `lookup` 实现的。

```js
var a = {
  x: 10,
  calculate: function (z) {
    return this.x + this.y + z
  }
};
var b = {y: 20, __proto__: a};
// 等价于 var b = Object.create(a, {y: {value: 20}});
var c = {y: 30, __proto__: a};
// 等价于 var c = Object.create(a, {y: {value: 30}});
b.calculate(30); // 60
c.calculate(40); // 80
```


### 原型链 `lookup` 规则：

如果一个 `属性`/`方法` 在对象自身中无法找到，JS引擎会尝试遍历整个原型链，寻找这个 `属性`/`方法`，第一个被查找到的同名 `属性`/`方法` 会被使用。如果在遍历了整个原型链之后还是没有查找到这个属性的话，返回 `undefined` 值。

下一张图展示了对象 `a`，`b`，`c` 之间的继承关系：

![prototype-chain](images/prototype-chain.png)


所以 `__proto__` 主要是给JS引擎用的，但是暴露给了我们，并且可以对其修改。


与此类似的还有 `作用域链` 及其 `lookup规则`，`原型链` 和 `作用域链` 的用途都是用来名字查找，给JS引擎用的。

区别是：原型链是属性上的名字查找，对象自身上查找，这条链可以运行时被修改，作用域链是上下文中的名字查找，这条链由代码决定。


### `__proto__`

* 如果没有明确为一个对象指定原型，那么它将会使用 `__proto__` 的默认值 `Object.prototype`。
* `Object.prototype` 对象自身也有一个 `__proto__` 属性，值为 `null`，这是原型链的终点。 即：`Object.prototype.__proto__ === null`
* The `__proto__` property of `Object.prototype` is an `accessor property` (a getter function and a setter function) that exposes the internal `[[Prototype]]` (either an object or null) of the object through which it is accessed.


项目中建议不要直接使用 `__proto__` 读写原型，而是使用 `Object.getPrototypeOf()、Object.create()` 读写原型。


```js
var Shape = function () { };
var proto = {
  say: function () { console.log('hello world!'); }
};
Shape.prototype = proto;

Object.prototype.getPrototype = function () { 
  return Object.getPrototypeOf(this)
};
```


```js
var circle = new Shape();
console.log('circle:', circle.__proto__ === Shape.prototype);
console.log('circle:', Object.getPrototypeOf(circle) === Shape.prototype);
console.log('circle:', typeof circle);
console.log('circle:', circle instanceof Shape);
console.log('circle:', circle instanceof Object);
```

```js
var rectangle = Object.create(proto);
console.log('ractangle:', rectangle.__proto__ === Shape.prototype);
console.log('ractangle:', Object.getPrototypeOf(rectangle) === Shape.prototype);
console.log('ractangle:', typeof rectangle);
console.log('ractangle:', rectangle instanceof Shape);
console.log('ractangle:', rectangle instanceof Object);
```

```js
var objPrototype = Object.prototype;
console.log(objPrototype);
console.log(typeof objPrototype);
console.log(objPrototype.__proto__);
console.log(Object.prototype instanceof Object);
console.log('__proto__:', 'xxx'.__proto__);
console.log(String.prototype);
console.log(Object instanceof Object);
console.log([] instanceof Object);
console.log({} instanceof Object);
```


`typeof` 和 `instanceof` 都是检测变量的类型，区别在于:

* `typeof`: 可以用来区分原始值和对象。`typeof` 还可以让检查一个变量是否已声明，而不会抛出异常，没有任何一个函数可以实现此功能。
* `instanceof`: 可以用来区分对象，`instanceof` 对于所有的原始值都返回 false。


typeof 在操作 `null` 时会返回 `"object"`，这是 JavaScript 语言本身的 bug。
不幸的是，这个 bug 永远不可能被修复了，因为太多已有的代码已经依赖了这样的表现。
这并不意味着，`null` 实际上是一个对象。


### 属性类型


#### 数据属性


属性|说明
---|---
`[[Configurable]]` | 表示能否通过 `delete` 删除属性从而重新定义属性，能否改变属性的特性，或者能否改变把属性改为访问器属性。`true`|
`[[Enumerable]]`   | 表示能否通过 `for-in` 循环返回属性。`true`|
`[[Writable]]`     | 表示能否修改属性值。`ture`|
`[[Value]]`        | 包含实际值。`undefined`|

严格模式下不合法的操作会抛出异常，非严格模式会忽略相关操作。


```js
var person = {};
Object.defineProperty(person, 'name', {
  configurable: false,
  enumerable: true,
  writable: false,
  value: 'liuyanjie'
});
Object.defineProperty(person, 'sax', {
  configurable: false,
  enumerable: false,
  writable: false,
  value: 'M'
});
console.log(person);            // { name: 'liuyanjie' }
console.log(person.sax);        // M
```


#### 访问器属性: `getter` `setter`


属性|说明
---|---
`[[Configurable]]`    | 表示能否通过 `delete` 删除属性从而重新定义属性，能否改变属性的特性，或者能否改变把属性改为访问器属性。`true`
`[[Enumerable]]`      | 表示能否通过 `for-in` 循环返回属性。`true`
`[[Getter]]`          | 取值函数。`undefined`
`[[Setter]]`          | 赋值函数。`undefined`


* `getter` 和 `setter` 不一定要成对出现
* 只有 `getter` 函数证明该属性只读，尝试写入在非严格模式下会被忽略，严格模式会抛出错误
* 只有 `setter` 函数证明该属性只写，尝试读取在非严格模式下返回 `undefined`，严格模式则抛出错误
* 对象的 `数据属性`、`访问器属性` 都包含 `[[configurable]]` 和 `[[enumerable]]`，但不能同时有 `[[writeable]]`/`[[value]]` 和 `[[get]]`/`[[set]]`，数据属性也可以函数


```js
var book1 = { _year: 2014, edition: 1 };
Object.defineProperty(book1, 'year', {
  configurable: false,
  enumerable: true,
  get: function () {
    return this._year;
  },
  set: function (year) {
    if (year > 2014) {
      this._year = year;
      this.edition += year - 2014;
    }
  }
});
console.log(book1);      // { _year: 2014, edition: 1, year: [Getter/Setter] }
console.log(book1.year);  // 2014
book.year = 2016;
console.log(book1);      // { _year: 2016, edition: 3, year: [Getter/Setter] }
```


```js
// 给 对象 设置 多个 `数据属性` 和 `访问器属性`
var book2 = { _year: 2014, edition: 1 };
Object.defineProperties(book2, {
  _year: {
    value: 2014
  },
  edition: {
    value: 1
  },
  year: {
    configurable: false,
    enumerable: false,
    get: function () { },
    set: function () { }
  },
  getContents: {
    value: function () {
      return 'contents';
    }
  }
});
```


```js
// 获取 属性 信息
var desc1 = Object.getOwnPropertyDescriptor(book2, 'year');
console.log(desc1);
// {
//   get: [Function],
//   set: [Function],
//   enumerable: false,
//   configurable: false
// }
var desc2 = Object.getOwnPropertyDescriptor(book2, 'getContents');
console.log(desc2);
// {
//   value: [Function],
//   writable: false,
//   enumerable: false,
//   configurable: false
// }
```


#### 应用：

* [观察者模式]例子[JavaScript实现MVVM监测一个普通对象的变化](http://hcysun.me/2016/04/28/JavaScript%E5%AE%9E%E7%8E%B0MVVM%E4%B9%8B%E6%88%91%E5%B0%B1%E6%98%AF%E6%83%B3%E7%9B%91%E6%B5%8B%E4%B8%80%E4%B8%AA%E6%99%AE%E9%80%9A%E5%AF%B9%E8%B1%A1%E7%9A%84%E5%8F%98%E5%8C%96/)



### ECMAScript5 对象保护功能


在 JavaScript 里，默认情况下，你可修改任何你可以访问到的对象，你可以自由的删除对象的属性或覆盖对象的方法。
这在多人协作开发的项目中，会造成很大问题，因为你不知道你的修改会对别人造成什么样的影响。
如果你是一个模块或代码库的作者，你可能想锁定一些核心库的某些部分，保证任何人不能有意或无意的修改它们。
严格模式下抛出异常，普通模式下安静的失败；


* 禁止添加属性：禁止扩展。即：禁止为对象添加属性和方法，但已存在的属性和方法是可以被修改和删除的。

```js
var person1 = { name: 'liuht' };
Object.preventExtensions(person1);
console.log('isFrozen:', Object.isFrozen(person1));             // -> true
console.log('isSealed:', Object.isSealed(person1));             // -> true
console.log('isExtensible:', Object.isExtensible(person1));     // -> false
person1.sex = 1;
console.log(person1);
console.log(person1.sex);
```


* 禁止删除属性：密封。即：禁止删除对象已存在的属性和方法。

```js
var person2 = { name: 'liuht' };
Object.seal(person2);
console.log('isFrozen:', Object.isFrozen(person2));             // -> true
console.log('isSealed:', Object.isSealed(person2));             // -> true
console.log('isExtensible:', Object.isExtensible(person2));     // -> false
delete person2.name;
person2.age = 10;
console.log(person2);
```


* 禁止添加或删除属性：冻结。即：禁止修改对象已存在的属性和方法，所有字段都是只读的。

```js
var persion3 = { name: 'liuht' };
Object.freeze(persion3);
console.log('isFrozen:', Object.isFrozen(persion3));            // -> true
console.log('isSealed:', Object.isSealed(persion3));            // -> true
console.log('isExtensible:', Object.isExtensible(persion3));    // -> false
delete persion3.name;
persion3.age = 10;
persion3.name = 'new name';
console.log(persion3);
```


**访问器属性** 和 **对象保护功能** 都是针对 **对象属性** ，而不是 **变量**


通常情况下对象拥有相同或者相似的状态结构（也就是相同的属性集合），赋以不同的状态值，在这个情况下我们可能需要使用 `构造函数`，其以指定的模式来创造对象。



## 构造函数


* 以指定的模式来创造对象
* 自动地为新创建的对象设置一个原型对象，这个原型对象存储在 `ConstructorFunction.prototype` 属性中。


我们可以使用构造函数来重写上一个拥有对象 `b` 和对象 `c` 的例子。因此，对象 `a` 的角色由 `Foo.prototype` 来扮演：

```js
function Foo(y) { this.y = y; }
Foo.prototype.x = 10;
Foo.prototype.calculate = function (z) {
  return this.x + this.y + z;
};
var b = new Foo(20);
var c = new Foo(30);
b.calculate(30);
c.calculate(40);
console.log(b.__proto__ === Foo.prototype);
console.log(c.__proto__ === Foo.prototype);
console.log(b.constructor === Foo);
console.log(c.constructor === Foo);
console.log(Foo.prototype.constructor === Foo);
console.log(b.calculate === b.__proto__.calculate);
console.log(b.__proto__.calculate === Foo.prototype.calculate);
```


这个代码可以表示为如下关系：

可以看到，构造函数 `Foo` 也有自己的 `__proto__`，即 `Function.prototype`，`Function.prototype` 通过其 `__proto__` 属性关联到 `Object.prototype`。

![constructor-proto-chain](images/constructor-proto-chain.png)


想一下类的概念，构造函数和原型对象合在一起可以当作一个「类」了。

例如：Python的 `First-Class、Dynamic-Classes` 显然是以同样的 `属性/方法` 处理方案来实现的。从这个角度来说，Python 中的类可以看作 ECMAScript 使用的委托继承的一个语法糖。

在ES6中「类」的概念被标准化了，并且实际上以一种构建在构造函数上面的语法糖来实现，就像上面描述的一样。


用类的方式实现如下：

```js
// ES6
class Foo {
  constructor(name) {
    this._name = name;
  }
  getName() {
    return this._name;
  }
}
class Bar extends Foo {
  getName() {
    return super.getName() + ' Doe';
  }
}
var bar = new Bar('John');
console.log(bar.getName()); // John Doe
```


`new` 操作符 都做了什么？

1. 创建一个新对象
2. 将构造函数作用域赋给新对象，即 `this` 指向了新对象
3. 执行构造函数中的代码，初始化新对象（即 `this`）
4. 返回新对象的引用 `this`，没显示返回或返回 `this`，也可返回其他对象。

只要用 `new` 操作符来调用函数就是构造函数，否则，就是普通函数。


Example：

```js
function NewDate() {
  return new Date();
}
var date = new NewDate();
console.log(date instanceof NewDate); // ?
console.log(date instanceof Date);    // ?
```



## 对象构造


### 工厂模式

* 按指定模式创建对象的，但是对象类型无法标识，且每个方法在每个对象上都要重新创建一次。

```js
function createObject(arg1, arg2) {
  var o = new Object();
  o.property1 = arg1;
  o.property2 = arg2;
  o.func = function () {
    console.log(this.property1);
    console.log(this.property2);
  };
  return o;
}

var o1 = createObject(1, 2);
var o2 = createObject(3, 4);
console.log(o1.property1);
```


### 构造函数模式

* 构造函数名字用来标志一个 `特定类型`，同样每个方法在每个对象上都要重新创建一次。

```js
function NewObject(arg1, arg2) {
  this.property1 = arg1;
  this.property2 = arg2;
  this.func = function () {
    console.log(this.property1);
  }
}

var no1 = new NewObject(1, 2);
var no2 = new NewObject(3, 4);
// 构造函数属性 constructor 标志对象类型
console.log(no1.constructor == NewObject);
console.log(no1.constructor == Object);
console.log(no2.constructor == NewObject);
console.log(no2.constructor == Object);
// 检测对象　更可靠
console.log(no1 instanceof Object);
console.log(no1 instanceof NewObject);
console.log(no2 instanceof Object);
console.log(no2 instanceof NewObject);
```


### 原型模式

* 每个函数都有一个 `prototype` 属性，引用另一个对象，这个对象可以实现属性的共享。
* `prototype` 是构造函数的一个属性，`prototype` 指向的 `原型对象` 拥有一个`constructor` 属性指向构造函数。
* 通过构造函数创建的 `对象实例` 可以通过 `__proto__` 访问 `原型对象`，但是不能重写，重名的属性将屏蔽原型中的同名属性。
* 在原型中修改属性，会立刻在 `对象实例` 中反映出来。但是如果重写整个原型对象，那么实例对象将找不到原型中定义的属性。
* `prototype` 和 `constructor` 构成了双向链表。


```js
function PrototypeObject() { }
PrototypeObject.prototype.name = 'PrototypeObject'; // name 是多实例共享的
PrototypeObject.prototype.sayName = function () {
  console.log(this.name);
};

var po1 = new PrototypeObject();
po1.sayName();
var po2 = new PrototypeObject();
po2.sayName();
console.log(po1.sayName === po2.sayName);       // true
console.log(po1.sayName() === po2.sayName());   // true
console.log(PrototypeObject.prototype.constructor === PrototypeObject); // true

// 每个实例　拥有一个[[Prototype]]属性指向原型对象，但是JS代码无法访问此属性。
console.log(PrototypeObject.prototype.isPrototypeOf(po1));              // true  // 判断po1.[[Prototype]] ===
console.log(PrototypeObject.prototype.isPrototypeOf(po2));              // true  // 判断po2.[[Prototype]] ===
console.log(Object.getPrototypeOf(po1) === PrototypeObject.prototype);  // 返回原型对象
console.log(po1.hasOwnProperty('sayName'));                             // 判断是否是对象属性  检测属性存在于对象中还是原型对象中

function hasPrototypeProperty(object, name) {               // 判断是否是原型属性
  return !object.hasOwnProperty(name) && (name in object);
}

// Object.keys();                    // 返回所有可枚举的实例属性
// Object.getOwnPropertyNames();     // 返回所有实例属性
// 原型同样可以这样定义：原型对象 = 字面量，prototype的constructor不再等于PrototypeObject，但是instanceof()仍能继续工作。
PrototypeObject.prototype = { // 这样把整个原型改了
    constructor: Person // 默认的constructor被覆盖掉了 [[Enumerable]]会变成true
}
Object.defineProperty(PrototypeObject.prototype, 'constructor', {
  enumerable: false,
  value: Persion
});
```


### 组合构造函数和原型模式 - [默认模式]

* 实例属性在构造函数中定义 共享属性在原型中定义

```js
function ConstructPrototypeObject(name, desc) {
  this.name = name;
  this.desc = desc;
}
ConstructPrototypeObject.prototype.display = function () {
  console.log(this.name);
  console.log(this.desc);
};
```


### 动态原型模式

* 只在第一次调用构造函数时 实例化原型，好像没这个问题。

```js
function ConstructPrototypeObject(name, desc) {
  this.name = name;
  this.desc = desc;
  if (!ConstructPrototypeObject.prototypeInstantiated) {
      //只在第一次调用构造函数时 实例化原型
    ConstructPrototypeObject.prototype.prototypeInstantiated = true;
    ConstructPrototypeObject.prototype.display = function () {
      console.log(this.name);
      console.log(this.desc);
    };
    ConstructPrototypeObject.prototype.sayName = function () {
      console.log(this.name);
    };
    // ... ...
    ConstructPrototypeObject.prototypeInstantiated = true;
  }
}
```


### 扩展模式 （寄生模式）

* 这种方式，可以用来扩展原生对象，在不修改原生对象的前提下，扩展方法，并不影响类型识别。

```js
function SpecialArray() {
  var values = new Array();
  values.push.apply(values, arguments);
  values.toPipedString = function () {
    return this.join('|');
  };
  return values;
}
var colors = new SpecialArray('red', 'blue', 'green');
console.log(colors.toPipedString());
console.log(colors instanceof SpecialArray);  // false
console.log(colors instanceof Array);         // true
```


### 稳妥构造函数模式

* 数据成员位于 `作用域链` 中，不存在 `原型链` 或 `对象的属性`，可实现 `私有属性`，防止数据被其他程序改动时使用，适合用于一些安全环境，这些环境禁止使用 `this` 和 `new`。

```js
function Person(name, age, job) {
  var o = new Object();
  var name = name;
  o.sayName = function () {
    console.log(name);
  };
  return o;
}
var friend = Person('liuyanjie', 22, 'Software Engineer');
friend.sayName();
console.log(friend.name); //undefined
```


```js
function Person(name, age, job) {
  var name = name;
  this.sayName = function () {
    console.log(name);
  };
}

var friend = new Person('liuyanjie', 22, 'Software Engineer');
friend.sayName();
console.log(friend.name); //undefined
```


```js
var Person = (function () {
  // 这里可以定义闭包变量
  return function Person(name, age, job) {
    var name = name;
    this.sayName = function () {
      console.log(name);
    };
  }
})();

var friend = new Person('liuyanjie', 22, 'Software Engineer');
friend.sayName();
console.log(friend.name); //undefined
```



## 继承


### 原型链

* 原型属性会被所有实例共享
* 无法向超类传递参数

```js
function SuperType() {
  this.supProperty = true;
}
SuperType.prototype.getSuperValue = function () {
  return this.supProperty;
};
function SubType() {
  this.subProperty = false;
}
SubType.prototype = new SuperType();
SubType.prototype.getSubValue = function () {
  return this.subProperty;
};
var instance = new SubType();
console.log(instance.getSuperValue());
// 借用构造函数    在子类型的内部调用父类型的构造函数
function SupType() {
  this.colors = ['red', 'blue', 'green'];
}
function SubType() {
  // this 指 SubType 普通函数调用 把函数当作一个模板 同时可以传递参数
  SupType.call(this);
}
var instance = new SubType();
instance.colors.push('black');
console.log(instance);
```


### 组合继承

* 原型链继承原型
* 借用构造函数继承实例属性

```js
function SuperType(name) {
  this.name = name;
  this.colors = ['red', 'blue', 'green'];
}
SuperType.prototype.sayName = function () {
  console.log(this.name);
};
function SubType(name, age) {
  SuperType.call(this, name);           // 普通函数
  this.age = age;
}
SubType.prototype = new SuperType();    // 构造函数
SubType.prototype.constructor = SubType;
SubType.prototype.sayAge = function () {
  console.log(this.age);
};
var instance = new SubType('liuyanjie', 22);
instance.colors.push('black');
instance.sayName();
instance.sayAge();
```


### 原型式继承

* 此方式必须有一个对象作为基础，作为原型。

```js
function object(o) {
  function F() { } // 临时性构造函数
  F.prototype = o;
  return new F();
}
Object.create();    //此方法即为原型式继承
```


### 寄生式继承

```js
function createAnother(original) {          // 工厂
  var clone = Object.create(original);      // 封装了原型式继承
  clone.sayHi = function () {
    console.log('Hi');
  };
  return clone;
}
```


### 寄生组合式继承

* 借用构造函数继承属性
* 原型链的混成形式继承方法

```js
function inheritPrototype(subType, supType) {
  var prototype = Object.create(supType.prototype);
  prototype.constructor = subType;
  subType.prototype = prototype;
}
```


Node.js原生实现的继承函数：

```js
exports.inherits = function(ctor, superCtor) {
  if (ctor === undefined || ctor === null)
    throw new TypeError('The constructor to `inherits` must not be ' +
                        'null or undefined.');
  if (superCtor === undefined || superCtor === null)
    throw new TypeError('The super constructor to `inherits` must not ' +
                        'be null or undefined.');
  if (superCtor.prototype === undefined)
    throw new TypeError('The super constructor to `inherits` must ' +
                        'have a prototype.');
  ctor.super_ = superCtor;
  ctor.prototype = Object.create(superCtor.prototype, {
    constructor: {value: ctor, enumerable: false, writable: true, configurable: true}
  });
};
```



## 对象构造和原型链总结

上面不论是有多少对象构造模式和原型继承模式，只要理解其本质，就容易根据自己的需要实现想要的效果，上面的各种方式都是别人用惯的套路。

构造函数为了构造对象，实现不同功能，第一要先有一个对象（不论怎么来的），然后控制 `原型链` 和 `作用域链`。

下图是一个JavaScript Prototype Chain关系图：[查看原图](images/javascript-prototype.png)


![JavaScript Prototype Chain](images/javascript-prototype.png)

上面的内容都是静态的内容，主要是想把 原型链 讲清楚。



## 函数


### 函数声明和函数表达式

函数声明： `function 函数名称 (参数){ 函数体 }`。

函数表达式： `[var f = ] function [函数名称](参数){ 函数体 }`，如果有函数名，就是命名函数表达式。

所以，可以看出，如果不声明函数名称，它肯定是表达式，可如果声明了函数名称的话，如何判断是函数声明还是函数表达式呢？


ECMAScript 是通过上下文来区分的，如果 `function foo(){}` 是作为赋值表达式的一部分的话，那它就是一个函数表达式，如果 `function foo(){}` 被包含在一个函数体内，或者位于程序的最顶部的话，那它就是一个函数声明。

```js
function foo(){}              // 声明，因为它是程序的一部分

var bar = function foo(){};   // 表达式，因为它是赋值表达式的一部分
new function bar(){};         // 表达式，因为它是new表达式

(function(){
  function bar(){}            // 声明，因为它是函数体的一部分
})();
```


还有一种函数表达式不太常见，就是被括号括住的 `(function foo(){})`，他是表达式的原因是因为括号， `()` 是一个分组操作符，它的内部只能包含表达式，我们来看几个例子：

```js
function foo(){}      // 函数声明
(function foo(){});   // 函数表达式：包含在分组操作符内

try {
  (var x = 5);        // 分组操作符，只能包含表达式而不能包含语句：这里的var就是语句
} catch(err) {
  // SyntaxError
}
```


在使用 `eval` 对JSON进行执行的时候，JSON字符串通常被包含在一个圆括号里： `eval('(' + json + ')')`，这样做的原因就是因为分组操作符，也就是这对括号，会让解析器强制将JSON的花括号解析成表达式而不是代码块。

```js
  try {
    { "x": 5 }; // "{" 和 "}" 做解析成代码块
  } catch(err) {
    // SyntaxError
  }

  ({ "x": 5 }); // 分组操作符强制将"{" 和 "}"作为对象字面量来解析
```


匿名函数的好几种写法，一般情况下写匿名函数：

```js
(function(){})();
```

但下面几种写法也是可以的：

```js
!function(){}();
+function(){}();
-function(){}();
~function(){}();
~(function(){})();
void function(){}();
(function(){}());
```


现在，在我们知道了对象的基础之后，让我们看看运行时程序的执行 `runtime program execution` 在ECMAScript中是如何实现的。
