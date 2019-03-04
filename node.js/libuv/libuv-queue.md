# libuv-queue

https://github.com/libuv/libuv/blob/v1.x/src/queue.h#L2

在libuv中，有一个只有100行左右的纯宏实现的高效的队列，现在我们来分析下这个队列是什么实现的

首先，来看以下队列节点定义

https://github.com/libuv/libuv/blob/v1.x/src/queue.h#L20

```c
typedef void *QUEUE[2];

/* Private macros. */
#define QUEUE_NEXT(q)       (*(QUEUE **) &((*(q))[0]))
#define QUEUE_PREV(q)       (*(QUEUE **) &((*(q))[1]))
#define QUEUE_PREV_NEXT(q)  (QUEUE_NEXT(QUEUE_PREV(q)))
#define QUEUE_NEXT_PREV(q)  (QUEUE_PREV(QUEUE_NEXT(q)))

/* Public macros. */
#define QUEUE_DATA(ptr, type, field)                                          \
  ((type *) ((char *) (ptr) - offsetof(type, field)))
```

首先，QUEUE 被声明为一个具备两个元素的数组，每个数组元素都是指针且指向了 `void`。

这种方式的声明与我们平常实现的队列结构的声明似乎不太一样，通常实现的队列节点如下，具有指向兄弟节点的指针和一个数据域，而以上节点定义完全没有。

继续向下看可以看到 `QUEUE_NEXT(q)` `QUEUE_PREV(q)`  两个宏，通过名字可以猜到，这两个宏用于访问兄弟节点。

接下来，分析一下这两个宏，

首先看一下这两个宏是怎么使用的

```c
static QUEUE queue;
QUEUE_NEXT(&queue);
QUEUE_PREV(&queue);
```

可以看到，传递给宏的值是取了地址的，实际上是

```
QUEUE_NEXT(&queue) -> (*(QUEUE **) &((*(&queue))[0])) -> (*(QUEUE **) &queue[0]) -> queue[0]
QUEUE_PREV(&queue) -> (*(QUEUE **) &((*(&queue))[1])) -> (*(QUEUE **) &queue[1]) -> queue[1]
```

因为 QUEUE 的 每个元素都是 `void*` 类型，所以 `&queue[0]` 为 `void**` 二级指针，然后强制类型转换 `QUEUE **` 二级指针，之后再用 `*` 解引用，所以最后还是 `queue[0]`，但是被强转为 `QUEUE *` 类型指针了，指向队列的下一个节点，同理，`queue[1]` 指向队列的上一个节点。

这样，我找到了其用数组的两个两个元素分别存储前后兄弟节点的指针（地址）。

接下来，看下队列的初始化：

```c
#define QUEUE_INIT(q)                                                         \
  do {                                                                        \
    QUEUE_NEXT(q) = (q);                                                      \
    QUEUE_PREV(q) = (q);                                                      \
  }                                                                           \
  while (0)
```

将 next 和 prev 指向其自己

判断队列是否为空，初始状态的队列是空队列，所以 判断 next 是否指向自身即可

```c
#define QUEUE_EMPTY(q)                                                        \
  ((const QUEUE *) (q) == (const QUEUE *) QUEUE_NEXT(q))
```

获取队列的头结点：

```c
#define QUEUE_HEAD(q)                                                         \
  (QUEUE_NEXT(q))
```

通过代码可以看到，队列的头结点并不是`q`本身，实际而是`q`的下一个节点

### QUEUE_ADD

队列相加实现将队列n，接到队列h的尾部，与通常的在队列尾部增加一个节点不同：

```c
#define QUEUE_ADD(h, n)                                                       \
  do {                                                                        \
    QUEUE_PREV_NEXT(h) = QUEUE_NEXT(n);                                       \
    QUEUE_NEXT_PREV(n) = QUEUE_PREV(h);                                       \
    QUEUE_PREV(h) = QUEUE_PREV(n);                                            \
    QUEUE_PREV_NEXT(h) = (h);                                                 \
  }                                                                           \
  while (0)
```

### QUEUE_SPLIT

队列切分是队列相加的逆操作，将队列h以q节点进行分割，分割出的新队列接到n上

```c
#define QUEUE_SPLIT(h, q, n)                                                  \
  do {                                                                        \
    QUEUE_PREV(n) = QUEUE_PREV(h);                                            \
    QUEUE_PREV_NEXT(n) = (n);                                                 \
    QUEUE_NEXT(n) = (q);                                                      \
    QUEUE_PREV(h) = QUEUE_PREV(q);                                            \
    QUEUE_PREV_NEXT(h) = (h);                                                 \
    QUEUE_PREV(q) = (n);                                                      \
  }                                                                           \
  while (0)
```

