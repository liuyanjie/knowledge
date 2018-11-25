# The Python Language Reference

[python-questions-on-stackoverflow](http://pyzh.readthedocs.io/en/latest/python-questions-on-stackoverflow.html)

## 3 Data model

## 3.1 Objects, values and types

Objects 是 Python 中对数据的抽象，所有数据在 Python 中都使用 objects 或者 objects 之间的关系来表示。（从某种意义上说，在符合冯诺依曼的 “存储程序计算机”，代码也是由objects 表示的。）

每一个 object 都拥有 身份 `identity`、类型 `type`、值 `value`。

对象身份 `identity` 在创建之后将不再会被改变，可以把他看作的是对象的内存地址，`is` 操作比较两个对象身份，`id()` 函数返回 对象身份 的整数表示。

> CPython implementation detail: For CPython, id(x) is the memory address where x is stored.

对象类型 `type` 决定他能进行什么样的操作，也能定义这个对象可能包含的值，`type()` 函数返回对象类型。如同 `identity`，对象的类型也是不可修改的。

对象值 `value` 是可以被修改的。对象值在创建后可以改变的对象被称为可变的 `mutable`，对象值在创建后不可更改的对象称为不可变的 `immutable`。（包含可变对象引用的不可变容器对象的值在其包含的对象值被更改时更改，但是容器对象仍然被认为是不可变的，因为它包含的对象集合无法更改。因此，不变性与具有不可改变的值并不完全相同，它更加微妙。）对象的可变性由其类型决定，字符串 `strings`、数字 `numbers` 和 元组 `tuples` 是不可修改的，然而 字典 `dictionaries` 是可以修改的。

Objects 从来不需要显式的销毁，当他们变得 `unreachable` 时会被 `garbage-collected`。允许实现推迟垃圾收集或完全省略它 - 实现垃圾收集的实现质量问题，只要没有收集到仍然可以访问的对象。

> Note that the use of the implementation’s tracing or debugging facilities may keep objects alive that would normally be collectable. Also note that catching an exception with a ‘try...except‘ statement may keep objects alive.

一些对象引用到了外部资源，如打开文件或窗口。不用说这些资源会被释放掉当对象被GC的时候，然而垃圾回收不保证一定发生，因此 objects 还会提供显示的方式释放外部资源，通常是`close()`方法。强烈推荐显示的close这类资源。`try...finally` 和 `with` 提供了很方便的方式来做这件事。

有些对象会引用其他对象，这些被叫做容器。如 tuples、lists、dictionaries。

对象类型影响对象行为的方方面面。甚至在某些情形下会影响对象的 identify。

对象的 身份 `identity` 和 类型 `type` 在创建后都是不可改变的，对象的值 `value` 可能是可以改变的，如 容器类型 对象的值是可改变的，普通对象类型的值 `value` 是不可变的。

## 3.2. The standard type hierarchy

### None : `None` (false)

这个类型只有一个值。只有一个对象具有该值。

这个对象可以通过内建的名称 `None` 访问。

它经常用于表示没有值，例如：它在函数没有显示的返回值的情况下返回。

它的真值判断是 `false`。

### NotImplemented : `NotImplemented` (true) 

这个类型只有一个值。只有一个对象具有该值。

这个对象可以通过内建的名称 `NotImplemented` 访问。

如果 数值方法 （Numeric methods） 和 丰富的比较方法 （comparison methods）未实现所提供操作数的操作，则应返回此值。（然后，解释器将根据操作符尝试反射操作或其他一些后备用操作。）

它的真值判断是 `true`。

### Ellipsis : `Ellipsis` or `...` (true) 

这个类型只有一个值。只有一个对象具有该值。

这个对象可以通过内建的名称 `Ellipsis` 或者字面值 `...` 访问。

它的真值判断是 `true`。

### numbers.Number

它们由数字字面量创建，并由算数运算符或者内置的算数函数作为结果返回。数字对象是不可变的，一旦创建它们的值将不能改变。

Python中的数字显然与数学中的数字密切相关，但受到计算机中数值表示的限制。

Python区分整数 `integers`、浮点数 `floating` 和 复数 `complex`。

1. numbers.Integral (int & bool)
2. numbers.Real (float)
3. numbers.Complex (complex)

### Sequences

这些代表使用非负整数索引的有限的有序的的点集。内建函数 `len()` 返回序列中条码的个数。n: 0 -> n-1;

a[i:j]: i <= k < j.
a[i:j:k]: x = i + n*k, n >= 0 and i <= x < j.

#### Immutable sequences (Dictionaries)

* Strings
* Tuples
* Bytes

#### Mutable sequences (可变序列)

* Lists
* Byte Arrays

### Set types

* Sets
* Frozen sets

### Mappings

* Dictionaries

### Callable types （可调用类型）

以下这些是可以应用函数调用操作符的类型：

* User-defined functions

    用户定义的函数对象由函数定义创建。应该使用包含与函数的 形参列表 相同数量的 实参 来调用它。

    特殊属性：

     Attribute           | RW  | Meaning
    ---------------------|-----|--------------------------------------------------------------
    `__doc__`            | W   | 函数的文档字符串，如果未定义则为 `None`，不会被子类继承
    `__name__`           | W   | 函数名称
    `__qualname__`       | W   | 函数全路径名称
    `__module__`         | W   | 函数定义所在模块的名称，如果未定义则为 `None`
    `__defaults__`       | W   | 包含具有默认值参数的元组，如果未定义则为 `None`
    `__code__`           | W   | 表示编译后的函数体的 `Code` 对象
    `__globals__`        | R   | 对包含函数全局变量的字典的引用 - 定义函数的模块的全局命名空间。
    `__dict__`           | W   | 用于支持任意函数属性的命名空间
    `__closure__`        | R   | 闭包，包含函数绑定的自由变量。`tuple of cell` 或者 `None`
    `__annotations__`    | W   | 包含函数参数注解的字典。
    `__kwdefaults__`     | W   | 包含只有关键字参数的默认值的字典。

    函数对象还支持获取和设置任意属性，例如，可以支持将元数据附加到函数。常规 属性访问符号（`.`）用于读写此类属性。

    注意，当前实现仅在用户自定义函数上支持函数属性，内建函数的函数属性可能会在未来提供支持。

    `__closure__`： `cell object` 具备 `cell_contents` 属性。可用于读取以及设置 `cell` 的值。

    关于函数的更多的信息，可以从其 `__code__` 对象上获取。

* Instance methods

    三种方法：实例方法、静态方法 `@staticmethod`、类方法 `@classmethod`
  
    ```py
    class Foo(object):
        """类三种方法语法形式"""
    
        def instance_method(self):
            print("实例方法")
    
        @staticmethod
        def static_method():
            print("静态方法")
    
        @classmethod
        def class_method(cls):
            print("类方法")
    ```

    实例方法对象组合了类，类的实例，以及 任何可调用的对象（通常是用户定义的函数）。

    特殊的只读属性：

    * `__self__` 是类实例对象
    * `__func__` 是函数对象，与 `__code__` 不同
    * `__doc__` 是方法的文档，（`__func__.__doc__`）
    * `__name__` 是方法的名字，（`__func__.__name__`）
    * `__module__` 是方法所在模块的名字，不可用则为 `None`


    Function vs Method

    1. 函数(Function)是Python中一种可调用对象, 方法(Method)是一种特殊的函数。
    2. 一个可调用对象是方法还是函数，和这个可调用对象本身无关，仅和这个对象是否与类或实例绑定有关。
    3. 实例方法，在类中未和类绑定，是函数；在实例中与实例绑定，即变成方法。
    4. 静态方法没有和任何类或实例绑定，所以静态方法是个函数。
    5. 装饰器不会改变被装饰的可调用对象的类型。
    6. 类实现 `__call__` 方法，其实例也不会变成方法或函数，依旧是类的实例。
    7. 使用 `callalble()` 只能判断对象是否可调用，不能判断是不是函数或方法。
    8. 判断对象是函数或方法应该使用 `type(obj)`。

    参考：
    
    * [Python 自定义函数的特殊属性](https://segmentfault.com/a/1190000005685090)
    * [Python 实例方法的特殊属性](https://segmentfault.com/a/1190000005701971)
    * [Python 函数和类的一些研究](https://segmentfault.com/a/1190000004266443)

* Generator functions

    ```py
    def generator_func_fib(n):
        print('this is generator function')
        a = b = 1
        for i in range(n):
            yield a
            a, b = b, a + b
    ```

* Coroutine functions

    ```py
    async def async_func():
        print('this is coroutine function')
    ```

see：[Coroutines](https://docs.python.org/3/reference/datamodel.html#coroutines)

* Asynchronous generator functions

    ```py
    async def async_generator_func():
        yield print('this is async generator function')
    ```

* Built-in functions

    内置函数对象是C函数的包装器。内置函数的例子 `len()` 和 `math.sin()`（math是标准内置模块）。

    参数的数量和类型由C函数决定。

    特殊只读属性：

    * `__doc__` 是函数的文档字符串 或者是 `None`；
    * `__name__` 是函数的名字；
    * `__self__` 被设置为 `None`；
    * `__module__` 是模块的名字，或者是 `None`；

* Built-in methods

    内建方法确实只是内置函数的不同伪装，这次包含一个传递给C函数的对象作为隐式额外参数。一个内建方法的例子是 `alist.append()`，假定 `alist` 是一个 `list` 对象。在这种情况下，特殊的只读属性 `__self__` 被设置为 `alist` 表示的对象。

* Classes

    类是可调用的。这些对象通常充当自身新实例的工厂，但是对于覆盖 `__new__()` 的类可能存在变化。调用的参数传递给 `__new__()`，在典型情况下，传递给 `__init__()` 以初始化新实例。

    ```py
    class Person:
        # __new__ 通常用于控制生成一个新实例的过程。
        # 它是类级别的方法：p = Person.__new__(Person)
        def __new__(cls, name, age):
            print '__new__ called.'
            return super(Person, cls).__new__(cls, name, age)

        # __init__ 通常用于初始化一个新实例，控制这个初始化的过程，发生在类实例被创建完以后。
        # 它是实例级别的方法：instance.__init__()
        def __init__():
        
        # 对象被销毁是调用
        def __del__():
    ```

* Class Instances

    通过在类中定义 `__call__()` 方法，可以使任意 `类的实例` 可调用。这样，类实例就可以当做函数使用。

### Modules

### Custom classes

### Class instances

### I/O objects (also known as file objects)

### Internal types

## 3.3. Special method names

一个类可以通过定义特定名字的方法实现某些使用特定语法调用的操作。这是Pthon实现operator overloading的方式，允许类他们在尊重语言操作符的前提下定义自己的行为。

### 3.3.1. Basic customization

method                            | description
----------------------------------|------------------------------------------
`__new__(cls[, ...])`             | 构造器方法，必须返回一个合法的对象。
`__init__(self[, ...])`           | 构造器方法，做的实际上是对象初始化工作。
`__del__(self)`                   | 解构器方法，引用计数为0时执行。
`__repr__(self)`                  | Called by `repr()` built-in function. 
`__str__(self)`                   | Called by `str(object)` and the built-in functions `format()` and `print()`.
`__bytes__(self)`                 | Called by `bytes()` to compute a byte-string representation of an object.
`__format__(self, format_spec)`   | Called by `format()`. [formatspec](https://docs.python.org/3/library/string.html#formatspec)
`__lt__(self, other)`             | `<`
`__le__(self, other)`             | `<=`
`__eq__(self, other)`             | `==`
`__ne__(self, other)`             | `!=`
`__gt__(self, other)`             | `>`
`__ge__(self, other)`             | `>=`
`__hash__(self)`                  | `__hash__()` should return an integer.
`__bool__(self)`                  | should return False or True.

### 3.3.2. Customizing attribute access

method                            | description
----------------------------------|------------------------
`__getattr__(self, name)`         | Called when an attribute lookup has not found the attribute in the usual places.
`__getattribute__(self, name)`    | Called unconditionally to implement attribute accesses for instances of the class.
`__setattr__(self, name, value)`  | Called when an attribute assignment is attempted.
`__delattr__(self, name)`         | Like `__setattr__()` but for attribute deletion instead of assignment.
`__dir__(self)`                   | Called when `dir()` is called on the object.

#### 3.3.2.1. Implementing Descriptors

In the examples below, “the attribute” refers to the attribute whose name is the key of the property in the owner class’ __dict__.

method                            | description
----------------------------------|------------------------
`__get__(self, instance, owner)`  | Called to get the attribute of the owner class or of an instance of that class.
`__set__(self, instance, value)`  | Called to set the attribute on an instance instance of the owner class to a new value.
`__delete__(self, instance)`      | Called to delete the attribute on an instance instance of the owner class.

#### 3.3.2.2. Invoking Descriptors

类似 `Javascript` 的访问器属性。

一般来说，一个描述符 绑定行为 的对象属性。通过描述符协议：`__get__()`, `__set__()`, and `__delete__()`复写属性访问。对象定义了其中任意的方法，就被是为一个描述符。

默认的属性访问行为是：`get`、`set`、`delete` 属性从对象数据字典。如 `a.x lookup a.__dict__['x'] then type(a).__dict__['x']`。

method                            | description
----------------------------------|------------------------
Direct Call                       |`x.__get__(a)`
Instance Binding                  | `a.x` -> `type(a).__dict__['x'].__get__(a, type(a))`
Class Binding                     | `A.x` -> `A.__dict__['x'].__get__(None, A)`
Super Binding                     |

#### 3.3.2.3. `__slots__`

如果我们想要限制 `class` 的属性怎么办？比如，只允许对 `Student` 实例添加 `name` 和 `age` 属性。为了达到限制的目的，`Python` 允许在定义 `class` 的时候，定义一个特殊的 `__slots__` 变量，来限制该 `class` 能添加的属性：

```py
class Student(object):
    __slots__ = ('name', 'age') # 用 tuple 定义允许绑定的属性名称
```

### 3.3.3. Customizing class creation

[python-metaclass](http://xiaocong.github.io/blog/2012/06/12/python-metaclass/)

By default, classes are constructed using type(). The class body is executed in a new namespace and the class name is bound locally to the result of type(name, bases, namespace).

The class creation process can be customized by passing the metaclass keyword argument in the class definition line, or by inheriting from an existing class that included such an argument. In the following example, both MyClass and MySubclass are instances of Meta:

```py
class Meta(type):
    pass

class MyClass(metaclass=Meta):
    pass

class MySubclass(MyClass):
    pass
```

When a class definition is executed, the following steps occur:

* the appropriate metaclass is determined，适当的元类型被确定
* the class namespace is prepared，类命名空间被准备
* the class body is executed，类体被执行
* the class object is created，类的对象实例被创建

#### 3.3.3.1. Determining the appropriate metaclass

The appropriate metaclass for a class definition is determined as follows:

* if no bases and no explicit metaclass are given, then type() is used
* if an explicit metaclass is given and it is not an instance of type(), then it is used directly as the metaclass
* if an instance of type() is given as the explicit metaclass, or bases are defined, then the most derived metaclass is used

The most derived metaclass is selected from the explicitly specified metaclass (if any) and the metaclasses (i.e. type(cls)) of all specified base classes. The most derived metaclass is one which is a subtype of all of these candidate metaclasses. If none of the candidate metaclasses meets that criterion, then the class definition will fail with TypeError.

#### 3.3.3.2. Preparing the class namespace

#### 3.3.3.3. Executing the class body

#### 3.3.3.4. Creating the class object

#### 3.3.3.5. Metaclass example

```py
class OrderedClass(type):

    @classmethod
    def __prepare__(metacls, name, bases, **kwds):
        return collections.OrderedDict()

    def __new__(cls, name, bases, namespace, **kwds):
        result = type.__new__(cls, name, bases, dict(namespace))
        result.members = tuple(namespace)
        return result

class A(metaclass = OrderedClass):
    def one(self): pass
    def two(self): pass
    def three(self): pass
    def four(self): pass

# >>> A.members
# ('__module__', 'one', 'two', 'three', 'four')
```

### 3.3.4. Customizing instance and subclass checks

method                              | description
------------------------------------|----------------------------
`__instancecheck__(self, instance)` | `isinstance(instance, class)`
`__subclasscheck__(self, subclass)` | `issubclass(subclass, class)`

### 3.3.5. Emulating callable objects

method                      | description
----------------------------|----------------------------
`__call__(self[, args...])` | `x(arg1, arg2, ...)` -> `x.__call__(arg1, arg2, ...)`

### 3.3.6. Emulating container types

method                            | description
----------------------------------|------------------------
`__len__(self)`                   | Called to implement the built-in function `len()`.
`__length_hint__(self)`           | Called to implement `operator.length_hint()`.
`__getitem__(self, key)`          | Called to implement evaluation of `self[key]`.
`__missing__(self, key)`          | Called by `dict.__getitem__()` to implement `self[key]`.
`__setitem__(self, key, value)`   | Called to implement assignment to `self[key]`.
`__delitem__(self, key)`          | Called to implement deletion of `self[key]`.
`__iter__(self)`                  | This method is called when an iterator is required for a container.
`__reversed__(self)`              | Called (if present) by the `1reversed()` built-in to implement reverse iteration.
`__contains__(self, item)`        | Called to implement membership test operators.

### 3.3.7. Emulating numeric types

method                            | description
----------------------------------|------------------------
`__add__(self, other)`            | `+`
`__sub__(self, other)`            | `-`
`__mul__(self, other)`            | `*`
`__matmul__(self, other)`         | `@`
`__truediv__(self, other)`        | `/`
`__floordiv__(self, other)`       | `//`
`__mod__(self, other)`            | `%`
`__divmod__(self, other)`         | `divmod()`
`__pow__(self, other[, modulo])`  | `pow()`、`**`
`__lshift__(self, other)`         | `<<`
`__rshift__(self, other)`         | `>>`
`__and__(self, other)`            | `&`
`__xor__(self, other)`            | `^`
`__or__(self, other)`             | `|`

method                            | description
----------------------------------|------------------------
`__radd__(self, other)`           | `+`
`__rsub__(self, other)`           | `-`
`__rmul__(self, other)`           | `*`
`__rmatmul__(self, other)`        | `@`
`__rtruediv__(self, other)`       | `/`
`__rfloordiv__(self, other)`      | `//`
`__rmod__(self, other)`           | `%`
`__rdivmod__(self, other)`        | `divmod()`
`__rpow__(self, other)`           | `pow()`、`**`
`__rlshift__(self, other)`        | `<<`
`__rrshift__(self, other)`        | `>>`
`__rand__(self, other)`           | `&`
`__rxor__(self, other)`           | `^`
`__ror__(self, other)`            | `|`

method                            | description
----------------------------------|------------------------
`__iadd__(self, other)`           | `+=`
`__isub__(self, other)`           | `-=`
`__imul__(self, other)`           | `*=`
`__imatmul__(self, other)`        | `@=`
`__itruediv__(self, other)`       | `/=`
`__ifloordiv__(self, other)`      | `//=`
`__imod__(self, other)`           | `%=` 
`__ipow__(self, other[, modulo])` | `**=`
`__ilshift__(self, other)`        | `<<=`
`__irshift__(self, other)`        | `>>=`
`__iand__(self, other)`           | `&=`
`__ixor__(self, other)`           | `^=`
`__ior__(self, other)`            | `|=`

method                            | description
----------------------------------|------------------------
`__neg__(self)`                   | `-`
`__pos__(self)`                   | `+`
`__abs__(self)`                   | `abs()`
`__invert__(self)`                | `~`

method                            | description
----------------------------------|------------------------
`__complex__(self)`               | `complex()`
`__int__(self)`                   | `int()`
`__float__(self)`                 | `float()`
`__round__(self[, n])`            | `round()`

method                            | description
----------------------------------|------------------------
`__index__(self)`                 | `index()`

### 3.3.8. With Statement Context Managers

method                            | description
----------------------------------|------------------------
`__enter__(self)`                 | Enter the runtime context related to this object.
`__exit__(self, exc_type, exc_value, traceback)`  | Exit the runtime context related to this object. 

### 3.3.9. Special method lookup

## 3.4. Coroutines

### 3.4.1. Awaitable Objects

method             | description
-------------------|------------------------
`__await__(self)`  | Must return an iterator. Should be used to implement awaitable objects.


### 3.4.2. Coroutine Objects

* `coroutine.send(value)`
* `coroutine.throw(type[, value[, traceback]])`
* `coroutine.close()`

### 3.4.3. Asynchronous Iterators

method             | description
-------------------|------------------------
`__aiter__(self)`  | Must return an asynchronous iterator object.
`__anext__(self)`  | Must return an awaitable resulting in a next value of the iterator.

### 3.4.4. Asynchronous Context Managers

method                                              | description
----------------------------------------------------|------------------------
`__aenter__(self)`                                  | Difference from `__enter__()` is it must return an awaitable.
`__aexit__(self, exc_type, exc_value, traceback)`   | Difference from `__exit__()`, is it must return an awaitable.

## 5. The import system

5.1. importlib

5.2. Packages

5.2.1. Regular packages

5.2.2. Namespace packages

5.3. Searching

5.3.1. The module cache

5.3.2. Finders and loaders

5.3.3. Import hooks

5.3.4. The meta path

5.4. Loading

5.4.1. Loaders

5.4.2. Submodules

5.4.3. Module spec

5.4.4. Import-related module attributes

5.4.5. `module.__path__`

5.4.6. Module reprs

5.5. The Path Based Finder

5.5.1. Path entry finders

5.5.2. Path entry finder protocol

5.6. Replacing the standard import system

5.7. Special considerations for `__main__`

5.7.1. `__main__.__spec__`

5.8. Open issues

5.9. References
