# Maven

看开源项目源码，发现有一些看不懂的Maven配置（主要是插件），之前学的很浅，公司项目maven配置也比较简单，一直没有重视这块；这里重新深入学习一下。

参考：

+ 《Maven 实战》

> Maven是Java开发的开源项目，有时间可以看下源码。



## Maven 组成

### xml文件 & Maven命名空间

这部分写法是固定的，现在都是用的4.0.0版本的命名空间。

### modelVersion

模型版本，Maven2/3都是4.0.0。

### Super POM 

所有POM文件都继承超级POM，位于apache-maven-x.x.x/lib/maven-model-builder-x.x.x.jar 中。

### 坐标 Coordinate

+ groupId

+ artifactId

+ version

+ packaging

  定义打包方式，

  jar: 将项目打包成jar文件，不指定默认就是jar; 

  war; 

  pom: 表示当前项目是多模块结构，也被称为聚合项目，通常由一个父模块和若干个子模块构成。其中，父模块必须以pom打包类型，同时以`<modules>`给出所有的子模块。

+ classifier

  意为分类，作为版本号的补充，如下表示引入 json-lib-2.2.2-jdk15.jar。也有用于区分源码和资源包。

  ```xml
  <dependency>  
      <groupId>net.sf.json-lib</groupId>   
      <artifactId>json-lib</artifactId>   
      <version>2.2.2</version>  
      <classifier>jdk15</classifier>    
  </dependency> 
  ```

### 依赖

```xml
<dependency>
	<groupId>...</groupId>
    <artifactId>...</artifactId>
    <version>...</version>
    <type>...</type>
    <scope>...</scope>
    <optional>...</optional>
    <exclusions>
        <exclusion>...</exclusion>
    </exclusions>
</dependency>
```

#### 依赖类型 type

依赖的类型，对应坐标的 packaging, 默认jar。

#### 依赖范围 scope

+ compile (默认)

  编译依赖范围。Maven 默认的依赖范围，该范围的依赖对编译，运行，测试三种 classpath 都有效。例如我们项目中的 spring-boot-starter；

+ test

  测试依赖范围。该依赖范围只对测试 classpath 有效，在编译项目或者运行项目的时候，是无法使用此类依赖的。例如我们项目中的 spring-boot-starter-test；

+ provided

  已提供依赖范围。该 Maven 依赖对于编译和测试的 classpath 有效，但是在运行时无效；典型的例子是servlet-api，编译和测试项目的时候需要该依赖，但在运行项目的时候，由于容器已经提供，就不需要Maven重复地引入一遍。 

+ runtime

  运行时依赖范围。使用此依赖范围的 Maven依赖，对于测试和运行class-path有效，但 在编译主代码时无效。典型的例子是JDBC驱动实 现，项目主代码的编译只需要JDK提供的JDBC接口，只有在执行测试或者运行项目的时候才需要实 现上述接口的具体JDBC驱动。

+ system

  系统依赖范围。该依赖范围与 classpath 的关系与 provided 依赖范围是相同的。但是，在使用时需要谨慎注意，因为此类依赖大多数是与本机绑定的，而不是通过Maven仓库解析出来的，切换环境后，可能会导致依赖失效或者依赖错误。

#### 依赖传递 & 传递依赖的依赖范围

#### 依赖调解

第一原则：最短路径原则；

第二原则：第一声明者优先。

#### 可选依赖

为什么要使用可选依赖这一特性呢？可能项目B 实现了两个特性，其中的特性一依赖于X，特性二 依赖于Y，而且这两个特性是互斥的，用户不可能 同时使用两个特性。比如B是一个持久层隔离工具 包，它支持多种数据库，包括MySQL、 PostgreSQL等，在构建这个工具包的时候，需要 这两种数据库的驱动程序，但在使用这个工具包的时候，只会依赖一种数据库。

#### 归类依赖

这个名字不恰达，只是将依赖的版本号定义在properties中然后通过$引用。

#### 排除依赖

### 仓库

 #### 仓库布局

即目录布局。

#### 仓库分类

+ 本地仓库

+ 远程仓库

  + 中央仓库

    官方仓库或阿里云镜像仓库等。

  + 私服

    比如个人或公司在局域网搭建的远程仓库。

  + 其他公共仓库。

#### 远程仓库的配置、认证

#### 构件部署到远程仓库

