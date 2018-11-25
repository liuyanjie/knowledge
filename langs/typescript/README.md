# Typescript

## Types

### 基本类型

在TS中，有 `boolean` `Boolean` `number` `Number` `string` `String` `object` `Object` `void` `any` 等基础类型

在 TS 中，原始类型与其包装类型是不同的，具体表现为包装类型不能向包装类型赋值。

不同于 JS，TS 是静态语言，一旦声明变量的类型，将不可改变。

1. `boolean` `Boolean`

```ts
let bool: boolean = true

let bool: Boolean = true
let bool: Boolean = new Boolean(true)

// Type 'Boolean' is not assignable to type 'boolean'.
//   'boolean' is a primitive, but 'Boolean' is a wrapper object. Prefer using 'boolean' when possible.
let bool: boolean = new Boolean(true)
```

1. `number` `Number`

```ts
let i: number = 1

let i: Number = new Number(1)

// 报错
let i: number = new Number(1)
```

1. `string` `String`

```ts
let str: string = ''

let str: String = ''
let str: String = new String('')

// 报错
let str: string = new String('')
```

1. `object` `Object`

```ts
let x: object = {}
let x: object = new Object()

let oo: Object = {}
let oo: Object = new Object()
```

1. `void` `undefined` `null`

```ts
let _undefined: void = undefined;
let _undefined: undefined = undefined;

let _null: void = null;
let _null: null = null;

// 报错
let _null: Null = null
```

在 TS 中，`undefined` 和 `null` 被统一成 `void` 空类型，`undefined` 和 `null` 类型可以相互赋值。不存在 `Null` 类型。

1. `any`

```ts
let any_type: any // 等价于 `let any_type`
let any_type: any = true
let any_type: any = 0
let any_type: any = ''
let any_type: any = {}
```

1. `object` `Object`

`object` 类型变量只能赋予对象类型的值

```ts
let o: object = {k: 'v'}

// 以下报错
let o: object = true
let o: object = 1
let o: object = ''

// 以下成功
let o: object = new Boolean(0)
let o: object = new String()
let o: object = new Number(0)
let o: object = new Array()
```

`Object` 类型可以赋予任意类型的值

```ts
let o: Object
let o: Object = undefined
let o: Object = null
let o: Object = true
let o: Object = 0
let o: Object = ''
let o: Object = {}
let o: Object = []
```

1. `Array` `[]`

数组类型的表示方法：`T[]` `Array<T>`。

```ts
let list: Array<Number> = [new Number(1), 2, 3]
let list: Number[] = [new Number(1), 2, 3]
```

接口表示法：

```ts
interface NumberArray {
  [index: number]: number;
}
let fibonacci: NumberArray = [1, 1, 2, 3, 5];
```

类数组：

```ts
function sum() {
  let args: IArguments = arguments;
}
```

### 类型推导（Type Inference）

如果没有明确的指定类型，那么 TS 会依照类型推导规则推断出一个类型。

```ts
let thisIsString = ''

// 报错
myFavoriteNumber = 7
```

以上代码会被推导为：

```ts
let thisIsString: string = ''

// 报错
myFavoriteNumber = 7
```

推导为任意类型：

```ts
// ==> let thisIsAnyType: any
let thisIsAnyType

thisIsAnyType = true
thisIsAnyType = 0
thisIsAnyType = ''
```

### 联合类型（Union Types）

联合类型类似于联合体，可以将联合类型中任一类型的值赋值给联合类型。

形如：

```ts
boolean | string | number
```

```ts
let unionType: boolean | number = true
let unionType: boolean | number = 1
```

类型决定了对象能访问哪些属性和方法，当 TS 不确定一个联合类型的变量到底是具体哪个类型的时候，只能访问此联合类型中类型属性和方法的交集：

```ts
let unionType: Object | any[] = [1, 2, 3]

// 报错
// Property 'length' does not exist on type 'Object | any[]'.
//   Property 'length' does not exist on type 'Object'.
console.log(unionType.length)
```

### 类型断言（Type Assertion）

语法：`<T>v` `v as T`

### 类型别名

```ts
type Name = string;
type NameResolver = () => string;
type NameOrResolver = Name | NameResolver;

function getName(n: NameOrResolver): Name {
    if (typeof n === 'string') {
        return n;
    } else {
        return n();
    }
}
```

### 字符串字面量类型

约束值，而不是类型

```ts
type EventNames = 'click' | 'scroll' | 'mousemove';
function handleEvent(ele: Element, event: EventNames) {
    // do something
}

handleEvent(document.getElementById('hello'), 'scroll');  // 没问题
handleEvent(document.getElementById('world'), 'click-0'); // 报错，event 不能为 'click-0'

// index.ts(7,47): error TS2345: Argument of type '"click-0"' is not assignable to parameter of type 'EventNames'.
```

### 元组（Tuple）

元组将不同类型的对象组合到了一起

```ts
type TupleSN = [string, number, object]

let x: TupleSN = ['abc', 123, {k: 'v'}];

console.log(x)
```

元组在定义时包含了长度，所以不允许越界

### 枚举（Enum）

```ts
enum Days {Sun, Mon, Tue, Wed, Thu, Fri, Sat}

enum Days {Sun = 7, Mon = 1, Tue, Wed, Thu, Fri, Sat}
```

常量枚举

```ts
const enum Directions {Up, Down, Left, Right}
const directions = [Directions.Up, Directions.Down, Directions.Left, Directions.Right];
// ==> const directions = [0 /* Up */, 1 /* Down */, 2 /* Left */, 3 /* Right */];
```

常数枚举与普通枚举的区别是，它会在编译阶段被删除，并且不能包含计算成员

外部枚举

