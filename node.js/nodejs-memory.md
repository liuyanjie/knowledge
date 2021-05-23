# Node.js Memory

## Node.js 12 关于堆内存的改动

相关改动使 Node.js 在容器环境下运行的更好。

* [The Difference Between Node.js 10 LTS and Node.js 12 LTS](https://nodejs.org/tr/blog/uncategorized/10-lts-to-12-lts/) Notable Changes in Node.js 12.7.0
* [Introducing Node.js 12](https://medium.com/@nodejs/introducing-node-js-12-76c41a1b3f3f)

* [src: use cgroups to get memory limits #27508](https://github.com/nodejs/node/pull/27508)
* [src: properly configure default heap limits #25576](https://github.com/nodejs/node/pull/25576)
* [Node 12 dynamic heap size maxes out at 2048MB #28202](https://github.com/nodejs/node/issues/28202)
* [Node 12 uses ~30% extra memory #28205](https://github.com/nodejs/node/issues/28205)

* [ResourceConstraints Class Reference](https://v8docs.nodesource.com/node-14.1/d8/dcd/classv8_1_1_resource_constraints.html)