```xml
<distributionManagement>
    <repository>
        <id>proj-releases</id>
        <name>artifact-releases</name>
        <url>https://xxx/content/repositories/proj-releases</url>
    </repository>
    <snapshotRepository>
        <id>proj-snapshots</id>
        <name>artifact-snapshots</name>
        <url>https://xxx/content/repositories/proj-snapshots</url>
    </snapshotRepository>
</distributionManagement>
```

区分发布版本和快照版本的原因，参考《Maven实战》C6.5。主要是快照版本发布到私服时Maven会自动为构件打上时间戳。可以保证依赖快照版本同步开发的其他构件能够获取已发布的最新的快照版本。

默认情况下，Maven每天检查一次更新（由仓库配置的updatePolicy控制），用户也可以使用命令行-U参数强制让 Maven检查更新，如`mvn clean install -U`。

快照版本只应该在组织内部的项目或模块间依 赖使用，因为这时，组织对于这些快照版本的依赖 具有完全的理解及控制权。项目不应该依赖于任何 组织外部的快照版本依赖，由于快照版本的不稳定性，这样的依赖会造成潜在的危险。也就是说，即 使项目构建今天是成功的，由于外部的快照版本依 赖实际对应的构件随时可能变化，项目的构建就可 能由于这些外部的不受控制的因素而失败。

#### 从仓库解析依赖的机制



#### 镜像配置

#### 仓库搜索服务

### 生命周期与插件 (最重要)

Maven的生命周期由一个个步骤（Phase，阶段）组成（和设计模式中的模板方法非常相似），其实际行为都由插件来完成，每个构建步骤都可以绑定一个或多个插件行为。

Maven为大多数步骤绑定了默认插件，所有有时即使没有指定插件，但是执行构建时在构建日志中还是可以看到插件执行了。

#### 三套独立的生命周期

指定执行某生命周期的某个阶段会自动执行之前的阶段，但是每套生命周期独立（不同生命周期的阶段不互相影响），这就是先清理后打包为何需要指定`mvn clean package`而不需要 `mvn clean compile package`。

##### clean

项目清理。

+ pre-clean
+ clean
+ post-clean

##### default

项目构建。

