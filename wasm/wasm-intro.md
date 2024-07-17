# WASM简介

+ WASM 介绍
+ WASM 工作原理
+ WASM 应用场景



##  WASM 介绍

Wasm（WebAssembly ）是一种可移植**字节码规范**。它描述了如何构建可执行程序并在兼容的 **Wasm 运行时**中执行。

从某种意义上说，ARM 和 x86 同样是字节码规范。它们通常在真实 CPU 上运行。但也可以运行在一些模拟器和虚拟机上。对于 Wasm，没有物理机器可以执行它。它必须始终翻译成 CPU 的本机语言才能执行。

事实上，Wasm 在许多环境中都有使用，从**浏览器**到**云数据中心**，再到**嵌入式系统**，甚至**区块链**。它们都使用 Wasm 作为沙盒执行环境。

WASM 也是一种跨语言、跨平台方案。比如使用 WASM 可以将前端一些对性能要求比较高的代码使用 Rust 重构，并打包成 WASM 模块给 JS 调用。

> 工作原理感觉和 Java 的 JVM 很相似，比如 JVM 也提供了字节码规范、有自己的运行时环境，支持跨语言（仅几种语言）、跨平台。
>
> 区别可能是WASM是全静态的，JVM是半编译半解释的；WASM支持更多种平台比如可以运行在浏览器虚拟机中，更轻量高效。

**关于 WASM 取代 Docker**：

准确地说应该是可以使用 [WasmEdge](https://github.com/WasmEdge/WasmEdge)、[Wasmtime](https://github.com/bytecodealliance/wasmtime) 等 **WASM 运行时**替代 Docker 默认的 **Linux 容器运行时**。并不是说 Docker 的工具都不用了。关于运行时参考后面的参考文档。

WASM 运行时使用系统资源依赖 **WASI** (WebAssembly System Interface)， WASI 怎么支持不同机器架构的？

> 根据浏览到的信息推测是 WASI 制定一套规范，各种环境通过 WASI 的规范提供系统调用实现。

可以参考这篇文章对比分别使用WASM运行时以及Docker默认的Linux容器运行时打包镜像部署容器的区别： [Docker+WebAssembly 快速介绍](https://cloudnative.to/blog/docker-wasm-quick-intro/)。

**当前支持 WASM 规范的一些语言**：

- C/C++
  - [starting from scratch](https://developer.mozilla.org/en-US/docs/WebAssembly/C_to_wasm)
  - [library that I want to port to the Web](https://developer.mozilla.org/en-US/docs/WebAssembly/existing_C_to_wasm)
- [Rust](https://developer.mozilla.org/en-US/docs/WebAssembly/Rust_to_wasm)
- [AssemblyScript (a TypeScript-like syntax)](https://assemblyscript.org/introduction.html)
- [C#](https://learn.microsoft.com/en-us/aspnet/core/blazor/tutorials/?view=aspnetcore-7.0&preserve-view=true)
- Dart
  - [Via Flutter](https://flutter.dev/wasm) (preview)
- [F#](https://fsbolero.io/docs/)
- Go
  - [with full language support](https://github.com/golang/go/wiki/WebAssembly#getting-started)
  - [targeting minimal size](https://tinygo.org/docs/guides/webassembly/)
- [Kotlin](https://kotl.in/wasm)
- [Swift](https://swiftwasm.org/)
- [D](https://wiki.dlang.org/Generating_WebAssembly_with_LDC)
- [Pascal](https://wiki.freepascal.org/WebAssembly/Compiler)
- [Zig](https://ziglang.org/documentation/master/#WebAssembly)
- [Grain](https://grain-lang.org/docs/)

**WASM 特点**：

+ VM 机器码
+ 静态语言
+ 编译器（有编译优化）
+ NO GC （运行效率会比较高）

**WASM 优势**：

+ 代码尺寸小
+ 安全
+ 高效
+ 跨平台、跨架构
+ 混合编程、交叉编译
+ 大量现成的代码库
+ 边缘计算
+ AI



## WASM 工作原理

后端服务器上使用 WASM 沙箱运行 Rust 代码（也支持其他语言）的4种方式。

- [服务器上的纯 Wasm](https://www.jakobmeier.ch/wasm-road-2#pure-wasm-on-the-server)
- [服务器上的 WASI](https://www.jakobmeier.ch/wasm-road-2#wasi-on-the-server)
- [服务器上的 Wasm 框架](https://www.jakobmeier.ch/wasm-road-2#wasm-frameworks-on-the-server)
- [Wasm 的 Docker 集成](https://www.jakobmeier.ch/wasm-road-2#docker-integration-of-wasm)

TODO



## WASM 应用场景

+ 应用向浏览器端迁移
+ 服务器端



## 参考

+ https://www.jakobmeier.ch/wasm-road-overview

+ [为什么 Docker 要增加 WebAssembly 运行时](https://jimmysong.io/blog/why-docker-support-wasm/)

+ [Docker+WebAssembly 快速介绍](https://cloudnative.to/blog/docker-wasm-quick-intro/)

  对比分别使用WASM运行时以及Docker默认的Linux容器运行时打包镜像部署容器的区别。

+ [Wasm workloads (Beta)](https://docs.docker.com/desktop/wasm/)

  基于 Wasm 运行时的 Docker 容器使用。

+ [Docker，containerd，CRI，CRI-O，OCI，runc 分不清？看这一篇就够了](https://zhuanlan.zhihu.com/p/490585683)

+ [关于 WebAssembly，我们需要知道的事](https://morven.life/posts/knowledge-about-wasm/)