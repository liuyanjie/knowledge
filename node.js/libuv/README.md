# libuv源码分析

源码分析主要包含以下内容：

1. [Overview](1-libuv-overview.md)
2. [EventLoop](2-libuv-event-loop.md)
3. [Handle and Requst](3-libuv-handle-and-request.md)
4. [Queue](libuv-queue.md)
5. [Timer](4-libuv-timer.md)
6. [I/O-Watcher](5-libuv-io-watcher.md)
7. [Stream](6-libuv-stream.md)
8. [Async](7-libuv-async.md)
9. [Threadpool](8-libuv-threadpool.md)

需要注意的是，以上内容的编排次序是按照依赖关系编排的，所以按顺序阅读更有助于理解。

例如 Threadpool 依赖 Async，Async 依赖 I/O-Watcher，它们都依赖 EventLoop Handle Request。
