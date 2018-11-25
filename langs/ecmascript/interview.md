# 笔试/面试题目

## Promise

* [当面试官问你Promise的时候，他究竟想听到什么？](https://zhuanlan.zhihu.com/p/29235579)

Promise.resolve(1).then(console.log); console.log(2)

`try...catch...finally` 为什么无法捕获异常？

关于Promise的问题一览

* 什么是Promise
* 传统的回调式异步操作有什么缺点？（Promise是如何解决异步操作）
* Promise中的异步模式有哪些？有什么区别？
* 如果向Promise.all()和Promise.race()传递空数组，运行结果会有什么不同？
* 如何确保一个变量是可信任的Promise（Promise.resolve方法传入不同值的不同处理有哪些）
* Promise是如何捕获异常的？与传统的try/catch相比有什么优势？


1. 什么是 Promise？

Promise 对象用于表示一个异步操作的最终状态（完成或失败），以及其返回的值。

Promise 如其名字一样，表示了一种承诺

2. 传统的回调式的异步逻辑处理有何缺点？

传统的回调有五大信任问题：

* 调用回调过早

  对于 `Promise` 来说，即使是立即完成的 `Promise` 也无法被同步观察到，也就是说一个 `Promise` 调用 `then()` 的时候，即使这个 `Promise` 已经决议了，提供给 `then` 的回调也总会被异步调用。
  
  简单来说，即使 `new Promise( function executor(resolve, reject) {...} )` 时，`executor` 同步的调用 `resolve` 或 `reject`，也需要等到 `then` 的回调函数被异步调用时才能拿到结果，需要在下一次事件循环中处理，`resolve` 或 `reject` 虽然立即调用，但是它们所在的函数能够继续完成剩下的逻辑，而普通的带有一个回调函数参数 `cb` 的函数在调用回调函数 `cb` 时，`cb` 执行时，`cb` 函数内部的逻辑会影响 `cb` 调用位置后的代码执行，此所谓 `回调调用过早`。

* 调用回调过晚（或没有被调用）

  对于一个Promise对象注册的每一个观察回调都是相对独立、互不干预的。而Promise对象调用resolve()和reject()时，每个注册的观察回调也都会被自动调度。所以这些观察回调的任意一个都无法影响或延误对其他回调的调用。

  此外，关于回调未调用。正常情况下，没有任何东西可以阻止Promise向你通知它的决议，即使你的JavaScript代码报错了，一会通过异常回调来捕获到。如果Promise永远不被决议的话，Promise本身已提供了竞态的抽象机制来作为解决方案。

* 调用回调次数过少或过多
* 未能传递所需的环境和参数
* 吞掉可能出现的错误和异常

另外，深层次的异步回调嵌套带来的 回调地狱 对应代码来说是一个灾难。

1. 
