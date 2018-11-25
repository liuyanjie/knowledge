# ECMAScript/JavaScript

* [JavaScript Base](javascript-base.md)
* [JavaScript Deep](javascript-deep.md)
* [JavaScript Regexp](javascript-regexp.md)
* [JavaScript Thread Model](javascript-thread-model.md)

## 参考

* javascript-the-core [翻译](http://weizhifeng.net/javascript-the-core.html) [原文](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/)
* http://www.raychase.net/1968?replytocom=51795
* http://www.codeceo.com/article/javascript-threaded.html
* http://www.cnblogs.com/yakun/p/3802725.html
* http://www.cnblogs.com/rainman/archive/2008/12/26/1363321.html
* http://ejohn.org/blog/how-javascript-timers-work/
* http://www.zhihu.com/question/20866267
* http://www.zhihu.com/question/31982417
* http://blog.thomasbelin.fr/p/javascript-single-threaded-et-asynchrone/
* https://developer.mozilla.org/en-US/docs/Web/JavaScript/EventLoop
* http://www.ruanyifeng.com/blog/2014/10/event-loop.html
* http://blog.csdn.net/z742182637/article/details/51536140
* http://www.cnblogs.com/wilber2013/p/4909430.html#_nav_0
* https://www.nczonline.net/blog/2013/06/25/eval-isnt-evil-just-misunderstood/
* http://www.cnblogs.com/dolphinX/p/3524977.html
* http://www.kancloud.cn/kancloud/deep-understand-javascript/43686


## 介绍

* [ECMAScriptWiki](https://en.wikipedia.org/wiki/ECMAScript)
* [JavaScriptWiki](https://en.wikipedia.org/wiki/JavaScript)

> ECMAScript是语言规范，JavaScript是规范的一种实现，其他实现如ActionScript。

> JavaScript，一种高级编程语言，通过解释执行，是一门动态类型，面向对象（基于原型）的直译语言[4]。它已经由ECMA（欧洲电脑制造商协会）通过ECMAScript实现语言的标准化[4]。它被世界上的绝大多数网站所使用，也被世界主流浏览器（Chrome、IE、FireFox、Safari、Opera）支持。JavaScript是一门基于原型、函数先行的语言[5]，是一门多范式的语言，它支持面向对象编程，命令式编程，以及函数式编程。它提供语法来操控文本，数组，日期以及正则表达式等，不支持I/O，比如网络，存储和图形等，但这些都可以由它的宿主环境提供支持。


## 术语

* ECMAScript：一个由 ECMA International 进行标准化，TC39 委员会进行监督的语言。通常用于指代标准本身。
* JavaScript：ECMAScript 标准的各种实现的最常用称呼。这个术语并不局限于某个特定版本的 ECMAScript 规范，并且可能被用于任何不同程度的任意版本的 ECMAScript 的实现。
* ECMAScript 5 (ES5)：ECMAScript 的第五版修订，于 2009 年完成标准化。这个规范在所有现代浏览器中都相当完全的实现了。
* ES.Harmony 在正式被指名为 ECMAScript 第 6 版 (ES6) 之前，这个新的标准原本被称为 ES.Harmony（和谐）。
* ECMAScript 6 (ES6) / ECMAScript 2015 (ES2015)：ECMAScript 的第六版修订，于 2015 年完成标准化。这个标准被部分实现于大部分现代浏览器。
* ECMAScript 7 (ES7) / ECMAScript 2016 (ES2016)：ECMAScript 的第七版修订，于 2016 年完成标准化。
* ECMAScript 8 (ES8) / ECMAScript 2017 (ES2017)：ECMAScript 的第八版修订，于 2017 年完成标准化。
* ECMAScript 9 (ES9) / ECMAScript 2018 (ES2018)：ECMAScript 的第八版修订，于 2018 年完成标准化。
* ECMAScript Proposals：被考虑加入未来版本 ECMAScript 标准的特性与语法提案，他们需要经历五个阶段：0:Strawman（稻草人），1:Proposal（提议），2:Draft（草案），3:Candidate（候选）以及 4:Finished（完成）。
* [ES5, ES6, ES2016, ES.Next: JavaScript 的版本是怎么回事？「译」](https://huangxuan.me/2015/09/22/js-version/)

## 学习过程

* Getting Started：了解JavaScript历史，语言特点，掌握简单的语法使用，了解数据类型、语法结构、继承体系、闭包等
* 系统学习JavaScript API：Object、Function、String、Number、Date...
* 系统学习EcmaScript2015之后引入的大量语言特性
* 深入学习语言核心原理：`原型链`、`作用域链`、`词法作用域`、`语法树`、`上下文`、`this`、`变量对象`、`活动对象`、`闭包`、`垃圾回收` ...
* 能够阅读并理解EcmaScript语言规范

### Getting Started

这并不是一个真正的入门教程，而是列出一些比较好的学习资源。

注意：部分教程在网页环境中编写示例，单纯的学习JavaScipt语法，最好将环境相关的内容剔除。可以在Node.js环境中编写示例，测试，同时也建议使用调试模式，能够断点调试，查看堆栈信息。

入门JavaScript，能够简单使用JavaScript编写代码，建议花费时间 2~3 小时，通过编写代码，逐步加深对语言语法的学习和理解。

#### MDN

强烈建议参考MDN上的入门教程学习JavaScript，MDN上的内容多质量高，而且更新速度快，能够很快跟进语言标准。是WEB开发人员的最佳学习站点之一。

建议先熟悉站点儿结构，了解网站内都有些什么内容，根据自己的需要，阅读想过内容。

* [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
* [JavaScript/Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide)
* [JavaScript/Reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference)
* [A_re-introduction_to_JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript)
* [JavaScript/Data_structures](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures)
* [Equality_comparisons_and_sameness](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Equality_comparisons_and_sameness)
* [Web/API/Document_Object_Model](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)
* [Web/API](https://developer.mozilla.org/en-US/docs/Web/API)

#### JavaScript-Garden

* [JavaScript-Garden](http://bonsaiden.github.io/JavaScript-Garden/zh/)

#### 基础教程

* [javascript基础系列](http://www.cnblogs.com/zhichaobouke/p/6151247.html)
* [JavaScript简易教程](http://yanhaijing.com/javascript/2014/05/12/basic-javascript/)

#### Books

* 《JavaScript高级程序设计》（1-7章）
* 《javascript语言精粹》
* 《javascript权威指南》
* 《javascript函数式编程》
* 《javascript设计模式》
* 《编写可测试的Javascript》
* 《Effective JavaScript：编写高质量JavaScript代码的68个有效方法》
* [Eloquent JavaScript(second edition)](http://eloquentjavascript.net/)
* [深入理解JavaScript系列](http://www.cnblogs.com/TomXu/archive/2011/12/15/2288411.html)
* [你不知道的JavaScript](https://github.com/getify/You-Dont-Know-JS)
* [Exploring ES6](http://exploringjs.com/es6/index.html)
* [Exploring JS](http://exploringjs.com/)

#### 视频教程

* [李彦恢JavaScript视频教程](http://www.ycku.com/javascript/)


## 资源

### 语法规范

* [ecmascript](http://www.ecmascript.org/)
* [ecma-262](http://www.ecma-international.org/ecma-262/5.0/)
* [ecma-262/5.1](http://www.ecma-international.org/ecma-262/5.1/)
* [ecma-262/6.0](http://www.ecma-international.org/ecma-262/6.0/)
* [ecma-262/7.0](http://www.ecma-international.org/ecma-262/7.0/)
* [ECMAScript 6: New Features: Overview and Comparison](http://es6-features.org/#Constants)
* [ECMAScript 6 compatibility table](https://kangax.github.io/compat-table/es6/)

### TC39Group

通过关注标准制订工作组TC39，可以及时掌握语言动态，跟踪特性，及时学习跟进

* [TC39](https://github.com/tc39)
* [proposals](https://github.com/tc39/proposals)
* [The TC39 Process](https://tc39.github.io/process-document/)
* [ECMAScript® Language Specification (ECMA-262)](https://github.com/tc39/ecma262)
* [ECMAScript Internationalization API Specification (Ecma-402)](https://github.com/tc39/ecma402)

### ES.next

* [ECMAScript 6 入门](http://es6.ruanyifeng.com/)
* [learn-es2015](https://babeljs.io/learn-es2015/)
* [es6features](https://github.com/lukehoban/es6features)

### javascript-syntax-summary

* [js-syntax](https://github.com/liuyanjie/study/blob/master/javascript/syntax/js-syntax.md)

### HTML

* [HTML Living Standard](https://html.spec.whatwg.org/)

### decorators

* https://github.com/wycats/javascript-decorators
* http://www.cnblogs.com/whitewolf/p/details-of-ES7-JavaScript-Decorators.html
* http://www.tuicool.com/articles/2yeiEr
* https://www.zhihu.com/question/24863332
* http://stackoverflow.com/questions/33801311/webpack-babel-6-es6-decorators
* AOP

### Meta-Programing

* [28. Metaprogramming with proxies](http://exploringjs.com/es6/ch_proxies.html)

### Articles

* http://dmitrysoshnikov.com/ecmascript/
* [ES6 In Depth Articles](https://hacks.mozilla.org/category/es6-in-depth/)
* [【深入JavaScript】1.JavaScript核心概念：执行环境及作用域（读书笔记）](http://www.cnblogs.com/stay-foolish/archive/2013/03/24/2977858.html)
* [【深入JavaScript】2.闭包（读书笔记）](http://www.cnblogs.com/stay-foolish/archive/2013/03/25/2977988.html)
* [【深入JavaScript】3.JavaScript继承的实现总结](http://www.cnblogs.com/stay-foolish/archive/2013/04/04/2482813.html)
* [【转】Javascript 的词法作用域、调用对象和闭包](http://www.cnblogs.com/jazzka702/archive/2009/12/30/1636235.html)
* [精通 JS正则表达式](http://www.iteye.com/topic/481228/)
* [深入浅出闭包与作用域链](http://blog.csdn.net/zerohjw/article/details/5921652)
* [深入实现Promise A+规范](https://shaynegui.com/promise-aplus-implementation/)
* [谈谈JavaScript的异步实现](http://blog.csdn.net/a1003671336/article/details/17631131)
* [【翻译】Promises/A+规范](http://www.ituring.com.cn/article/66566)
* [悟透JavaScript](http://www.cnblogs.com/leadzen/archive/2008/02/25/1073404.html)
* [异步javascript的原理和实现](http://www.cnblogs.com/BigTall/archive/2012/11/08/2759768.html)
* [正则表达式30分钟入门教程](http://deerchao.net/tutorials/regex/regex.htm)
* [Javascript异步编程的4种方法](http://www.chinaz.com/program/2013/0102/287832.shtml)
* [Asynchronous JS: Callbacks, Listeners, Control Flow Libs and Promises](http://sporto.github.io/blog/2012/12/09/callbacks-listeners-promises/)
* [Javascript Closures](http://jibbering.com/faq/notes/closures/)
* [http://astexplorer.net/](http://astexplorer.net/)
* [http://javascriptissexy.com/understand-javascripts-this-with-clarity-and-master-it/](http://javascriptissexy.com/understand-javascripts-this-with-clarity-and-master-it/)
* [http://detectmobilebrowsers.com/](http://detectmobilebrowsers.com/)
* [http://overapi.com/](http://overapi.com/)
* [http://ctrlq.org/rss/](http://ctrlq.org/rss/)
* [http://www.nowamagic.net/](http://www.nowamagic.net/)
* [http://html.com/](http://html.com/)
* [google-js-style](http://docs.kissyui.com/1.4/docs/html/tutorials/style-guide/google-js-style.html)
* [JSDoc3](http://usejsdoc.org/)