### QUEUE_MOVE

将队列h移动到队列n上

```c
#define QUEUE_MOVE(h, n)                                                      \
  do {                                                                        \
    if (QUEUE_EMPTY(h))                                                       \
      QUEUE_INIT(n);                                                          \
    else {                                                                    \
      QUEUE* q = QUEUE_HEAD(h);                                               \
      QUEUE_SPLIT(h, q, n);                                                   \
    }                                                                         \
  }                                                                           \
  while (0)
```

### QUEUE_INSERT

在队列h的头部或尾部插入队列q

```c
#define QUEUE_INSERT_HEAD(h, q)                                               \
  do {                                                                        \
    QUEUE_NEXT(q) = QUEUE_NEXT(h);                                            \
    QUEUE_PREV(q) = (h);                                                      \
    QUEUE_NEXT_PREV(q) = (q);                                                 \
    QUEUE_NEXT(h) = (q);                                                      \
  }                                                                           \
  while (0)

#define QUEUE_INSERT_TAIL(h, q)                                               \
  do {                                                                        \
    QUEUE_NEXT(q) = (h);                                                      \
    QUEUE_PREV(q) = QUEUE_PREV(h);                                            \
    QUEUE_PREV_NEXT(q) = (q);                                                 \
    QUEUE_PREV(h) = (q);                                                      \
  }                                                                           \
  while (0)
```

### QUEUE_REMOVE

将队列节点q从队列中移除

```c
#define QUEUE_REMOVE(q)                                                       \
  do {                                                                        \
    QUEUE_PREV_NEXT(q) = QUEUE_NEXT(q);                                       \
    QUEUE_NEXT_PREV(q) = QUEUE_PREV(q);                                       \
  }                                                                           \
  while (0)
```

### QUEUE_DATA

通过 `QUEUE_DATA` 宏，可以获取到队列节点数据，接下来我们来看一下数据是怎么存取的。

上文也提到过，队列节点中并没有常规实现的节点中定义的数据字段，通常的队列实现，是将数据节点嵌入队列节点中的，但是该队列的实现是将队列节点嵌入到数据当中去的。

我们以 `uv_handle_s` 为例子，什么是 `将队列节点嵌入到数据当中去`，如下 `uv_handle_s` 定义：

```c
#define UV_HANDLE_FIELDS                                                      \
  /* public */                                                                \
  void* data;                                                                 \
  /* read-only */                                                             \
  uv_loop_t* loop;                                                            \
  uv_handle_type type;                                                        \
  /* private */                                                               \
  void* handle_queue[2];                                                      \

struct uv_handle_s {
  UV_HANDLE_FIELDS
};
```

其中，`handle_queue` 就是队列节点，可以通过强制类型转换转换为 `QUEUE` 类型，而在已知队列节点的情况下，获取完整的数据节点是我们需要实现的。

在传统的队列实现中，我们已知整个队列节点，获取某一数据字段是非常容易的。

当前的情况如下：

* `handle_queue` 作为队列节点，其地址是已知的。创建节点时，节点是已知的，遍历队列时，节点同样是已知的。
* `uv_handle_s` 类型的某一数据，数据起始地址是未知的。

当前的目标是：获取到数据节点首地址。即，已知 `handle_queue` 地址，计算 `uv_handle_s` 类型数据的首地址。


`QUEUE_DATA` 的具体实现：

```c
#define QUEUE_DATA(ptr, type, field)                                          \
  ((type *) ((char *) (ptr) - offsetof(type, field)))
```

同样是一个宏实现，里面涉及到另一个宏 `offsetof`，它可以获取结构体成员`field`在结构体`type`中的偏移量。

offsetof的实现如下：

```c
#define offsetof(type, field) (size_t)&(((type *)0)->field)
```

* `((type *)0)`  将首地址为0的一段内存强制"转换"为type结构类型的指针；
* `(size_t)&(((type *)0)->field)` 取`field`成员字段地址并转换为`size_t`类型，因为首地址为`0`，所以`offsetof`可以获取到实际的字段偏移地址；

有了某字段的偏移量和某字段的地址，因为 `首地址+某字段的偏移量=某字段的地址`，所以 `首地址=某字段的地址-某字段的偏移量`，也就是 `QUEUE_DATA` 宏的实现。
