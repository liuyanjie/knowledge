# 版本控制

## 版本控制系统

* [Git内容整理](vcs/git)

  * [GIT对象模型](git-object-model.md)
  * [Git工作机制](git-working-mechanism.md)
  * [Git使用规范](spec.md)

* [Svn内容整理](vcs/svn)

  * [SVN项目目录说明&操作规范](svn/svn-project-directory-description-and-operation-specification.md)
  * [SVN使用规范-协同开发中SVN的使用规范](svn/spec.md)

## 版本控制概念

### [语义化版本](http://semver.org/lang/zh-CN/)

Alpha、Beta、RC、GA版本的区别？

* Alpha：是内部测试版,一般不向外部发布,会有很多Bug.一般只有测试人员使用。
* Beta：也是测试版，这个阶段的版本会一直加入新的功能。在Alpha版之后推出。
* RC：(Release　Candidate) 顾名思义么 ! 用在软件上就是候选版本。系统平台上就是发行候选版本。RC版不会再加入新的功能了，主要着重于除错。
* GA:General Availability,正式发布的版本，在国外都是用GA来说明release版本的。
* RTM：(Release to Manufacture)是给工厂大量压片的版本，内容跟正式版是一样的，不过RTM版也有出限制、评估版的。但是和正式版本的主要程序代码都是一样的。
* OEM：是给计算机厂商随着计算机贩卖的，也就是随机版。只能随机器出货，不能零售。只能全新安装，不能从旧有操作系统升级。包装不像零售版精美，通常只有一面CD和说明书(授权* 书)。 
* RVL：号称是正式版，其实RVL根本不是版本的名称。它是中文版/英文版文档破解出来的。 
* EVAL：而流通在网络上的EVAL版，与“评估版”类似，功能上和零售版没有区别。 
* RTL：Retail(零售版)是真正的正式版，正式上架零售版。在安装盘的i386文件夹里有一个eula.txt，最后有一行EULAID，就是你的版本。比如简体中文正式版是EULAID:WX.4_PRO_RTL_CN，繁体中文正式版是WX.4_PRO_RTL_TW。其中：如果是WX.开头是正式版，WB.开头是测试版。_PRE，代表家庭版；_PRO，代表专业版。

α、β、λ常用来表示软件测试过程中的三个阶段：

* α是第一阶段，一般只供内部测试使用；
* β是第二个阶段，已经消除了软件中大部分的不完善之处，但仍有可能还存在缺陷和漏洞，一般只提供给特定的用户群来测试使用；
* λ是第三个阶段，此时产品已经相当成熟，只需在个别地方再做进一步的优化处理即可上市发行。

Refs:

* [Alpha、Beta、RC、GA版本的区别](http://www.blogjava.net/RomulusW/archive/2008/05/04/197985.html)

### [变更日志](changelog.md) [keepachangelog](https://keepachangelog.com/zh-CN/1.0.0/)

格式

```md
## YYYY-MM-DD hh:mm, Version x.y.z, @提交人

### Notable changes

* 功能模块: 修复XXX问题，@提交人
* 功能模块: 增加xxx功能，@提交人
* 功能模块: 优化xxx功能，@提交人
* 功能模块: 废弃xxx接口，@提交人
* 功能模块: 变更xxx接口，@提交人
* ...
```

Example

```md
## 2016-08-26, Version 6.5.0 (Current), @evanlucas

### Notable changes

* **buffer**: Fix regression introduced in v6.4.0 that prevented .write() at buffer end (Anna Henningsen) [#8154](https://github.com/nodejs/node/pull/8154)
* **deps**: update V8 to 5.1.281.75 (Ali Ijaz Sheikh) [#8054](https://github.com/nodejs/node/pull/8054)
* **inspector**:
  * fix inspector hang while disconnecting (Aleksei Koziatinskii) [#8021](https://github.com/nodejs/node/pull/8021)
  * add support for uncaught exception (Aleksei Koziatinskii) [#8043](https://github.com/nodejs/node/pull/8043)
* **repl**: Fix saving editor mode text in `.save` (Prince J Wesley) [#8145](https://github.com/nodejs/node/pull/8145)
* ***Revert*** "**repl,util**: insert carriage returns in output" (Evan Lucas) [#8143](https://github.com/nodejs/node/pull/8143)

### Commits

* [[`5bc311909f`](https://github.com/nodejs/node/commit/5bc311909f)] - **assert**: remove code that is never reached (Rich Trott) [#8132](https://github.com/nodejs/node/pull/8132)
* [[`e371545dfe`](https://github.com/nodejs/node/commit/e371545dfe)] - **buffer**: allow .write() offset to be at buffer end (Anna Henningsen) [#8154](https://github.com/nodejs/node/pull/8154)
* [[`dcd065522e`](https://github.com/nodejs/node/commit/dcd065522e)] - **(SEMVER-MINOR)** **build**: don't include V8 from node.gyp (Michaël Zasso) [#7016](https://github.com/nodejs/node/pull/7016)
* [[`92ecbc4edc`](https://github.com/nodejs/node/commit/92ecbc4edc)] - **build**: cherry pick V8 change for windows DLL support (Stefan Budeanu) [#8084](https://github.com/nodejs/node/pull/8084)


## 2016-08-15, Version 6.4.0 (Current), @cjihrig

### Notable changes

* **build**: zlib symbols and additional OpenSSL symbols are now exposed on Windows platforms. (Alex Hultman) [#7983](https://github.com/nodejs/node/pull/7983) and [#7576](https://github.com/nodejs/node/pull/7576)
* **child_process**, **cluster**: Forked child processes and cluster workers now support stdio configuration. (Colin Ihrig) [#7811](https://github.com/nodejs/node/pull/7811) and [#7838](https://github.com/nodejs/node/pull/7838)
* **child_process**: `argv[0]` can now be set to arbitrary values in spawned processes. (Pat Pannuto) [#7696](https://github.com/nodejs/node/pull/7696)
* **fs**: `fs.ReadStream` now exposes the number of bytes it has read so far. (Linus Unnebäck) [#7942](https://github.com/nodejs/node/pull/7942)
* **repl**: The REPL now supports editor mode. (Prince J Wesley) [#7275](https://github.com/nodejs/node/pull/7275)
* **util**: `inspect()` can now be configured globally using `util.inspect.defaultOptions`. (Roman Reiss) [#8013](https://github.com/nodejs/node/pull/8013)

### Commits

* [[`06a0a053ea`](https://github.com/nodejs/node/commit/06a0a053ea)] - 2016-08-15, Version 6.4.0 (Current) (cjihrig) [#8070](https://github.com/nodejs/node/pull/8070)
* [[`342a85b1a7`](https://github.com/nodejs/node/commit/342a85b1a7)] - Working on v6.3.2 (Evan Lucas) [#7782](https://github.com/nodejs/node/pull/7782)
* [[`f135a4c3d1`](https://github.com/nodejs/node/commit/f135a4c3d1)] - 2016-07-21, Version 6.3.1 (Current) (Evan Lucas) [#7782](https://github.com/nodejs/node/pull/7782)
```
