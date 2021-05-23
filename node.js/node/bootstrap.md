# Node.js Bootstrap

Node.js 启动过程概述

Node.js 启动之后开始进行一系列的初始化工作，Node.js 为用户提供了 JavaScript 运行时，那么初始化的的过程就是为了给用户构造出一套 Node.js 的运行环境，让用户可以在 JavaScript 代码中可以引入相关模块并能够进行调用。那么在整个初始化的过程中的主要工作如：1. 提供一套模块加载机制可以加载系统或第三方模块，2. 实现各个系统模块。

V8 官方代码示例：https://chromium.googlesource.com/v8/v8/+/branch-heads/6.8/samples/hello-world.cc

```c++
// Copyright 2015 the V8 project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "include/libplatform/libplatform.h"
#include "include/v8.h"
int main(int argc, char* argv[]) {
  // Initialize V8.
  v8::V8::InitializeICUDefaultLocation(argv[0]);
  v8::V8::InitializeExternalStartupData(argv[0]);
  std::unique_ptr<v8::Platform> platform = v8::platform::NewDefaultPlatform();
  v8::V8::InitializePlatform(platform.get());
  v8::V8::Initialize();
  // Create a new Isolate and make it the current one.
  v8::Isolate::CreateParams create_params;
  create_params.array_buffer_allocator =
      v8::ArrayBuffer::Allocator::NewDefaultAllocator();
  v8::Isolate* isolate = v8::Isolate::New(create_params);
  {
    v8::Isolate::Scope isolate_scope(isolate);
    // Create a stack-allocated handle scope.
    v8::HandleScope handle_scope(isolate);
    // Create a new context.
    v8::Local<v8::Context> context = v8::Context::New(isolate);
    // Enter the context for compiling and running the hello world script.
    v8::Context::Scope context_scope(context);
    // Create a string containing the JavaScript source code.
    v8::Local<v8::String> source =
        v8::String::NewFromUtf8(isolate, "'Hello' + ', World!'",
                                v8::NewStringType::kNormal)
            .ToLocalChecked();
    // Compile the source code.
    v8::Local<v8::Script> script =
        v8::Script::Compile(context, source).ToLocalChecked();
    // Run the script to get the result.
    v8::Local<v8::Value> result = script->Run(context).ToLocalChecked();
    // Convert the result to an UTF8 string and print it.
    v8::String::Utf8Value utf8(isolate, result);
    printf("%s\n", *utf8);
  }
  // Dispose the isolate and tear down V8.
  isolate->Dispose();
  v8::V8::Dispose();
  v8::V8::ShutdownPlatform();
  delete create_params.array_buffer_allocator;
  return 0;
}
```

Node.js 的初始化过程就是将以上的简单的初始化改造成更复杂的过程。核心是提供一个 Node.js 环境下的 执行上下文 `context: v8::Context` 的过程。

## 初始化

跳过 `HAVE_INSPECTOR` 片段

NODE_SHARED_MODE
[build: introduce configure --shared #6994](https://github.com/nodejs/node/pull/6994)

### 进程初始化 InitializeOncePerProcess

[Linux TTY/PTS概述](https://segmentfault.com/a/1190000009082089)
[Linux 终端(TTY)](https://www.cnblogs.com/sparkdev/p/11460821.html)
[Linux 伪终端(pty)](https://www.cnblogs.com/sparkdev/p/11605804.html)
[关于Unix/Linux的终端、伪终端、控制台和Shell](https://www.linuxidc.com/Linux/2017-10/147315.htm)
[[Linux]终端设备关系](https://www.cnblogs.com/yiyide266/p/11601036.html)
* https://en.wikipedia.org/wiki/Computer_terminal
* https://unix.stackexchange.com/questions/4126/what-is-the-exact-difference-between-a-terminal-a-shell-a-tty-and-a-con
* https://tldp.org/HOWTO/Text-Terminal-HOWTO.html

初始化 `per_process` 命名空间

1. `PlatformInit`

  对进程的运行环境进行初始化，信号、标准输入输出、系统限制等

2. `uv_setup_args`

  命令行参数解析

3. `InitializeNodeWithArgs`

  * `binding::RegisterBuiltinModules()` 注册内建的模块
  * `HandleEnvOptions` 处理环境变量中的选项
  * `NODE_OPTIONS` 处理
  * `ProcessGlobalArgs` 处理全局参数
  * `uv_set_process_title` 设置进程标题
  * `NativeModuleEnv::InitializeCodeCache()`

4. `V8::Initialize()`
