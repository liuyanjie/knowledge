# Node Source Code

## Node启动过程

src/node.cc

Start
  1. PlatformInit 检查输入输出，调整资源现状，注册新号处理函数
  2. uv_setup_args 设置参数
  3. InitializeNodeWithArgs 使用参数初始化Node
     1. binding::RegisterBuiltinModules() 注册内建模块，内建模块在此步骤注册，可展开讨论
     2. ProcessGlobalArgs 处理全局命令行参数，兼容不同系统平台main参数不一致的情况
     3. uv_set_process_title 设置进程标题
  4. InitializeV8Platform
  5. V8::Initialize
  6. StartNodeWithLoopAndArgs 启动Node.js，启动事件循环
     1. NewIsolate 创建VM隔离环境
     2. CreateIsolateData 创建VM数据
     3. StartNodeWithIsolate(isolate, isolate_data.get(), args, exec_args) 通过1，2步骤的数据启动Node
        1. NewContext(isolate)
           1. Call internal/per_context/setup
           2. Call internal/per_context/domexception
        2. Environment env
        3. env.InitializeLibuv 
           1. 在事件循环的prepare、idle、check阶段设置勾子函数，触发Profiler
           2. 注册Environment::CheckImmediate
              1. 清理native_immediate_callbacks_
           3. 安装thread_stopper()->Install()
           4. StartProfilerIdleNotifier
           5. RegisterHandleCleanups
        4. env.ProcessCliArgs
           1. CreateProcessObject
              1. Local<FunctionTemplate> process_template = FunctionTemplate::New(isolate)
              2. process = process_ctor.NewInstance(context)
              3. set process.<name>
           2. set_process_object
        5. env.inspector_agent()->Start()
        6. env.async_hooks()->push_async_ids(1, 0)
        7. LoadEnvironment(&env)  加载运行环境，执行各个初始化JS脚本
           1. RunBootstrapping 运行引导脚本
              1. ExecuteBootstrapper(env, "internal/bootstrap/primordials")
              2. ExecuteBootstrapper(env, "internal/bootstrap/loaders")
              3. ExecuteBootstrapper(env, "internal/bootstrap/node")
           2. StartMainThreadExecution(env) 启动主线程特定脚本
              1. StartExecution(env, "internal/main/run_main_module") 执行脚本
                 1. ExecuteBootstrapper(env, main_script_id)
                    1. LookupAndCompile(env->context(), id, parameters, env)
                    2. fn->Call()
        8. env.async_hooks()->pop_async_id(1)
        9. env.performance_state()->Mark(node::performance::NODE_PERFORMANCE_MILESTONE_LOOP_START)
        10. uv_run(env.event_loop(), UV_RUN_DEFAULT)
        11. per_process::v8_platform.DrainVMTasks(isolate)
        12. RunBeforeExit(&env)
            1.  RunBeforeExitCallbacks
                1.  before_exit.cb_
            2.  EmitBeforeExit 发送beforeExit到JS层
                1.  ProcessEmit(env, "beforeExit", exit_code).ToLocalChecked()
        13. env.set_can_call_into_js(false)
        14. env.stop_sub_worker_contexts()
        15. uv_tty_reset_mode()
        16. env.RunCleanup()
        17. env.performance_state()->Mark(node::performance::NODE_PERFORMANCE_MILESTONE_LOOP_EXIT)
        18. EmitExit
            1.  ProcessEmit(env, "exit", exit_code).ToLocalChecked()
        19. WaitForInspectorDisconnect
        20. RunCleanup
            1.  thread_stopper()->Uninstall()
            2.  CleanupHandles()
        21. RunAtExit
            1.  RunAtExitCallbacks
  7. V8::Dispose()
  8. per_process::v8_platform.Dispose()
  9. Exit


ExecuteBootstrapper
  1. maybe_fn = per_process::native_module_loader.LookupAndCompile
     1. const auto source_it = source_.find(id)
     2. 
  2. fn = maybe_fn.ToLocalChecked()
  3. fn->Call

1. 启动过程
2. 原生模块是怎么加载的

