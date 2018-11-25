# Node.js

* https://nodejs.org
* https://en.wikipedia.org/wiki/Node.js

> Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine.
> Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and efficient.
> Node.js' package ecosystem, npm, is the largest ecosystem of open source libraries in the world.

## Learning program

### 学习过程

* 入门学习，学习Node.js使用
  * 学习Node.js离不开学习JavaScript，了解Node.js特性特点，应用场景，简单使用
  * 深入Node.js模块加载机制，`module.exports VS exports`，加载次序、逻辑、路径等
  * 学习Node.jsApi用法，尤其是`events`、、`stream`、`net`、`http`，其他如`child_process`、`events`、`fs`、`global`、`module`、`os`、`path`、`process`、`util`
  * 学习Node.js异步流程控制的方法的使用及实现原理，`async`、`Generator`、`ES7.AsyncAwait`
  * 学习Node.js调试技术 - `手段`、`方法`、`技巧`、`优劣`
  * 能够使用常用开发框架完成日常开发需求，学习各类模块使用用法及分析其实现源码
* 深入学习，学习Node.js本身而不是其应用
  * 深入学习JavaScript，了解Node.js运行平台为什么选择JavaScript作为平台语言，了解Node.js诞生的背景
  * 学习Node.js运行原理，事件驱动模型、异步非阻塞模型
  * 阅读Node.js源代码，了解Node.js内部设计，代码结构。学习libuv，了解事件循环实现原理及一系列底层数据结构

### Getting Started

1. 学习JavaScript

学习Node.js从学习JavaScript开始，建议在Node.js环境下学习JavaScript语法。

学习JavaScript参考：

2. 学习Node.js

首先需要了解Node.js，学习Node.js Api的使用，使用Api完成一些练习项目。
学习Node.js模块系统，这个很重要。
学习并理解异步流程控制，完成简单的WEB项目。

本过程可以参考部分书籍上的示例教程，多动手编码实践，更快速的看到效果，加快学习速度。

3. 开始参与项目

学习项目结构，相关规范，常用模块。

### Api

* https://nodejs.org/api/
* http://nodejs.cn/api/

### node_modules

* npm https://www.npmjs.com/  https://docs.npmjs.com/
* yarn
* bower

### Node.js WEB Develop

* Express/Koa/hapi/thinkjs
* mysql/sequelize
* mongoDB/mongoose
* redis/ioredis
* log4js/winston/bunyan
* request/superagent

### Tools

* lodash
* bluebird
* commander/minimist/colors/chalk

### workflow

* gulp
* grunt

### BDD/TDD/DDD

* mocha/chai
* ava

### lint

* eslint

### babel.js

* babel-core
* babel-polyfill
* babel-register
* babel-runtime
* babel-preset-es2015
* babel-preset-es2016
* babel-preset-es2017
* babel-plugin-transform-runtime
* babel-plugin-transform-decorators-legacy

### PM2

* https://github.com/Unitech/pm2
* http://pm2.keymetrics.io/

### Promise

* [PromiseA+](https://promisesaplus.com/)

## 资源

### Books

* 《Node.js实战》
* 《Node.js实战（第2季）》
* 《Node.js权威指南》
* 《超实用的Node.js代码段》
* 《深入浅出Node.js》

### WebSites

* [Callback Hell](http://callbackhell.com/)
* [http://fibjs.org/](http://fibjs.org/)
* [七天学会NodeJS](http://nqdeng.github.io/7-days-nodejs)
* [nodeschool](https://nodeschool.io/)
* http://node.green/
* https://v8docs.nodesource.com/
* https://www.zhihu.com/topic/19569535

### Articles

* [[译] NodeJS 错误处理最佳实践](https://segmentfault.com/a/1190000002741935)
* [查看 Node.js 中的内存泄露](http://www.oschina.net/translate/tracking-down-memory-leaks-in-node-js-a-node-js-holiday-season)

* [Node.js debugging with Chrome DevTools (in parallel with browser JavaScript)](https://blog.hospodarets.com/nodejs-debugging-in-chrome-devtools)
* [来自HeroKu的HTTP API 设计指南(中文版)](http://www.open-open.com/lib/view/open1409492280416.html)
* [https://developers.trello.com/apis](https://developers.trello.com/apis)

* [Platform API Reference](https://devcenter.heroku.com/articles/platform-api-reference)
* [nodejs中流(stream)的理解](http://segmentfault.com/blog/chshouyu/1190000000519006)
* [怎样有效地学习 Node.js？](https://www.zhihu.com/question/19793473)
* [a-node-js-holiday-season](https://hacks.mozilla.org/category/a-node-js-holiday-season/)
* [bdd-tdd](https://www.robotlovesyou.com/bdd-tdd/)
* [node-js-at-scale-understanding-node-js-event-loop/](https://blog.risingstack.com/node-js-at-scale-understanding-node-js-event-loop/)
* [debugging-node-js-memory-leaks](http://dtrace.org/blogs/bmc/2012/05/05/debugging-node-js-memory-leaks/)
* [node-js-require-cache-possible-to-invalidate](http://stackoverflow.com/questions/9210542/node-js-require-cache-possible-to-invalidate)
* [node-js_gc](https://blog.eood.cn/node-js_gc)
* [how-do-i-debug-node-js-applications](http://stackoverflow.com/questions/1911015/how-do-i-debug-node-js-applications)
* [how-do-i-get-started-with-node-js](http://stackoverflow.com/questions/2353818/how-do-i-get-started-with-node-js)
* [node-debug-tutorial](http://i5ting.github.io/node-debug-tutorial/)

* [异步流程控制：7 行代码学会 co 模块](https://segmentfault.com/a/1190000002732081)
* [深入理解Node.js的异步编程风格](http://lishaofengstar.blog.163.com/blog/static/1319728522013102665718744/)
* [[译] 深入理解 Promise 五部曲：1. 异步问题](https://segmentfault.com/a/1190000000586666)
* [[译] 深入理解 Promise 五部曲：2. 控制权转换问题](https://segmentfault.com/a/1190000000591382)
* [[译] 深入理解 Promise 五部曲：3. 可靠性问题](https://segmentfault.com/a/1190000000593885)
* [[译] 深入理解 Promise 五部曲：4. 扩展问题](https://segmentfault.com/a/1190000000600268)
* [[译] 深入理解 Promise 五部曲：5. LEGO](https://segmentfault.com/a/1190000000611040)
* [回调函数是指令式的，Promise 是函数式的：Node 错失的最大机会](https://segmentfault.com/a/1190000000356347)
* [当面试官问你Promise的时候，他究竟想听到什么？](https://zhuanlan.zhihu.com/p/29235579)
* [一个Promise面试题](https://github.com/lzlu/Blog/issues/7)
* [这一次，彻底弄懂 JavaScript 执行机制](https://juejin.im/post/59e85eebf265da430d571f89)
