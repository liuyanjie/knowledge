# libuv

## Overview

`libuv` 提供了两个与是时间循环结合使用的抽象：`handles`、`requests`

Handles 表示某些 `长生命周期` 的 `对象`，他们能够在激活状态下执行某些操作。

  * 一个 `prepare handles` 在活动时每次循环迭代都会调用一次回调。
  * 每次有新连接时调用的 `TCP server handle` 都会调用它的连接回调。

  通过以上两个示例可以看出，Handles 在每次事件循环都有机会得到执行。它是长周期的，可能会存在于多次事件循环。

Requests 通常表示 `短生命周期` 的 `操作`，这些操作可以通过句柄执行：`write requests` 用于写数据在 `handle` 上，或者独立的，`getaddrinfo requests` 不需要 `handle` 而是 直接运行在 `event-loop` 上。