原生模块注册：

```c
NODE_MODULE_CONTEXT_AWARE_INTERNAL(async_wrap, node::AsyncWrap::Initialize)
```

https://github.com/nodejs/node/blob/master/src/node_binding.h#L49

```c
#define NODE_MODULE_CONTEXT_AWARE_INTERNAL(modname, regfunc)                   \
  NODE_MODULE_CONTEXT_AWARE_CPP(modname, regfunc, nullptr, NM_F_INTERNAL)
```

https://github.com/nodejs/node/blob/master/src/node_binding.h#L29

```c
#define NODE_MODULE_CONTEXT_AWARE_CPP(modname, regfunc, priv, flags)           \
  static node::node_module _module = {                                         \
      NODE_MODULE_VERSION,                                                     \
      flags,                                                                   \
      nullptr,                                                                 \
      __FILE__,                                                                \
      nullptr,                                                                 \
      (node::addon_context_register_func)(regfunc),                            \
      NODE_STRINGIFY(modname),                                                 \
      priv,                                                                    \
      nullptr};                                                                \
  void _register_##modname() { node_module_register(&_module); }
```

https://github.com/nodejs/node/blob/master/src/node_binding.cc#L251

```c
extern "C" void node_module_register(void* m) {
  struct node_module* mp = reinterpret_cast<struct node_module*>(m);

  if (mp->nm_flags & NM_F_INTERNAL) {
    mp->nm_link = modlist_internal;
    modlist_internal = mp;
  } else if (!node_is_initialized) {
    // "Linked" modules are included as part of the node project.
    // Like builtins they are registered *before* node::Init runs.
    mp->nm_flags = NM_F_LINKED;
    mp->nm_link = modlist_linked;
    modlist_linked = mp;
  } else {
    uv_key_set(&thread_local_modpending, mp);
  }
}
```


MemoryRetainer
  BaseObject
    V8ProfilerConnection
    ModuleWrap
    ContextifyScript
    
    SecureContext
    KeyObject
    CipherBase
    Hmac
    Hash
    SignBase
    DiffieHellman
    ECDH

    ConverterObject
    ELDHistogram

    SerializerContext
    DeserializerContext

    NodeCategorySet

    WeakReference
    SABLifetimePartner

FIXED_ONE_BYTE_STRING

https://github.com/nodejs/node/blob/master/src/util.h#L259

```c++
// Used to be a macro, hence the uppercase name.
template <int N>
inline v8::Local<v8::String> FIXED_ONE_BYTE_STRING(
    v8::Isolate* isolate,
    const char(&data)[N]) {
  return OneByteString(isolate, data, N - 1);
}

template <std::size_t N>
inline v8::Local<v8::String> FIXED_ONE_BYTE_STRING(
    v8::Isolate* isolate,
    const std::array<char, N>& arr) {
  return OneByteString(isolate, arr.data(), N - 1);
}
```

https://github.com/nodejs/node/blob/master/src/util-inl.h#L167

```c++
inline v8::Local<v8::String> OneByteString(v8::Isolate* isolate,
                                           const char* data,
                                           int length) {
  return v8::String::NewFromOneByte(isolate,
                                    reinterpret_cast<const uint8_t*>(data),
                                    v8::NewStringType::kNormal,
                                    length).ToLocalChecked();
}

inline v8::Local<v8::String> OneByteString(v8::Isolate* isolate,
                                           const signed char* data,
                                           int length) {
  return v8::String::NewFromOneByte(isolate,
                                    reinterpret_cast<const uint8_t*>(data),
                                    v8::NewStringType::kNormal,
                                    length).ToLocalChecked();
}

inline v8::Local<v8::String> OneByteString(v8::Isolate* isolate,
                                           const unsigned char* data,
                                           int length) {
  return v8::String::NewFromOneByte(
             isolate, data, v8::NewStringType::kNormal, length)
      .ToLocalChecked();
}
```


## Node.js Startup

1. 进程启动

PlatformInit 进行平台相关的初始化设置、信号处理器设置、Hooks设置

InitializeNodeWithArgs