构建的完整生命周期看官网吧 [Default Lifecycle](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html#default-lifecycle)

| phase                     | Description                                                  |
| :------------------------ | :----------------------------------------------------------- |
| `validate`                | 验证项目是否正确，所有必要的信息是否可用。                   |
| `initialize`              | 初始化构建状态，例如设置属性或创建目录。                     |
| `generate-sources`        | generate any source code for inclusion in compilation.       |
| `process-sources`         | process the source code, for example to filter any values.   |
| `generate-resources`      | generate resources for inclusion in the package.             |
| `process-resources`       | copy and process the resources into the destination directory, ready for packaging. |
| `compile`                 | compile the source code of the project.                      |
| `process-classes`         | post-process the generated files from compilation, for example to do bytecode enhancement on Java classes. |
| `generate-test-sources`   | generate any test source code for inclusion in compilation.  |
| `process-test-sources`    | process the test source code, for example to filter any values. |
| `generate-test-resources` | create resources for testing.                                |
| `process-test-resources`  | copy and process the resources into the test destination directory. |
| `test-compile`            | compile the test source code into the test destination directory |
| `process-test-classes`    | post-process the generated files from test compilation, for example to do bytecode enhancement on Java classes. |
| `test`                    | run tests using a suitable unit testing framework. These tests should not require the code be packaged or deployed. |
| `prepare-package`         | perform any operations necessary to prepare a package before the actual packaging. This often results in an unpacked, processed version of the package. |
| `package`                 | take the compiled code and package it in its distributable format, such as a JAR. |
| `pre-integration-test`    | perform actions required before integration tests are executed. This may involve things such as setting up the required environment. |
| `integration-test`        | process and deploy the package if necessary into an environment where integration tests can be run. |
| `post-integration-test`   | perform actions required after integration tests have been executed. This may including cleaning up the environment. |
| `verify`                  | run any checks to verify the package is valid and meets quality criteria. |
| `install`                 | install the package into the local repository, for use as a dependency in other projects locally. |
| `deploy`                  | done in an integration or release environment, copies the final package to the remote repository for sharing with other developers and projects. |

##### site

建立项目站点。

+ pre-site
+ site
+ post-site
+ site-deploy

#### [插件](https://maven.apache.org/guides/mini/guide-configuring-plugins.html)

Maven的核心仅仅定义了抽象的生命周 期，具体的任务是交由插件完成的，插件以独立的构件形式存在，因此，Maven核心的分发包只有不 到3MB的大小，Maven会在需要的时候下载并使用插件。

##### 目标 goal

一个插件可能是多功能的，插件给每个功能定义了一个目标用于指代这个功能。

可以通过设置目标，选择使用插件的某个功能。

比如maven-dependency-plugin有十多个目标，每个目标对应了一个功能。它能够分析项目依赖，帮助找出潜在的无用依赖；它能够列出项目的依赖树，帮助分析依赖来源；它能够列出项目所有已解析的依赖等等。对应的插件目标为dependency:analyze、 dependency:tree和dependency:list。这是一种通用的写法，冒号前面是插件前缀，冒号后面是该插件的目标。类似地，还可以写出 compiler:compile（这是maven-compiler-plugin 的compile目标）和surefire:test（这是maven- surefire-plugin的test目标）。

##### 插件绑定

即生命周期阶段绑定插件的目标，即表示**某个阶段由某个插件的某个功能完成**。

**内置绑定插件**：

前面提到有些插件是默认绑定的，绑定的生命周期阶段和插件的目标参考 《Maven实战》C7.4，官网没找到关于内置绑定插件的介绍。

| 生命周期阶段 phase     | 插件目标                             | 执行任务                       |
| ---------------------- | ------------------------------------ | ------------------------------ |
| process-resources      | maven-resources-plugin:resources     | 复制主资源至主输出目录         |
| compile                | maven-compiler-plugin:compile        | 编译主代码至主输出目录         |
| process-test-resources | maven-resources-plugin:testResources | 复制测试资源文件至测试输出目录 |
| test-compile           | maven-compiler-plugin:testCompile    | 编译测试代码至测试输出目录     |
| test                   | maven-surefire-plugin:test           | 执行测试用例                   |
| package                | maven-jar-plugin:jar                 | 创建项目jar包                  |
| install                | maven-install-plugin:install         | 将项目输出构件安装到本地仓库   |
| deploy                 | maven-deploy-plugin:deploy           | 将项目输出构建部署到远程仓库   |

也可以通过 mvn 命令输出的日志查看生命周期阶段和插件的绑定关系。这里全使用内置插件执行构建。

格式：

--- 插件:版本:目标 (生命周期-阶段) @ 构件artifactId---

```verilog
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ account-email ---
[INFO] Deleting /home/lee/mywork/github/mvn_in_action_code/ch-5/account-email/target
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ account-email ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 1 resource
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ account-email ---
[INFO] Changes detected - recompiling the module!
[WARNING] File encoding has not been set, using platform encoding UTF-8, i.e. build is platform dependent!
[INFO] Compiling 3 source files to /home/lee/mywork/github/mvn_in_action_code/ch-5/account-email/target/classes
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ account-email ---
[INFO] Not copying test resources
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ account-email ---
[INFO] Not compiling test sources
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ account-email ---
[INFO] Tests are skipped.
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ account-email ---
```

##### 插件配置

+ 命令行插件配置

  比如常用的 mvn clean package -Dmaven.test.skip=true 中 maven.test.skip 是 maven-surefire-plugin 提供的用于跳过测试的配置参数。

+ 在pom.xml中进行全局配置

  在pom.xml中对插件配置，对插件的修改是项目全局的。

+ 插件任务配置

  每个任务在 execution 元素中定义，可以配置多个任务，并列放在 executions 元素中。

  每个任务需要指定插件目标绑定的生命周期的阶段，如：

  ```xml
  <execution>
      <!-- 任务ID -->
      <id>execution1</id>
      <!-- 绑定到生命周期的test阶段 -->
      <phase>test</phase>
      <!-- 任务配置内容 -->
      <configuration>
          <url>http://www.foo.com/query</url>
          <timeout>10</timeout>
          <options>
              <option>one</option>
              <option>two</option>
              <option>three</option>
          </options>
      </configuration>
      <!-- 绑定的插件目标 -->
      <goals>
          <goal>query</goal>
      </goals>
  </execution>
  ```

##### 常用插件

##### 插件仓库

```xml
<pluginRepositories> 
    <pluginRepository> 
        <id>central</id> 
        <name>Maven Plugin Repository</name> 
        <url>http://repo1.maven.org/maven2</url> 
        <layout>default</layout> 
        <snapshots> 
            <enabled>false</enabled> 
        </snapshots> 
        <releases> 
            <updatePolicy>never</updatePolicy> 
        </releases> 
    </pluginRepository> 
</pluginRepositories>
```

##### 插件默认groupId、version

对于官方插件，配置时可以省略 groupId。

插件配置时可以省略 version, Maven会将版本解析为所有可用仓库中的 最新版本，而这个版本也可能是快照版。但是推荐指定版本，避免频繁的插件更新带来的不稳定。

### [Maven 拓展](https://maven.apache.org/extensions/index.html)

如下两段配置

```xml
<build>
    <extensions>
        <extension>
            <groupId>kr.motd.maven</groupId>
            <artifactId>os-maven-plugin</artifactId>
            <version>${os.plugin.version}</version>
        </extension>
    </extensions>
</build>
```

和

```xml
<plugin>
    <groupId>kr.motd.maven</groupId>
    <artifactId>os-maven-plugin</artifactId>
    <version>${os-maven-plugin.version}</version>
    <executions>
        <execution>
            <phase>initialize</phase>
            <goals>
	            <goal>detect</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

第一段代码的作用是在 Maven 构建中使用 os-maven-plugin 插件的同时，将 os-maven-plugin 插件作为一个扩展进行配置。这样做的目的是为了能够在构建过程中使用 os-maven-plugin 的功能来增强 Maven 的功能，例如通过 os-maven-plugin 来检测操作系统版本，在构建过程中根据操作系统版本来动态地配置某些信息等。

第二段代码则是将 os-maven-plugin 插件直接配置在构建过程中，使用了 plugin 元素来进行配置。这样做的目的是为了能够在 Maven 构建过程的特定阶段中执行 os-maven-plugin 插件的任务，例如在 initialize 阶段中检测操作系统版本，或执行其他与操作系统相关的任务。

因此，这两种方式的区别主要在于它们的作用方式不同。第一个代码片段旨在使用 os-maven-plugin 扩展来增强 Maven 的功能，而第二个代码片段则旨在直接使用 os-maven-plugin 插件来执行特定任务。

### Maven多模块-聚合、继承

多模块项目被称为聚合项目，packaging 为 pom，可以同时管理多个模块的构建。通过 modules 元素指定子模块，module 的值为子模块的相对路径。

子模块可以通过 parent 元素继承父模块中的配置。

#### 可继承内容

+ **groupId**：项目组ID，项目坐标的核心元素。 
+ **version**：项目版本，项目坐标的核心元素。 
+ description：项目的描述信息。 
+ organization：项目的组织信息。 
+ inceptionYear：项目的创始年份。 
+ url：项目的URL地址。 
+ developers：项目的开发者信息。 
+ contributors：项目的贡献者信息。
+ **distributionManagement**：项目的部署配置。
+ issueManagement：项目的缺陷跟踪系统信息。
+ ciManagement：项目的持续集成系统信息。 
+ scm：项目的版本控制系统信息。 
+ mailingLists：项目的邮件列表信息。 
+ **properties**：自定义的Maven属性。 
+ **dependencies**：项目的依赖配置。 
+ **dependencyManagement**：项目的依赖管理配置。
+ **repositories**：项目的仓库配置。 
+ **build**：包括项目的源码目录配置、输出目录配 置、插件配置、插件管理配置等。
+ reporting：包括项目的报告输出目录配置、报 告插件配置等。

#### 反应堆

反应堆 （Reactor）是指所有模块组成的一个构建结构。反应堆包含了各模块之间继承与依赖的关系，从而能够自动计算出合理的模块构建顺序。

##### 裁剪反应堆

指只构建反映堆中的某些个模块，比如 mvn 的一些参数：

```
-am, --also-make 	同时构建所列模块的依赖模块
-amd, --also-make-dependents 	同时构建依赖于所列模块的模块 
-pl, --projects <arg> 	构建指定的模块，模块间用逗号分隔
-rf, --resume-from <arg> 	递归执行指定的目录下的 Maven 项目的构建任务
```

### Maven 测试

Maven 测试阶段的执行默认依赖内置的插件 maven-surefire-plugin，可以称之为测试运 行器（Test Runner），它能很好地兼容JUnit3、 JUnit4 以及TestNG。

在默认情况下，maven-surefire-plugin的test 目标会自动执行测试源码路径（默认为 src/test/java/）下所有符合一组命名模式的测试 类。

这组模式为： 

+ `**/Test*.java`：任何子目录下所有命名以Test开 头的Java类。 
+ `**/*Test.java`：任何子目录下所有命名以Test结 尾的Java类。 
+ `**/*TestCase.java`：任何子目录下所有命名以 TestCase结尾的Java类。

#### 跳过测试

+ 命令行参数 skipTests，此次构建跳过测试

  ```shell
  # 从插件层面跳过测试，测试代码会被编译
  mvn package -DskipTests
  # 从maven层面跳过测试阶段，测试代码都不会被编译
  mvn package -Dmaven.test.skip=true
  ```

+ 在pom.xml maven-surefire-plugin 插件配置中设置永久跳过测试

  ```xml
  <!-- 对应命令行参数 -DskipTests -->
  <skipTests>true</skipTests>
  <!-- 对应命令行参数 -Dmaven.test.skip=true -->
  <skip>true</skip>
  ```

+ 只运行某些测试

  ```shell
  # 只运行 Random*Test.java 的测试
  # 除了支持*匹配，还可以用逗号分隔指定多个测试用例，
  mvn test -Dtest=Random*Test
  ```

+ 设置没有任何测试也不报错

  ```
  mvn test -Dtest -DfailIfNoTests=false
  ```

#### 包含和排除测试用例

maven-surefire-plugin 默认是不会匹配 Tests.java结尾的测试用例，如果要执行这种测试用例可以用 include 元素包含测试用例，对应的可以用 exclude 排除测试用例。

```xml
<plugin> 
    <groupId>org.apache.maven.plugins</groupId> 
    <artifactId>maven-surefire-plugin</artifactId> 
    <version>2.5</version> 
    <configuration> 
        <includes> 
            <include>**/*Tests.java</include> 
        </includes> 
        <excludes> 
            <exclude>**/*ServiceTest.java</exclude> 
            <exclude>**/TempDaoTest.java</exclude> 
        </excludes>
    </configuration> 
</plugin>
```

#### 测试报告

位于 target/surefire-reports 。

查看测试覆盖率，TODO。

#### 测试代码重用

比如在项目中重用某个模块的测试代码，可以通过配置maven-jar-plugin将测试类打包到 *-tests.jar。

```xml
<plugin> 
    <groupId>org.apache.maven.plugins</groupId> 
    <artifactId>maven-jar-plugin</artifactId> 
    <version>2.2</version> 
    <executions> 
        <execution> 
            <goals> 
                <goal>test-jar</goal> 
            </goals> 
        </execution> 
    </executions> 
</plugin>
```

### 版本管理

为了方便团队的合作，在项目开发 的过程中，大家都应该使用快照版本，Maven能够 很智能地处理这种特殊的版本，解析项目各个模块 最新的“快照”。快照版本机制促进团队内部的交流，但是当项目需要对外发布时，我们显然需要提供非常稳定的版本，使用该版本应当永远只能够定 位到唯一的构件，而不是像快照版本那样，定位的 构件随时可能发生变化。对应地，我们称这类稳定的版本为发布版。项目发布了一个版本之后，就进入下一个开发阶段，项目也就自然转换到新的快照 版本中。 

版本管理关心的问题之一就是这种快照版和发布版之间的转换。

#### 版本号约定规范

如：1.3.4-beta-2

分别是 主版本、次版本、增量、beta-2是增量的某个里程碑，即＜主版本＞.＜次版本＞.＜增量版本＞-＜里程碑版本＞。

详细参考参考资料。

#### 自动化版本发布

参考 maven-release-plugin 插件配置。

#### 自动化创建分支

#### GPG 签名

用于校验下载的依赖文件是否被篡改过，用于保证下载文件的安全性。

### 灵活的配置

#### [Maven Profile](https://maven.apache.org/guides/introduction/introduction-to-profiles.html)

profile 也是配置的意思，用来针对不同环境做个性化的配置。profile能够在构建的时候修改POM的一个子集，或者添加额外的配置元素。用户可以使用很多 方式激活profile，以实现构建在不同环境下的移植。

比如测试环境和生产环境maven配置经常是有一些差异的，不同的环境通常对应不同的分支；可以使用git分支，分别保存不同环境的Maven配置；也可以通过Profile定制化不同环境的配置，而在对应的环境进行编译的时候只需要激活对应的Profile。

一些使用场景：

+ 比如本地开发环境有时为方便测试避免额外的依赖，选择使用内存数据库代替数据库中间件。
+ 使用 pom profile 控制 spring profile 激活，参考：[Idea结合Maven的profile配置实现动态切换环境](https://blog.csdn.net/xingbaozhen1210/article/details/89519415)

##### Profile 元素

+ id

  Profile 的标识。

+ activation

  Profile的激活方式。

+ 其他一些pom通用元素
  + `<repositories>`
  + `<pluginRepositories>`
  + `<dependencies>`
  + `<plugins>`
  + `<properties>` (not actually available in the main POM, but used behind the scenes)
  + `<modules>`
  + `<reports>`
  + `<reporting>`
  + `<dependencyManagement>`
  + `<distributionManagement>`
  + a subset of the `<build>` element, which consists of:
    - `<defaultGoal>`
    - `<resources>`
    - `<testResources>`
    - `<directory>`
    - `<finalName>`
    - `<filters>`
    - `<pluginManagement>`
    - `<plugins>`

##### Profile 作用域

Maven3及之后只有下面三种，之前还有一种已经废弃了。

- Per Project

  \- Defined in the POM itself `(pom.xml)`.

- Per User

  \- Defined in the [Maven-settings](https://maven.apache.org/ref/current/maven-settings/settings.html) `(%USER_HOME%/.m2/settings.xml)`.

- Global

  \- Defined in the [global Maven-settings](https://maven.apache.org/ref/current/maven-settings/settings.html) `(${maven.home}/conf/settings.xml)`.

##### Profile 的激活

+ 命令行显示激活

  maven 命令传参，-P<ProfileId>，可以激活多个不互斥的Profile，通过逗号分隔。

+ settings显示激活

  ```
  <settings>
    ...
    <activeProfiles>
      <activeProfile>profile-1</activeProfile>
    </activeProfiles>
    ...
  </settings>
  ```

+ 通过设置系统属性激活

  ```
  <profiles>
    <profile>
      <activation>
        <property>
          <name>debug</name>
        </property>
      </activation>
      ...
    </profile>
  </profiles>
  ```

+ 默认激活
+ 通过JDK版本、OS环境激活
+ 通过文件存在与否激活

### 生成项目站点

使用 maven-site-plugin 可以在 target/site 下生成一个web网页，可以用于查看项目的一些信息。如：

关于（about）：项目描述。 
持续集成（Continuous Integration）：项目 持续集成服务器信息。 
依赖（Dependencies）：项目依赖信息，包括传递性依赖、依赖图、依赖许可证以及依赖文件的 大小、所包含的类数目等。 
依赖收敛（Dependency Convergence）：只 针对多模块项目生成，提供一些依赖健康状况分 析，如各模块使用的依赖版本是否一致、项目中是 否有SNAPSHOT依赖。 
依赖管理（Dependency Management）：基 于项目的依赖管理配置生成的报告。 
问题追踪（Issue Tracking）：项目的问题追踪 系统信息。 邮件列表（Mailing Lists）：项目的邮件列表信 息。
插件管理（Plugin Management）：项目所使用插件的列表。 
项目许可证（Project License）：项目许可证 信息。
项目概述（Project Summary）：项目概述包 括坐标、名称、描述等。 
项目团队（Project Team）：项目团队信息。 
源码仓库（Source Repository）：项目的源码 仓库信息。



## Maven 进阶

### [插件开发](https://maven.apache.org/plugin-developers/index.html)



## 实用技巧

### archetype 创建项目



##　Maven 案例

### 超级POM pom.xml

apache-maven-3.6.3 : 

指定了中央仓库、插件中央仓库的地址，构建的目录规范（比如源码目录、资源目录、编译输出目录、测试目录、测试资源目录、脚本资源目录等路径），插件管理，项目报告输出目录等等。

```xml
<?xml version="1.0" encoding="UTF-8"?>

<project>
  <modelVersion>4.0.0</modelVersion>

  <repositories>
    <!-- 超级POM中配置了中央仓库地址，从而让Maven项目可以从中央仓库下载依赖 -->
    <repository>
      <id>central</id>
      <name>Central Repository</name>
      <url>https://repo.maven.apache.org/maven2</url>
      <layout>default</layout>
      <!-- 中央仓库不支持SNAPSHOT版本依赖下载 -->
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
    </repository>
  </repositories>

  <pluginRepositories>
    <!-- 插件中央仓库 -->
    <pluginRepository>
      <id>central</id>
      <name>Central Repository</name>
      <url>https://repo.maven.apache.org/maven2</url>
      <layout>default</layout>
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
      <releases>
        <updatePolicy>never</updatePolicy>
      </releases>
    </pluginRepository>
  </pluginRepositories>

  <build>
    <!-- 编译生成文件目录 -->
    <directory>${project.basedir}/target</directory>
    <!-- 编译输出目录，在编译生成文件目录下 -->
    <outputDirectory>${project.build.directory}/classes</outputDirectory>
    <!-- 编译生成jar等文件的名字 -->
    <finalName>${project.artifactId}-${project.version}</finalName>
    <!-- 编译测试代码输出目录，在编译生成文件目录下 -->
    <testOutputDirectory>${project.build.directory}/test-classes</testOutputDirectory>
    <!-- 源码文件目录 -->
    <sourceDirectory>${project.basedir}/src/main/java</sourceDirectory>
    <!-- 脚本文件目录，比较少见，TODO怎么用的 -->
    <scriptSourceDirectory>${project.basedir}/src/main/scripts</scriptSourceDirectory>
    <!-- 测试源码文件目录 -->
    <testSourceDirectory>${project.basedir}/src/test/java</testSourceDirectory>
    <resources>
      <resource>
        <!-- 资源文件目录 -->
        <directory>${project.basedir}/src/main/resources</directory>
      </resource>
    </resources>
    <testResources>
      <testResource>
        <!-- 测试资源文件目录 -->
        <directory>${project.basedir}/src/test/resources</directory>
      </testResource>
    </testResources>
    <!-- 默认管理的插件及版本 -->
    <pluginManagement>
      <!-- NOTE: These plugins will be removed from future versions of the super POM -->
      <!-- They are kept for the moment as they are very unlikely to conflict with lifecycle mappings (MNG-4453) -->
      <plugins>
        <plugin>
          <artifactId>maven-antrun-plugin</artifactId>
          <version>1.3</version>
        </plugin>
        <plugin>
          <artifactId>maven-assembly-plugin</artifactId>
          <version>2.2-beta-5</version>
        </plugin>
        <plugin>
          <artifactId>maven-dependency-plugin</artifactId>
          <version>2.8</version>
        </plugin>
        <plugin>
          <artifactId>maven-release-plugin</artifactId>
          <version>2.5.3</version>
        </plugin>
      </plugins>
    </pluginManagement>
  </build>

  <reporting>
    <!-- site 文件目录，默认 /target/site -->
    <outputDirectory>${project.build.directory}/site</outputDirectory>
  </reporting>

  <profiles>
    <!-- NOTE: The release profile will be removed from future versions of the super POM -->
    <profile>
      <!-- 提供了打包部署的功能 -->
      <id>release-profile</id>
      <!-- performRelease属性为true触发 -->
      <activation>
        <property>
          <name>performRelease</name>
          <value>true</value>
        </property>
      </activation>

      <build>
        <plugins>
          <plugin>
            <inherited>true</inherited>
            <artifactId>maven-source-plugin</artifactId>
            <executions>
              <execution>
                <id>attach-sources</id>
                <goals>
                  <goal>jar-no-fork</goal>
                </goals>
              </execution>
            </executions>
          </plugin>
          <plugin>
            <inherited>true</inherited>
            <artifactId>maven-javadoc-plugin</artifactId>
            <executions>
              <execution>
                <id>attach-javadocs</id>
                <goals>
                  <goal>jar</goal>
                </goals>
              </execution>
            </executions>
          </plugin>
          <plugin>
            <inherited>true</inherited>
            <artifactId>maven-deploy-plugin</artifactId>
            <configuration>
              <updateReleaseInfo>true</updateReleaseInfo>
            </configuration>
          </plugin>
        </plugins>
      </build>
    </profile>
  </profiles>

</project>
```

