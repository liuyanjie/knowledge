# PHP语法

## 基本语法

## 类型

PHP支持10种原始类型

* 标量类型

  * boolean
    * True
    * False
  * interger 整形大小由平台决定，不支持无符号整形。相关限制通过常量 `PHP_INT_SIZE` `PHP_INT_MAX` `PHP_INT_MIN` 获取。如果整形溢出，将被解释为浮点数。
    * ℤ = {..., -2, -1, 0, 1, 2, ...}.
    * base 10:
    * base 16: 0x
    * base  8  0
    * base  2: 0b
  * float
  * string

* 复合类型
  
  * array
  * object
  * callable
  * interable

* 特殊类型
  
  * resource
  * NULL

伪类型

* mixed
* number
* callback
* array|object
* void

伪变量

* `$...`

PHP是动态类型语言，变量的类型通常不是程序员设置的，相反，它是在运行时由PHP根据该变量的上下文推导出来的。

* `var_dump()` 检查变量或表达式的值
* `gettype()` 获取用于调试的人类可读类型描述
* `settype()` 转换类型
* `is_<type>()` 检查类型是否是某一类型
  * `is_bool()`
  * `is_int()`
  * `is_string()`
  * `...`

* [Type Juggling](https://www.php.net/manual/en/language.types.type-juggling.php)
* [PHP type comparison tables](https://www.php.net/manual/en/types.comparisons.php)

### 类型转换

包含 `显示类型转换` 和 `隐式类型转换`

1. boolean

`(bool)$var` or `(boolean)$var`

以下值会转换为 `False`

   * False -> False
   * 0 -> False, -0 -> False
   * 0.0 -> False, -0.0 -> False
   * "" -> False, "0" -> False
   * [] -> False
   * NULL -> False
   * 通过空标签创建的SimpleXML对象

2. integer

* `(int)$var` or `(integer)$var`
* `intval()`

## 变量

默认情况下，变量是按值传递的，这意味着整个值得复制

### 预定义变量

### 变量作用域

PHP变量的作用域就是它所在的上下文，大多数情况下，PHP变量只有单一的作用域。

在函数中定义的变量存在于函数作用域中。

`global` or `$GLOBALS['var']`

Superglobals：

* $GLOBALS
* $_SERVER
* $_GET
* $_POST
* $_FILES
* $_COOKIE
* $_SESSION
* $_REQUEST
* $_ENV

### 动态变量名

```php
$a = 'hello';
$$a = 'world';

// $$a === ${$a} === $hello
```

### 外部变量

## 常量

`define("name", "value")`

### 预定义常量

```php
__LINE__
__FILE__
__DIR__
__FUNCTION__
__CLASS__
__TRAIT__
__METHOD__
__NAMESPACE__
ClassName::class
```

## 表达式

## 函数

PHP是函数式编程语言

PHP部分函数存在函数声明提升

PHP中所有的函数和类具有全局作用域：它们可以在函数外部调用，即使它们是在内部定义的，反之亦然，但是只有他们的包含函数调用之后，这些函数或类的声明才开始生效。

PHP不支持函数重载，也不止取消或重新定义以前声明过的函数

### 函数参数

PHP支持可变长度参数和默认参数，参数传递支持值传递（默认）和引用传递。

* `func_num_args ( void ) : int`
* `func_get_arg ( int $arg_num ) : mixed`
* `func_get_args ( void ) : array`

函数参数支持类型注解

### 函数返回值

### 函数变量

得益于 `$` 符号

### 函数检查

* `function_exists ( string $function_name ) : bool`

## 类

PHP包含完整的对象模型

```php
class SimpleClass {
  // properties
  public $var = 'A default value';

  // methods
  public function displayVar() {
    echo $this->var;
  }
}
```

```php
$instance = new SimpleClass();

// This can also be done with a variable:
$className = 'SimpleClass';
$instance = new $className(); // new SimpleClass()
```

### 成员变量：属性 和 方法

可见性：

* public
* protected
* private

重载：

* `public __set ( string $name , mixed $value ) : void`
* `public __get ( string $name ) : mixed`
* `public __isset ( string $name ) : bool`
* `public __unset ( string $name ) : void`

Magic Methods：

| Magic Methods      | Call              |
|--------------------|-------------------|
| __construct()      | new               |
| __destruct()       |                   |
| __call()           |                   |
| __callStatic()     |                   |
| __get(), __set()   |                   |
| __isset()          | isset()           |
| __unset()          | unset()           |
| __sleep()          | serialize()       |
| __wakeup()         | unserialize()     |
| __toString()       |                   |
| __invoke()         |                   |
| __set_state()      | var_export()      |
| __clone()          | clone             |
| __debugInfo()      | var_dump()        |

### new

### 后期静态绑定

self::, parent::, static::


## 命名空间

__NAMESPACE__

`namespace` `use ... as ...`