```ts
declare const enum Directions {Up, Down, Left, Right}

const directions = [Directions.Up, Directions.Down, Directions.Left, Directions.Right];
```

## 类（Class）

TS 中的类除了实现 ES2015、ES2016、ES2017 ... 之外，还进行了一定的补充。

1. public private 和 protected

    TypeScript 可以使用三种访问修饰符（Access Modifiers），分别是 public、private 和 protected。

    * public 修饰的属性或方法是公有的，可以在任何地方被访问到，默认所有的属性和方法都是 public 的
    * private 修饰的属性或方法是私有的，不能在声明它的类的外部访问
    * protected 修饰的属性或方法是受保护的，它和 private 类似，区别是它在子类中也是允许被访问的

2. 抽象类

抽象类是不允许实例化的

```ts
abstract class Animal {
    public name;
    public constructor(name) {
        this.name = name;
    }
    public abstract sayHi();
}

// 报错
let a = new Animal('Jack')
```

## 函数（Function）

在 TS 中，加强了对函数参数和返回值的约束，要求实参与形参在类型和数量上保持一致。

```ts
function getLength(something: string | number): number {
  if ((<string>something).length) {
    return (<string>something).length;
  } else {
    return something.toString().length;
  }
}
```

## 接口（Interface）

```ts
enum Sex{F, M}

interface Person {name: string; age: number; readonly sex?: Sex}

let p1: {name: string; age: number} = {name: 'Tom', age: 25};

let p2: Person = {name: 'Tom', age: 25};

interface Student {name: string; age: number; sex?: Sex; grade: number}

// Object literal may only specify known properties, and 'grade' does not exist in type 'Person'.
let p3: Person = {name: 'Tom', age: 25, grade: 1};

let p4: Student = {name: 'Tom', age: 25, grade: 1};
```

## 泛型（Generics）

泛型（Generics）是指在定义函数、接口或类的时候，不预先指定具体的类型，而在使用的时候再指定类型的一种特性。

```ts
function createArray(length: number, value: any): Array<any> {
    let result = [];
    for (let i = 0; i < length; i++) {
        result[i] = value;
    }
    return result;
}

createArray(3, 'x'); // ['x', 'x', 'x']
```

以上代码是正确的，但是有个显而易见的缺陷，他并没有明确的定义返回值的类型：

`Array<any>` 允许数组的每一项都为任意类型。但是我们预期的是，数组中每一项都应该是输入的 `value` 的类型。

这时候采用泛型函数的写法：

```ts
function createArray<T>(length: number, value: T): Array<T> {
    let result: T[] = [];
    for (let i = 0; i < length; i++) {
        result[i] = value;
    }
    return result;
}

createArray<string>(3, 'x'); // ['x', 'x', 'x']

// 也可以不指定类型，隐式的类型推导
createArray(3, 'x'); // ['x', 'x', 'x']
```

```ts
function swap<T, U>(tuple: [T, U]): [U, T] {
    return [tuple[1], tuple[0]];
}

swap([7, 'seven']); // ['seven', 7]
```

### 泛型约束

在函数内部使用泛型变量的时候，由于事先不知道它是哪种类型，所以不能随意的操作它的属性或方法：

```ts
function loggingIdentity<T>(arg: T): T {
    console.log(arg.length);
    return arg;
}

// index.ts(2,19): error TS2339: Property 'length' does not exist on type 'T'.
```

```ts
interface Lengthwise {
    length: number;
}

function loggingIdentity<T extends Lengthwise>(arg: T): T {
    console.log(arg.length);
    return arg;
}
```

```ts
function copyFields<T extends U, U>(target: T, source: U): T {
    for (let id in source) {
        target[id] = (<T>source)[id];
    }
    return target;
}

let x = { a: 1, b: 2, c: 3, d: 4 };

copyFields(x, { b: 10, d: 20 });
```

上例中，我们使用了两个类型参数，其中要求 T 继承 U，这样就保证了 U 上不会出现 T 中不存在的字段。

### 泛型接口

```ts
interface CreateArrayFunc<T> {
    (length: number, value: T): Array<T>;
}

let createArray: CreateArrayFunc<any>;
createArray = function<T>(length: number, value: T): Array<T> {
    let result: T[] = [];
    for (let i = 0; i < length; i++) {
        result[i] = value;
    }
    return result;
}

createArray(3, 'x'); // ['x', 'x', 'x']
```

### 泛型类

```ts
class GenericNumber<T> {
    zeroValue: T;
    add: (x: T, y: T) => T;
}

let myGenericNumber = new GenericNumber<number>();
myGenericNumber.zeroValue = 0;
myGenericNumber.add = function(x, y) { return x + y; };
```

### 泛型参数的默认类型

```ts
function createArray<T = string>(length: number, value: T): Array<T> {
    let result: T[] = [];
    for (let i = 0; i < length; i++) {
        result[i] = value;
    }
    return result;
}
```

## 声明合并

如果定义了两个相同名字的函数、接口或类，那么它们会合并成一个类型：

### 函数合并

```ts
function reverse(x: number): number;
function reverse(x: string): string;
function reverse(x: number | string): number | string {
    if (typeof x === 'number') {
        return Number(x.toString().split('').reverse().join(''));
    } else if (typeof x === 'string') {
        return x.split('').reverse().join('');
    }
}
```

重载的函数可以合并

### 接口的合并

```ts
interface Alarm {
    price: number;
    alert(s: string): string;
}
interface Alarm {
    weight: number;
    alert(s: string, n: number): string;
}
```

相当于

```ts
interface Alarm {
    price: number;
    weight: number;
    alert(s: string): string;
    alert(s: string, n: number): string;
}
```

相同属性必须是相同的类型才能够合并

接口中方法的合并和函数的合并相同

### 类的合并

类的合并与接口的合并规则一致。
