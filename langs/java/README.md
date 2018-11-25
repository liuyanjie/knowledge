# Java

* [深入理解Java类型信息(Class对象)与反射机制](https://blog.csdn.net/javazejian/article/details/70768369)

## class Class {}

### Class对象作用

在 Java 中用来表示运行时类型信息的对应类就是 Class 类，Class 类也是一个实实在在的类，存在于JDK的 java.lang 包中。

Class 类被实例化后的对象就是 Class 对象，Class 对象描述了类的类型信息，每一个类都有一个对应描述类的信息的 Class 类实例。

比如创建一个 Shapes 类，那么，JVM 就会创建一个 Shapes 对应 Class 类的实例，该 Class 类的实例保存了 Shapes 类相关的类型信息。

在 Java 中每个类都有一个 Class 对象，每当我们编写并且编译一个新创建的类就会产生一个对应 Class 对象并且这个 Class 对象会被保存在同名 .class 文件里。

当我们需要用到一个类时，JVM 类加载器会将对应类的 .class 描述文件加载到 JVM 中，然后 JVM 根据 Class对象 实例化对象或提供静态变量的引用值。

所以在 JVM 面前，每个一个类都被表示成 Class 类的实例，.class 文件保存了 Class 类实例的字节码，.class 被加载后被还原成 Class 实例，也可以反编译还原为对应的类。

Class 类实例作用是运行时提供或获得某个对象的类型信息，这点对于反射技术很重要。


```java
public final class Class<T> implements java.io.Serializable,
                              GenericDeclaration,
                              Type,
                              AnnotatedElement {
    private static final int ANNOTATION= 0x00002000;
    private static final int ENUM      = 0x00004000;
    private static final int SYNTHETIC = 0x00001000;
}
```

### Class对象的加载及其获取方式


