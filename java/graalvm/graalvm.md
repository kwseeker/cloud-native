# GraalVM

TODO:

+ 测试基本使用
+ 测试性能并对比
+ 测试Native-Image Java动态特性的损失
+ 测试多语言支持



## 概述

GraalVM 基于 HotSpot，提供了一个 Java开发的可将字节码转换为机器码的动态即时（JIT）编译器（Graal Compiler），可以通过 Java9 之后提供的 JVMCI 接口集成到 HotSpot；

GraalVM 默认使用G1垃圾收集器。

GRAAL编译器通过独特的代码分析和优化方法为在JVM上运行的程序提供了更优的性能：[Compiler Advantages](https://www.graalvm.org/latest/reference-manual/java/compiler/#compiler-advantages) （介绍了一些优化算法）。

GraalVM 使用图 （graph）作为非基于 JVM 的语言和机器码的中间表示（IR），可以做语言无关的优化。

GraalVM还包含了Truffle语言实现框架，一个用Java编写的库，用于构建编程语言的解释器，然后在GraalVM上运行。

还提供了AOT编译技术Native Image，该技术可将基于Java和jvm的代码转换为本机平台可执行文件。

如果 GraalVM 编译器产生未捕获异常，可以通过 `-Dgraal.CompilationFailureAction=Diagnose` 输出诊断数据。

GraalVM 通用选项与性能调优选项：[Compiler Configuration on JVM](https://www.graalvm.org/latest/reference-manual/java/options/)。

GraalVM 提供了 Docker 镜像，可以用于作为基础镜像。

**GraalVM 优缺点**：

**优点**：

+ 编译成的二进制文件更小（native-image）
+ 启动速度快100（native-image）
+ 占用更少的内存和CPU（native-image）
+ 更好的性能可预测性（native-image）
+ 更好的代码隐藏（native-image）
+ 多语言编程（JIT Compiler）

> GraalVM native-image 功能在前端编译期间直接将Java代码编译成机器码（传统Java编译器分为前端编译器（前端编译）和运行期编译器（后端编译））；
>
> 但是并不是说GraalVM只能静态编译，还提供了JIT编译器（对标HotspotVM 的 JIT编译器 C1/C2），可以替换掉 Hotspot 虚拟机的JIT编译器（归功于  Java 9 提供的 JVMCI 接口（Jvm Compiler Interface））。

**缺点**：

+ 构建时间较长

+ 一些动态性的损失

  动态性的支持需要配置，具体怎么配置后面研究。


### 安装 GraalVM

[Installation on Linux Platforms](https://www.graalvm.org/latest/docs/getting-started/linux/)

### GraalVM 运行程序

官方测试DEMO: [graalvm-demos](https://github.com/graalvm/graalvm-demos)

#### 使用Maven插件打包成 Native Image

插件： [native-maven-plugin](https://graalvm.github.io/native-build-tools/latest/maven-plugin.html)

```shell
# 打包成Native Image的配置在native profile中
mvn -Pnative package
```

> TODO:
>
> 命令行打包 Native Image 成功，IDEA中打包报找不到环境变量 GRAALVM_HOME，暂不清楚什么原因：
>
> GraalVM native-image is missing on your system. 
> Make sure that GRAALVM_HOME environment variable is present.



## Native Image

Native Image 是一种将Java代码预编译成二进制的原生可执行文件的技术。原生可执行文件只包括运行时所需的代码，即来自JDK的应用程序类、标准库类、语言运行时和静态链接的原生代码。

native-image 工具支持从 .class 文件、Jar 文件、Java Module 生成原生的二进制可执行文件。

native-image 编译选项：[Native Image Build Configuration](https://www.graalvm.org/latest/reference-manual/native-image/overview/BuildConfiguration/)

### native-image 参数

+ `--help`

+ `--initialize-at-build-time=<class>`

  对指定的类在编译期进行初始化。

### 镜像堆（Image Heap）

镜像堆包含：包含：

- Objects created during the image build that are reachable from application code.
- `java.lang.Class` objects of classes used in the native image.
- Object constants [embedded in method code](https://www.graalvm.org/latest/reference-manual/native-image/metadata/#computing-metadata-in-code).

###  静态分析

静态分析是确定应用程序使用哪些程序元素（类、方法和字段）的过程。

+ 扫描方法的字节码以确定可以从该方法访问哪些其他元素。 
+ 扫描镜像堆中的根对象（即静态字段）以确定可以从它们访问哪些类。它从应用程序的入口点（即 main 方法）开始。迭代扫描新发现的元素，直到进一步扫描不会对元素的可达性产生额外的变化。

### [可达性元数据](https://www.graalvm.org/latest/reference-manual/native-image/metadata/)

作为静态分析的补充。通过向 Native Image 生成器提供可达性元数据，确保无法被静态分析预测的程序元素（比如一些动态语言功能：反射、资源处理）也被添加到 Native Image。

元数据可以通过以下方式提供给本地镜像构建器：

+ 通过在构建本机二进制文件时计算代码中的元数据并将所需元素存储到本机二进制文件的初始堆中。 
+ 通过提供存储在 `META-INF/native-image/<group.id>/<artifact.id>` 项目目录中的 JSON 文件。

### 性能优化

对二进制可执行文件做性能优化：

+ 配置文件引导优化 (PGO) 可以为大多数本机映像提供额外的性能增益和更高的吞吐量。请参阅 [Optimize a Native Executable with PGO](https://www.graalvm.org/latest/reference-manual/native-image/guides/optimize-native-executable-with-pgo/).。 
+ 选择合适的垃圾收集器并定制垃圾收集策略可以减少 GC 时间。请参阅  [Memory Management](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/MemoryManagement/).。 
+ 在映像构建期间加载应用程序配置可以加快应用程序启动速度。请参阅  [Class Initialization at Image Build Time](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/ClassInitialization/).。

### 调试和诊断

Native Image 提供的用于调试和检查生成的二进制文件的实用工具：

- For debugging produced binaries and obtaining performance profile statistics, see [Debug Information](https://www.graalvm.org/latest/reference-manual/native-image/debugging-and-diagnostics/DebugInfo/)
- For generating heap dumps, see [Heap Dump Support](https://www.graalvm.org/latest/reference-manual/native-image/guides/create-heap-dump/)
- For JFR events recording, see [JDK Flight Recorder (JFR)](https://www.graalvm.org/latest/reference-manual/native-image/debugging-and-diagnostics/JFR/)
- For checking which methods were included in a native executable or a shared library, use the [Inspection Tool](https://www.graalvm.org/latest/reference-manual/native-image/debugging-and-diagnostics/InspectTool/)
- For an overview of static analysis results, see [Static Analysis Reports](https://www.graalvm.org/latest/reference-manual/native-image/debugging-and-diagnostics/StaticAnalysisReports/)

### 对Java动态特性的支持

Native Image 如何实现对 Java 动态特性的支持的？

- [Accessing Resources](https://www.graalvm.org/latest/reference-manual/native-image/dynamic-features/Resources/)
- [Certificate Management](https://www.graalvm.org/latest/reference-manual/native-image/dynamic-features/CertificateManagement/)
- [Dynamic Proxy](https://www.graalvm.org/latest/reference-manual/native-image/dynamic-features/DynamicProxy/)
- [Java Native Interface (JNI)](https://www.graalvm.org/latest/reference-manual/native-image/dynamic-features/JNI/)
- [JCA Security Services](https://www.graalvm.org/latest/reference-manual/native-image/dynamic-features/JCASecurityServices/)
- [Reflection](https://www.graalvm.org/latest/reference-manual/native-image/dynamic-features/Reflection/)
- [URL Protocols](https://www.graalvm.org/latest/reference-manual/native-image/dynamic-features/URLProtocols/)

### 与本地代码的互通

您可以使用本机映像将Java代码转换为**本地共享库**，并像任何C函数一样从本地（C/C ++）应用程序调用它。有两种调用本质编译的Java方法的机制：

- [JNI Invocation API](https://docs.oracle.com/en/java/javase/17/docs/specs/jni/invocation.html), 是将JVM加载到任意原生应用程序的API。使用JNI调用API的优点是在同一个进程中支持多个、隔离的执行环境。
- [Native Image C API](https://www.graalvm.org/latest/reference-manual/native-image/native-code-interoperability/C-API/), Native Image 特定的API, 使用Native Image C API的好处是，你可以决定你的API看起来是什么样子，但是参数和返回类型必须是非对象类型。

### Native Image LLVM 后备

Native Image 提供了一个替代后端，它使用 LLVM 中间表示和 LLVM 编译器来生成本机可执行文件。该 LLVM 后端使用户能够瞄准 GraalVM Native Image 不直接支持的替代架构。然而，这种方法会带来一些性能成本。



## GraalVM 其他技术

### [Graal Compiler](https://www.graalvm.org/reference-manual/java/compiler/)

### [GraalVM Language Runtimes](https://www.graalvm.org/reference-manual/languages/)

### [Embedding Languages in Java](https://www.graalvm.org/reference-manual/embed-languages/)

### [Tools for GraalVM Languages](https://www.graalvm.org/tools/)

### [Polyglot Programming](https://www.graalvm.org/reference-manual/polyglot-programming/)

### [Polyglot Sandbox](https://www.graalvm.org/security-guide/polyglot-sandbox/)

### [Truffle Framework](https://www.graalvm.org/graalvm-as-a-platform/language-implementation-framework/)



## 参考

+ [如何理解Truffle framework与Graal compiler?](https://www.zhihu.com/question/28927570) [圆胖肿的回答]

  

