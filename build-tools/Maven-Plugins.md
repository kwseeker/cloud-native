# Maven 常用插件

官方文档：[Maven Plugins](https://maven.apache.org/plugins/index.html)

分为两类：

+ 构建插件(Build plugins)
+ 报告插件(Reporting plugins)

## [Maven插件配置](https://maven.apache.org/guides/mini/guide-configuring-plugins.html)

### 插件配置元素

+ groupId
+ artifactId
+ version
+ executions & execution
  + id
  + phase
  + configuration
  + goals & goal
+ extensions
+ configuration



## Maven 官方插件

命名：maven-<name>-plugin，这里只列举最常用的。

### clean

### resources

负责将项目资源复制到输出目录。有两种不同的资源:主资源和测试资源。区别在于主资源是与主源代码关联的资源，而测试资源是与测试源代码关联的资源。

目标：

- resources:resources copies the resources for the main source code to the main output directory.
  This goal usually executes automatically, because it is bound by default to the process-resources life-cycle phase. It always uses the project.build.resources element to specify the resources, and by default uses the project.build.outputDirectory to specify the copy destination.
- resources:testResources copies the resources for the test source code to the test output directory.
  This goal usually executes automatically, because it is bound by default to the process-test-resources life-cycle phase. It always uses the project.build.testResources element to specify the resources, and by default uses the project.build.testOutputDirectory to specify the copy destination.
- resources:copy-resources copies resources to an output directory.
  This goal requires that you configure the resources to be copied, and specify the outputDirectory.

案例：

指定资源目录

```xml
<project>
    ...
    <build>
        ...
        <resources>
            <resource>
                <directory>[your folder here]</directory>
            </resource>
        </resources>
        ...
    </build>
    ...
</project>
```

### compiler

用于编译项目的源代码。

目标：

+ [compiler:compile](https://maven.apache.org/plugins/maven-compiler-plugin/compile-mojo.html) 绑定到compile阶段，用于编译主源码文件
+ compiler:testCompile 绑定到test-compile阶段，用于编译测试源码文件

案例：

简单使用

```xml
 <plugin>
     <artifactId>maven-compiler-plugin</artifactId>
     <version>${maven-compiler-plugin.version}</version>
     <configuration>
         <source>${compiler.version}</source>
         <target>${compiler.version}</target>
         <encoding>${project.build.sourceEncoding}</encoding>
     </configuration>
</plugin>
```

更换JDK编译源码

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.11.0</version>
    <configuration>
        <verbose>true</verbose>
        <!-- 是否允许在单独的进程中运行编译器。如果为 false，则使用内置编译器，如果为 true，则使用可执行文件。 -->
        <fork>true</fork>
        <executable><!-- path-to-javac --></executable>
        <!-- 使用的编译器版本 -->
        <compilerVersion>1.3</compilerVersion>
    </configuration>
</plugin>
```

### [surefire](https://maven.apache.org/surefire/maven-surefire-plugin/)

用于在test阶段运行单元测试，它可以生成两种格式的报告：

- Plain text files (`*.txt`)
- XML files (`*.xml`)

报告文件默认生成到 `${basedir}/target/surefire-reports/TEST-*.xml`。

目标：

- [surefire:test](https://maven.apache.org/surefire/maven-surefire-plugin/test-mojo.html) runs the unit tests of an application.

### failsafe

Failsafe Plugin设计用于运行集成测试，Surefire Plugin设计用于运行单元测试。之所以选择failsafe这个名称，一方面是因为它是surefire的同义词，另一方面是因为它暗示当它发生故障时，它是以安全的方式发生的。

Maven的四个集成测试阶段：

- `pre-integration-test` for setting up the integration test environment.
- `integration-test` for running the integration tests.
- `post-integration-test` for tearing down the integration test environment.
- `verify` for checking the results of the integration tests.

目标：

- [failsafe:integration-test](https://maven.apache.org/surefire/maven-failsafe-plugin/integration-test-mojo.html) runs the integration tests of an application.
- [failsafe:verify](https://maven.apache.org/surefire/maven-failsafe-plugin/verify-mojo.html) verifies that the integration tests of an application passed.

### jar

提供了构建 jar 的功能。要签署 jar，请使用 Maven Jarsigner 插件。

目标：

- [jar:jar](https://maven.apache.org/plugins/maven-jar-plugin/jar-mojo.html) create a jar file for your project classes inclusive resources.
- [jar:test-jar](https://maven.apache.org/plugins/maven-jar-plugin/test-jar-mojo.html) create a jar file for your project test classes .

### war

### shade

提供了将构件打包在 uber-jar 中的功能，包括其依赖项，并遮蔽（即重命名）某些依赖项的包。

> 几种Jar包的区别
>
> + Executable Jar
>
>   一般是指将所有依赖的Jar包都放在一个Jar包内，这个Jar包包含了所有运行时需要依赖的Jar包代码。
>
> + Uber Jar
>
>   同 Fat Jar
>
> + Fat Jar
>
>   打包Jar包时，连同其依赖Jar一起打包。
>
> + Shade Jar / Shadow Jar
>
>   将Jar包及其依赖包打包到一个jar文件内，同时提供shade“遮蔽/重命名”某些依赖包的功能。

目标：

- [shade:shade](https://maven.apache.org/plugins/maven-shade-plugin/shade-mojo.html) is bound to the `package` phase and is used to create a shaded jar.

  - artifactSet

    定义需要合并的 jar 包集合。如果没有指定 元素，maven-shade-plugin 默认会合并项目依赖项中的所有 Jar 包。当然，如果您只想合并部分 Jar 包，您可以在 元素中指定它们的 groupId、artifactId 和 version。

    可以使用`<includes>`指定只想合并的依赖Jar包，使用 `<excludes>`排除不需要的Jar包。

  - shadedArtifactAttached

    此参数的作用是控制 shaded artifact 是否作为附加的构件进行发布。举个例子，假设有一个 Java 项目，其依赖于 `com.example:library:1.0.0` 这个库。如果在项目中使用 `maven-shade-plugin` 插件将项目及其依赖项打包成一个带有重命名的 shaded artifact 文件，则可以设置 `shadedArtifactAttached` 参数来控制是否将 shaded artifact 作为附加的构件进行发布。

    当 `shadedArtifactAttached` 参数设置为 `true` 时，Maven 将会在构建项目后将 shaded artifact 发布到 Maven 仓库中，并将其作为项目的一个附加构件来发布。这样，使用该项目的其他开发人员可以单独选择是否依赖 shaded artifact 文件，例如通过在 Maven 坐标中指定分量 `classifier` 来依赖不同的构件。

    ```xml
    <dependency>
      <groupId>com.example</groupId>
      <artifactId>my-project</artifactId>
      <version>1.0.0</version>
      <!-- 依赖附加构件 -->    
      <classifier>shaded</classifier>
    </dependency>
    ```

    上面讲的有点抽象，以skywalking-java项目apm-agent模块为例，看下打开和关闭时的打包结果。
    设置为true:

    ```
    .
    ├── ...
    ├── apm-agent-8.14.0-shaded.jar
    ├── apm-agent-8.14.0-shaded-sources.jar
    └── skywalking-agent.jar
    ```

    设置为false:

    ```
    .
    ├── ...
    ├── original-skywalking-agent.jar
    ├── skywalking-agent-sources.jar
    └── skywalking-agent.jar
    ```

  - filters

    常和 excludes、includes 元素搭配使用用于打包时过滤掉不需要的文件。

  + createSourcesJar

    另外打包一个源码Jar包，默认应该是true，因为不配置这个参数也会打源码包。

  + transformers

    用于打包Java Agent项目。

### assembly

assembly 是装配、组合的意思。

此插件能够将项目输出组合成一个可分发的归档文件，该归档文件还包含依赖项、模块、站点文档和其他文件。

目标：

+ [assembly:help](https://maven.apache.org/plugins/maven-assembly-plugin/help-mojo.html) 显示有关 maven- assembly-plugin 的帮助信息。 调用 mvn assembly:help -Ddetail=true -Dgoal=<goal-name> 显示参数详细信息。
+ [assembly:single](https://maven.apache.org/plugins/maven-assembly-plugin/single-mojo.html) 从程序集描述符组装应用程序包或发行版。此目标既适合绑定到生命周期，也适合直接从命令行调用(前提是所有必需的文件在构建开始之前可用，或者由在命令行上指定的另一个目标生成)。

案例：

+ 单模块项目

  + 包含/排除构件

    ```xml
    <dependencySets>
        <dependencySet>
            ....
            <excludes>
                <exclude>org.apache.commons:commons-lang3</exclude>
                <exclude>org.apache.logging.log4j:log4j-1.2-api</exclude>
            </excludes>
        </dependencySet>
        ....
    </dependencySets>
    ```

  + 使用 Component Descriptors

  + 使用 Container Descriptor Handlers

+ 多模块项目

  + 添加模块源码
  + 添加模块二进制文件

### jar 、shade、assembly 区别

maven-jar-plugin 将源码和lib下的依赖打包成Jar；

maven-assembly-plugin 会将依赖和资源文件都打入最终的Jar包，诸如properties文件等。如果项目和依赖中都有相同名称的资源文件时，就会发生冲突，导致项目中的相同名称的文件不会打到最终的Jar包中; 

maven-shade-plugin 可以通过重命名的方式解决maven-assembly-plugin文件冲突的问题。

### source

用于对工程的源代码进行源文件的打包，生成 xxx-sources.jar文件，jar文件默认创建在target目录。

目标：

- [source:aggregate](https://maven.apache.org/plugins/maven-source-plugin/aggregate-mojo.html) aggregrates sources for all modules in an aggregator project.
- [source:jar](https://maven.apache.org/plugins/maven-source-plugin/jar-mojo.html) is used to bundle the main sources of the project into a jar archive.
- [source:test-jar](https://maven.apache.org/plugins/maven-source-plugin/test-jar-mojo.html) on the other hand, is used to bundle the test sources of the project into a jar archive.
- [source:jar-no-fork](https://maven.apache.org/plugins/maven-source-plugin/jar-no-fork-mojo.html) is similar to **jar** but does not fork the build lifecycle.
- [source:test-jar-no-fork](https://maven.apache.org/plugins/maven-source-plugin/test-jar-no-fork-mojo.html) is similar to **test-jar** but does not fork the build lifecycle.

案例：

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-source-plugin</artifactId>
    <version>3.3.0</version>
    <configuration>
        <outputDirectory>/absolute/path/to/the/output/directory</outputDirectory>
        <finalName>filename-of-generated-jar-file</finalName>
        <!-- Specifies whether or not to attach the artifact to the project, default true -->
        <attach>false</attach>
    </configuration>
</plugin>
```

### install

### verifier

### deploy

主要在部署阶段使用，用于将构件添加到远程仓库中，以便与其他开发人员和项目共享。这通常在集成或发布环境中完成。

前提：

- information about the repository: its location, the transport method used to access it (FTP, SCP, SFTP...) and the optional user specific required account information
- information about the artifact(s): the group, artifact, version, packaging, classifier...
- a deployer: a method to actually perform the deployment. This can be implemented as a wagon transport (making it cross-platform), or use a system specific method.

> 即 distributionManagement 定义的仓库信息、server定义的用户名密码、构建的坐标信息；但是没有明白 transport method h和 deployer代指什么（TODO）。

目标：

+ deploy:deploy 
+ deploy:deploy-file

### antrun

提供了从Maven中运行Ant任务的能力。官方推荐将任务定义在 build.xml。很有用，比如可以作为构建日志logger。

类似 exec-maven-plugin。

目标：

+ [antrun:run](https://maven.apache.org/plugins/maven-antrun-plugin/run-mojo.html) runs Ant tasks for Maven.

案例：

编译阶段，打印各种classpath路径。

```xml
<plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-antrun-plugin</artifactId>
        <version>3.1.0</version>
        <executions>
          <execution>
            <id>compile</id>
            <phase>compile</phase>
            <configuration>
              <target>
                <property name="compile_classpath" refid="maven.compile.classpath"/>
                <property name="runtime_classpath" refid="maven.runtime.classpath"/>
                <property name="test_classpath" refid="maven.test.classpath"/>
                <property name="plugin_classpath" refid="maven.plugin.classpath"/>
 
                <echo message="compile classpath: ${compile_classpath}"/>
                <echo message="runtime classpath: ${runtime_classpath}"/>
                <echo message="test classpath:    ${test_classpath}"/>
                <echo message="plugin classpath:  ${plugin_classpath}"/>
              </target>
            </configuration>
            <goals>
              <goal>run</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
```

### artifact

### archetype

### dependency

### release

### [enforcer](https://maven.apache.org/enforcer/maven-enforcer-plugin/)

执行配置的规则来检查某些约束，例如 Maven 版本、JDK 版本和操作系统系列，以及更多内置规则和用户创建的规则。

目标：

+ enforcer:enforce 为多项目构建中的每个项目执行规则。

除了rules还支持3个选项：

+ skip 配置跳过检查，命令行使用  -Denforcer.skip。
+ fail 当有rule校验失败后goal是否应该失败，默认true；如果设置false, 错误信息会以warning日志打印。
+ failFast 当检测到第一次失败后，goal是否应该停止，默认false。

案例：

校验阶段检查Java版本和Maven版本。

```xml
<plugin>
    <artifactId>maven-enforcer-plugin</artifactId>
    <version>${maven-enforcer-plugin.version}</version>
    <executions>
        <execution>
            <id>enforce-java</id>
            <goals>
                <goal>enforce</goal>
            </goals>
            <phase>validate</phase>
            <configuration>
                <rules>
                    <requireJavaVersion>
                        <version>1.8</version>
                    </requireJavaVersion>
                    <requireMavenVersion>
                        <version>3.6</version>
                    </requireMavenVersion>
                </rules>
            </configuration>
        </execution>
    </executions>
</plugin>
```

### checkstyle

可以生成开发人员使用的代码样式的报告。用于检查 Java 源代码是否遵守代码标准或验证规则集（最佳实践）。通过此插件可以定义代码规范，包括变量的命名，缩进，注释等内容，避免多人协同开发时出现各种风格混合带来的混乱，统一的代码风格。

checkstyle 可以在 IDEA 中配置使用；也可以通过Maven插件配置使用。

IDEA中可以在编辑代码时按checkstyle文件格式格式化代码，可以自动检查代码分隔，也可以手动触发对文件、模块、整个项目进行风格检查；插件则是在构建过程中对代码风格进行检查。

这里只讲解Maven插件使用checkstyle的方法：首先需要一个checkstyle的规则文件，有很多开源的规则文件，然后需要配置maven-checkstyle-plugin插件，还可以配置跳过检查的配置文件。

> IDEA 中配置checkstyle文章很多，随便搜下参考配置即可，比如：[flink教程-在IntelliJ IDEA 中玩转 checkstyle](https://juejin.cn/post/6850418109535223816)

目标：

- [checkstyle:checkstyle](https://maven.apache.org/plugins/maven-checkstyle-plugin/checkstyle-mojo.html) is a reporting goal that performs Checkstyle analysis and generates a report on violations.

- [checkstyle:checkstyle-aggregate](https://maven.apache.org/plugins/maven-checkstyle-plugin/checkstyle-aggregate-mojo.html) is a reporting goal that performs Checkstyle analysis and generates an aggregate HTML report on violations in a multi-module reactor build.

- [checkstyle:check](https://maven.apache.org/plugins/maven-checkstyle-plugin/check-mojo.html) is a goal that performs Checkstyle analysis and outputs violations or a count of violations to the console, potentially failing the build. It can also be configured to re-use an earlier analysis.

  ```shell
  # 如果需要临时跳过风格检查 checkstyle.skip
  mvn clean install -Dcheckstyle.skip
  ```

一些开源的checkstyle文件

如果文件中有不符合自己或公司的规则可以修改文件并保存下来。

+ Google
  +  https://google.github.io/styleguide/javaguide.html
  +  https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/google_checks.xml
+  Blinkfox 
  + https://github.com/blinkfox/java-style
  + https://blinkfox.github.io/java-style/#/README（推荐）

案例：

这里分析下skywalking中的checkstyle使用，有些开源项目要求Contributor提交代码需要符合项目的代码风格。 

```xml
<plugin>
    <artifactId>maven-checkstyle-plugin</artifactId>
    <version>${maven-checkstyle-plugin.version}</version>
    <configuration>
        <configLocation>${maven.multiModuleProjectDirectory}/apm-checkstyle/checkStyle.xml</configLocation>
        <headerLocation>${maven.multiModuleProjectDirectory}/apm-checkstyle/CHECKSTYLE_HEAD</headerLocation>
        <encoding>UTF-8</encoding>
        <consoleOutput>true</consoleOutput>
        <includeTestSourceDirectory>true</includeTestSourceDirectory>
        <failOnViolation>${checkstyle.fails.on.error}</failOnViolation>
        <sourceDirectories>
            <sourceDirectory>${project.build.sourceDirectory}</sourceDirectory>
            <sourceDirectory>${project.build.testSourceDirectory}</sourceDirectory>
            <sourceDirectory>scenarios/resttemplate-6.x-scenario</sourceDirectory>
        </sourceDirectories>
        <resourceIncludes>
            **/*.properties,
            **/*.sh,
            **/*.bat,
            **/*.yml,
            **/*.yaml,
            **/*.xml
        </resourceIncludes>
        <resourceExcludes>
            **/.asf.yaml,
            **/.github/**,
            **/skywalking-agent-version.properties
        </resourceExcludes>
        <excludes>
            **/target/generated-test-sources/**,
            org/apache/skywalking/apm/network/register/v2/**/*.java,
            org/apache/skywalking/apm/network/common/**/*.java,
            org/apache/skywalking/apm/network/servicemesh/**/*.java,
            org/apache/skywalking/apm/network/language/**/*.java,
            org/apache/skywalking/oap/server/core/remote/grpc/proto/*.java,
            org/apache/skywalking/oal/rt/grammar/*.java,
            org/apache/skywalking/oap/server/exporter/grpc/*.java,
            org/apache/skywalking/oap/server/configuration/service/*.java,
            **/jmh_generated/*_jmhType*.java,
            **/jmh_generated/*_jmhTest.java
        </excludes>
        <propertyExpansion>
            import.control=${maven.multiModuleProjectDirectory}/apm-checkstyle/importControl.xml
        </propertyExpansion>
    </configuration>
    <executions>
        
        <execution>
            <id>validate</id>
            <phase>process-sources</phase>
            <goals>
                <goal>check</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```



## [第三方插件](https://maven.apache.org/plugins/index.html#outside-the-maven-land)

命名：<name>-maven-plugin，这里只列举最常用的。



### [org.codehaus.mojo](https://www.mojohaus.org/plugins.html)

#### exec

提供了两个目标goal来执行系统和Java程序。

+ exec:exec 在单独的进程中执行程序和Java程序。
+ exec:java 在同一虚拟机中执行 Java 程序。



### io.takari

#### [takari](https://github.com/takari/takari-maven-plugin)

用于安装和更新 Maven Wrapper 到 Maven 项目。



### kr.motd.maven

#### [**os**](https://github.com/trustin/os-maven-plugin)

用于为 Maven 构建过程中检查操作系统类型，并**生成对应的系统变量**，然后可以根据操作系统类别选择不同的依赖项和资源文件。它可以帮助 Maven 项目在多个平台下实现自动化构建，并且可以根据不同的操作系统类型添加或删除某些依赖项或资源文件。

这个插件很常用，比如在不同的OS平台下加载不同的protoc编译器文件。可以借助antrun插件打印生成的系统环境变量看看。

生成的系统环境变量：

+ os.detected.name

  如：linux、osx、windows

+ os.detected.arch

  如：x86_32、x86_64、arm_32

+ os.detected.bitness

  系统的位数，如32、64

+ os.detected.version.*

  系统版本号

+ **os.detected.classifier**

  是 ${os.Detected.name}-${os.Detected.arch} 的快捷方式。

+ os.detected.release.* (Linux-only)

  一些特殊Linux发行版提供的特殊环境变量。

案例：

打包jar文件时将${os.Detected.classifier} 作为生成的JAR的classifier。

```xml
<project>
  <build>
    <plugins>
      <plugin>
        <artifactId>maven-jar-plugin</artifactId>
        <configuration>
          <classifier>${os.detected.classifier}</classifier>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```



### com.spotify

#### [docker](https://github.com/spotify/docker-maven-plugin)

自动生成镜像并推送到docker仓库中。

案例：

指定构建信息到 POM 中构建

```xml
<plugin>
    <groupId>com.spotify</groupId>
    <artifactId>docker-maven-plugin</artifactId>
    <version>1.0.0</version>
    <configuration>
        <imageName>mavendemo</imageName>
        <baseImage>java</baseImage>
        <maintainer>docker_maven docker_maven@email.com</maintainer>
        <workdir>/ROOT</workdir>
        <cmd>["java", "-version"]</cmd>
        <entryPoint>["java", "-jar", "${project.build.finalName}.jar"]</entryPoint>
        <!-- 这里是复制 jar 包到 docker 容器指定目录配置 -->
        <resources>
            <resource>
                <targetPath>/ROOT</targetPath>
                <directory>${project.build.directory}</directory>
                <include>${project.build.finalName}.jar</include>
            </resource>
        </resources>
    </configuration>
</plugin>
```

使用Dockerfile构建

```xml
<plugin>
    <groupId>com.spotify</groupId>
    <artifactId>docker-maven-plugin</artifactId>
    <version>1.0.0</version>
    <configuration>
        <imageName>mavendemo</imageName>
        <!-- 指定 Dockerfile 路径-->
        <dockerDirectory>${basedir}/docker</dockerDirectory> 
        <!-- 这里是复制 jar 包到 docker 容器指定目录配置，也可以写到 Docokerfile 中 -->
        <resources>
            <resource>
                <targetPath>/ROOT</targetPath>
                <directory>${project.build.directory}</directory>
                <include>${project.build.finalName}.jar</include>
            </resource>
        </resources>
    </configuration>
</plugin>   
```



### io.fabric8

#### [docker](https://dmp.fabric8.io/)

支持自动生成镜像、推送到镜像仓库、启动容器。



### org.xolstice.maven.plugins

#### [protobuf](https://github.com/xolstice/protobuf-maven-plugin)

官方文档：[Maven Protocol Buffers Plugin](https://www.xolstice.org/protobuf-maven-plugin/index.html)

此插件将 protocol buffers compiler（protoc）集成到 Maven 生命周期中。这是 maven-protoc-plugin 的延续，最初由 Google 发起，后来由 GitHub 社区开发。

此插件会自动扫描所有当前项目及子模块的依赖项，查找捆绑的.proto文件，并配置协议缓冲区编译器的proto路径，以使用这些文件作为导入。会自动将源.proto文件附加到项目的资源中，以便稍后将它们打包到最终的工件中并可以引用。

使用此插件，就不要自己再手动装 protoc 了，也不再需要手动通过protoc生成 protobuf 的代码了。

目标（仅Java）：

+ [protobuf:compile](https://www.xolstice.org/protobuf-maven-plugin/compile-mojo.html) compiles main `.proto` definitions into Java files and attaches the generated Java sources to the project.
+ [protobuf:test-compile](https://www.xolstice.org/protobuf-maven-plugin/test-compile-mojo.html) compiles test `.proto` definitions into Java files and attaches the generated Java test sources to the project.
+ [protobuf:compile-javanano](https://www.xolstice.org/protobuf-maven-plugin/compile-javanano-mojo.html) uses JavaNano generator (requires protobuf compiler version 3 or above) to compile main `.proto` definitions into Java files and attaches the generated Java sources to the project.
+ [protobuf:test-compile-javanano](https://www.xolstice.org/protobuf-maven-plugin/test-compile-javanano-mojo.html) uses JavaNano generator (requires protobuf compiler version 3 or above) to compile test `.proto` definitions into Java files and attaches the generated Java test sources to the project.

案例1（最佳实现）：

```xml
<build>
    <!-- os-maven-plugin 放在 extensions 中，可以将其导出的环境变量作用于build全局，
			对比案例2测试下就知道为何要将 os-maven-plugin 放到这个元素位置了 -->
    <extensions>
        <extension>
            <groupId>kr.motd.maven</groupId>
            <artifactId>os-maven-plugin</artifactId>
            <version>${os.plugin.version}</version>
        </extension>
    </extensions>
    <plugins>
        <plugin>
            <groupId>org.xolstice.maven.plugins</groupId>
            <artifactId>protobuf-maven-plugin</artifactId>
            <version>${protobuf.plugin.version}</version>
            <extensions>true</extensions>
            <configuration>
                <pluginId>grpc-java</pluginId>
                <!-- 工具版本 -->
                <protocArtifact>com.google.protobuf:protoc:${protobuf.version}:exe:${os.detected.classifier}</protocArtifact>
                <!--默认值，proto源文件路径，用默认的就好 -->
                <protoSourceRoot>${project.basedir}/src/main/proto</protoSourceRoot>
                <!--proto目标java文件路径， 默认值： ${project.basedir}/target/generated-sources/protobuf ，用默认的就好，不然代码提交时麻烦 -->
                <!-- 一般不推荐改这个 -->
                <!--<outputDirectory>${project.basedir}/src/main/java</outputDirectory>-->
                <!--设置是否在生成java文件之前清空outputDirectory的文件，默认值为true，设置为false时也会覆盖同名文件-->
                <clearOutputDirectory>false</clearOutputDirectory>
            </configuration>
            <executions>
                <execution>
                    <!--在执行mvn compile的时候会执行以下操作-->
                    <phase>compile</phase>
                    <goals>
                        <!--生成OuterClass类-->
                        <goal>compile</goal>
                        <!--生成Grpc类-->
                        <!--goal>compile-custom</goal-->
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
    <!-- 另外如果IDE、Maven无法自动失败生成的代码文件，可以通过在 sourceDirectories 下添加生成的代码文件目录  -->
    <sourceDirectories>
      <directory>${project.build.directory}/generated-sources/java/</directory>
    </sourceDirectories>
</build>
```

案例2：

```xml
<plugins>
    <!-- 经测试这样写，只有执行整体的构建如 mvn clean package，protobuf 插件才能识别到 ${os.detected.classifier} 
			单独执行 protobuf:compile会失败，不推荐这么写，推荐 案例1 中将 os-maven-plugin 放到 extensions 中
	-->
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
    <plugin>
        <groupId>org.xolstice.maven.plugins</groupId>
        <artifactId>protobuf-maven-plugin</artifactId>
        <version>${protobuf-maven-plugin.version}</version>
        <configuration>
            <!--
                      The version of protoc must match protobuf-java. If you don't depend on
                      protobuf-java directly, you will be transitively depending on the
                      protobuf-java version that grpc depends on.
                    -->
            <pluginId>grpc-java</pluginId>
            <!-- 指定 protoc, 方式1
					单独执行 protobuf:compile 时由于后面的配置方法拿不到${os.detected.classifier}，会报错，所以直接指定protoc可执行文件 
					如果前面个将 os-maven-plugin 放到 extensions 中，则可以使用方式2
					但是这种配置和环境相关，不方便，还是推荐方式2
			-->
            <protocExecutable>/opt/protoc/bin/protoc</protocExecutable>
            <!-- 指定 protoc, 方式2 -->
            <protocArtifact>
                com.google.protobuf:protoc:${com.google.protobuf.protoc.version}:exe:${os.detected.classifier}
            </protocArtifact>
            <pluginArtifact>
                io.grpc:protoc-gen-grpc-java:${protoc-gen-grpc-java.plugin.version}:exe:${os.detected.classifier}
            </pluginArtifact>
            <!-- proto文件路径 -->
            <!--<protoSourceRoot>${project.basedir}/src/main/proto</protoSourceRoot>-->
            <!-- 生成后的文件存放根路径, 默认 target/generated-sources/protobuf -->
            <!--<outputDirectory>${project.basedir}/src/main/java</outputDirectory>-->
            <!-- 是否在生成Java文件前清空outputDirectory的文件 -->
            <!--<clearOutputDirectory>false</clearOutputDirectory>-->
        </configuration>
        <executions>
            <execution>
                <id>grpc-build</id>
                <goals>
                    <goal>compile</goal>
                    <goal>compile-custom</goal>
                </goals>
            </execution>
        </executions>
    </plugin>
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-shade-plugin</artifactId>
        <version>3.0.0</version>
        <configuration>
            <createDependencyReducedPom>false</createDependencyReducedPom>
        </configuration>
        <executions>
            <execution>
                <phase>package</phase>
                <goals>
                    <goal>shade</goal>
                </goals>
                <configuration>
                    <filters>
                        <filter>
                            <artifact>*:*</artifact>
                            <excludes>
                                <exclude>**/module-info.class</exclude>
                            </excludes>
                        </filter>
                    </filters>
                    <transformers>
                        <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                            <manifestEntries>
                                <Premain-Class>top.kwseeker.bytecode.skywalking.SkyWalkingAgent</Premain-Class>
                            </manifestEntries>
                        </transformer>
                    </transformers>
                </configuration>
            </execution>
        </executions>
    </plugin>
</plugins>
```



### spring 

#### spring-boot-maven-plugin



## 插件案例

### skywalking-java java-agent pom.xml:

继承了 org.apache apache-21.pom，隐形继承了super pom，管理了4个子模块的构建。

#### java-agent pom.xml

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>org.apache.skywalking</groupId>
    <artifactId>java-agent</artifactId>
    <version>8.14.0</version>

    <!-- 继承 apache-21.pom -->
    <parent>
        <groupId>org.apache</groupId>
        <artifactId>apache</artifactId>
        <version>21</version>
        <relativePath />
    </parent>

    <modules>
        <module>apm-commons</module>
        <module>apm-protocol</module>
        <module>apm-sniffer</module>
        <module>apm-application-toolkit</module>
    </modules>
    <!-- 作为聚合模块，管理子模块依赖 -->
    <packaging>pom</packaging>

    <name>java-agent</name>
    <url>https://github.com/apache/skywalking-java</url>

    <!-- 代码版本管理信息 -->
    <scm>
        <url>https://github.com/apache/skywalking-java</url>
        <connection>scm:git:https://github.com/apache/skywalking-java.git</connection>
        <developerConnection>scm:git:https://github.com/apache/skywalking-java.git</developerConnection>
        <tag>v8.14.0</tag>
    </scm>

    <!-- 这里省略一些不重要的说明信息 -->

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <compiler.version>1.8</compiler.version>
        <powermock.version>2.0.7</powermock.version>
        <checkstyle.version>6.18</checkstyle.version>
        <junit.version>4.12</junit.version>
        <mockito-core.version>3.5.13</mockito-core.version>
        <lombok.version>1.18.20</lombok.version>

        <!-- core lib dependency -->
        <!-- 省略一些框架依赖 -->

        <!-- Plugin versions -->
        <docker.plugin.version>0.4.13</docker.plugin.version>
        <takari-maven-plugin.version>0.6.1</takari-maven-plugin.version>
        <exec-maven-plugin.version>1.6.0</exec-maven-plugin.version>
        <maven-antrun-plugin.version>1.8</maven-antrun-plugin.version>
        <maven-dependency-plugin.version>2.10</maven-dependency-plugin.version>
        <maven-deploy-plugin.version>2.8.2</maven-deploy-plugin.version>
        <maven-assembly-plugin.version>3.1.0</maven-assembly-plugin.version>
        <maven-failsafe-plugin.version>2.22.0</maven-failsafe-plugin.version>
        <build-helper-maven-plugin.version>3.2.0</build-helper-maven-plugin.version>
        <maven-jar-plugin.version>3.1.0</maven-jar-plugin.version>
        <maven-shade-plugin.version>3.1.1</maven-shade-plugin.version>
        <maven-enforcer-plugin.version>3.0.0-M2</maven-enforcer-plugin.version>
        <maven-compiler-plugin.version>3.8.0</maven-compiler-plugin.version>
        <maven-resource-plugin.version>3.1.0</maven-resource-plugin.version>
        <maven-source-plugin.version>3.0.1</maven-source-plugin.version>
        <versions-maven-plugin.version>2.5</versions-maven-plugin.version>
        <coveralls-maven-plugin.version>4.3.0</coveralls-maven-plugin.version>
        <maven-checkstyle-plugin.version>3.1.0</maven-checkstyle-plugin.version>
        <jmh.version>1.33</jmh.version>
        <gmaven-plugin.version>1.5</gmaven-plugin.version>
        <checkstyle.fails.on.error>true</checkstyle.fails.on.error>

    </properties>

    <profiles>
        <!-- 激活这个配置后，mvn exec:exec 时，会执行 git submodule update ... -->
        <profile>
            <id>all</id>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.codehaus.mojo</groupId>
                        <artifactId>exec-maven-plugin</artifactId>
                        <version>${exec-maven-plugin.version}</version>
                        <executions>
                            <execution>
                                <id>git submodule update</id>
                                <phase>initialize</phase>
                                <inherited>false</inherited>
                                <configuration>
                                    <executable>git</executable>
                                    <arguments>
                                        <argument>submodule</argument>
                                        <argument>update</argument>
                                        <argument>--init</argument>
                                        <argument>--recursive</argument>
                                    </arguments>
                                </configuration>
                                <goals>
                                    <goal>exec</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>
    </profiles>

    <dependencies>
        <!-- 省略 -->
    </dependencies>

    <dependencyManagement>
        <!-- 省略 -->
    </dependencyManagement>

    <build>
        <pluginManagement>
            <plugins>
                <!-- 用于安装Maven Wrapper到Maven项目
                    mvn -N io.takari:maven:wrapper -Dmaven=3.5.4 
                -->
                <plugin>
                    <groupId>io.takari</groupId>
                    <artifactId>maven</artifactId>
                    <version>${takari-maven-plugin.version}</version>
                </plugin>
                <!-- 用于执行Ant任务 -->
                <plugin>
                    <artifactId>maven-antrun-plugin</artifactId>
                    <version>${maven-antrun-plugin.version}</version>
                </plugin>
                <!-- 部署阶段将构建的构件部署到远程仓库 -->
                <plugin>
                    <artifactId>maven-deploy-plugin</artifactId>
                    <version>${maven-deploy-plugin.version}</version>
                </plugin>
                <!-- 将项目输出组合成一个可分发的归档文件 -->
                <plugin>
                    <artifactId>maven-assembly-plugin</artifactId>
                    <version>${maven-assembly-plugin.version}</version>
                </plugin>
                <!-- 用于执行集成测试 -->
                <plugin>
                    <artifactId>maven-failsafe-plugin</artifactId>
                    <version>${maven-failsafe-plugin.version}</version>
                </plugin>
                <!-- 用于构建 Jar -->
                <plugin>
                    <artifactId>maven-jar-plugin</artifactId>
                    <version>${maven-jar-plugin.version}</version>
                    <configuration>
                        <forceCreation>true</forceCreation>
                    </configuration>
                </plugin>
                <!-- 用于构建Shade Jar -->
                <plugin>
                    <artifactId>maven-shade-plugin</artifactId>
                    <version>${maven-shade-plugin.version}</version>
                </plugin>
                <!-- 支持自动生成镜像、推送到镜像仓库、启动容器 -->
                <plugin>
                    <groupId>io.fabric8</groupId>
                    <artifactId>docker-maven-plugin</artifactId>
                    <version>${maven-docker-plugin.version}</version>
                    <configuration>
                        <containerNamePattern>%a-%t-%i</containerNamePattern>
                    </configuration>
                </plugin>
            </plugins>
        </pluginManagement>
        <plugins>
            <!-- 构建过程中检查操作系统类型，并生成对应的系统变量 -->
            <plugin>
                <groupId>kr.motd.maven</groupId>
                <artifactId>os-maven-plugin</artifactId>
                <version>${os-maven-plugin.version}</version>
                <executions>
                    <!-- 定义在initialize阶段执行detect目标，并生成系统变量 -->
                    <execution>
                        <phase>initialize</phase>
                        <goals>
                            <goal>detect</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <!-- 校验阶段检查Java版本和Maven版本等信息 -->
            <plugin>
                <artifactId>maven-enforcer-plugin</artifactId>
                <version>${maven-enforcer-plugin.version}</version>
                <executions>
                    <execution>
                        <id>enforce-java</id>
                        <goals>
                            <goal>enforce</goal>
                        </goals>
                        <phase>validate</phase>
                        <configuration>
                            <rules>
                                <requireJavaVersion>
                                    <!-- Build has not yet been updated for Java 9+ -->
                                    <version>1.8</version>
                                </requireJavaVersion>
                                <requireMavenVersion>
                                    <version>3.6</version>
                                </requireMavenVersion>
                            </rules>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
            <!-- 用于编译项目的源代码 -->
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>${maven-compiler-plugin.version}</version>
                <configuration>
                    <source>${compiler.version}</source>
                    <target>${compiler.version}</target>
                    <encoding>${project.build.sourceEncoding}</encoding>
                </configuration>
            </plugin>
            <!-- 用于将项目资源复制到输出目录 -->
            <plugin>
                <artifactId>maven-resources-plugin</artifactId>
                <version>${maven-resource-plugin.version}</version>
                <configuration>
                    <encoding>${project.build.sourceEncoding}</encoding>
                </configuration>
            </plugin>
            <!-- 用于自动生成镜像并推送到docker仓库中 
                这里设置跳过了生成镜像
            -->
            <plugin>
                <groupId>com.spotify</groupId>
                <artifactId>docker-maven-plugin</artifactId>
                <version>${docker.plugin.version}</version>
                <configuration>
                    <skipDocker>true</skipDocker>
                </configuration>
            </plugin>
            <!-- 用于对源代码文件进行打包，生成 xxx-sources.jar文件 -->
            <plugin>
                <artifactId>maven-source-plugin</artifactId>
                <version>${maven-source-plugin.version}</version>
                <executions>
                    <execution>
                        <id>attach-sources</id>
                        <phase>none</phase>
                        <goals>
                            <goal>jar</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <!-- 用于代码风格检查 -->
            <plugin>
                <artifactId>maven-checkstyle-plugin</artifactId>
                <version>${maven-checkstyle-plugin.version}</version>
                <configuration>
                    <!-- checkstyle文件的位置 -->
                    <configLocation>${maven.multiModuleProjectDirectory}/apm-checkstyle/checkStyle.xml</configLocation>
                    <!-- License文件的位置，用于校验源码是否有正确的 lincense 头 -->
                    <headerLocation>${maven.multiModuleProjectDirectory}/apm-checkstyle/CHECKSTYLE_HEAD</headerLocation>
                    <encoding>UTF-8</encoding>
                    <!-- 是否将校验错误信息输出到终端 -->
                    <consoleOutput>true</consoleOutput>
                    <!-- 是否检查测试源码风格 -->
                    <includeTestSourceDirectory>true</includeTestSourceDirectory>
                    <!-- 校验风格错误时是否让构建失败，默认true -->
                    <failOnViolation>${checkstyle.fails.on.error}</failOnViolation>
                    <!-- 校验风格的源码文件目录 -->
                    <sourceDirectories>
                        <sourceDirectory>${project.build.sourceDirectory}</sourceDirectory>
                        <sourceDirectory>${project.build.testSourceDirectory}</sourceDirectory>
                        <sourceDirectory>scenarios/resttemplate-6.x-scenario</sourceDirectory>
                    </sourceDirectories>
                    <!-- 需要校验风格的资源文件过滤器 -->
                    <resourceIncludes>
                        **/*.properties,
                        **/*.sh,
                        **/*.bat,
                        **/*.yml,
                        **/*.yaml,
                        **/*.xml
                    </resourceIncludes>
                    <!-- 需要跳过校验的资源文件过滤器 -->
                    <resourceExcludes>
                        **/.asf.yaml,
                        **/.github/**,
                        **/skywalking-agent-version.properties
                    </resourceExcludes>
                    <!-- 需要跳过校验的源码文件过滤器 -->
                    <excludes>
                        **/target/generated-test-sources/**,
                        org/apache/skywalking/apm/network/register/v2/**/*.java,
                        org/apache/skywalking/apm/network/common/**/*.java,
                        org/apache/skywalking/apm/network/servicemesh/**/*.java,
                        org/apache/skywalking/apm/network/language/**/*.java,
                        org/apache/skywalking/oap/server/core/remote/grpc/proto/*.java,
                        org/apache/skywalking/oal/rt/grammar/*.java,
                        org/apache/skywalking/oap/server/exporter/grpc/*.java,
                        org/apache/skywalking/oap/server/configuration/service/*.java,
                        **/jmh_generated/*_jmhType*.java,
                        **/jmh_generated/*_jmhTest.java
                    </excludes>
                    <!-- propertyExpansion 属性拓展，用于设置额外的检查配置文件、日志输出文件、排除路径等，以及其他一些配置属性的值。 -->
                    <propertyExpansion>
                        import.control=${maven.multiModuleProjectDirectory}/apm-checkstyle/importControl.xml
                    </propertyExpansion>
                </configuration>
                <executions>
                    <!-- process-sources阶段执行check目标 -->
                    <execution>
                        <id>validate</id>
                        <phase>process-sources</phase>
                        <goals>
                            <goal>check</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
```

#### org.apache apache-21.pom

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <!-- for more information, see the documentation of this POM: http://maven.apache.org/pom/asf/ -->
  <groupId>org.apache</groupId>
  <artifactId>apache</artifactId>
  <version>21</version>
  <packaging>pom</packaging>

  <name>The Apache Software Foundation</name>

  <!-- 删除一些 description url organization licenses mailingLists  -->

  <scm>
    <connection>scm:git:https://gitbox.apache.org/repos/asf/maven-apache-parent.git</connection>
    <developerConnection>scm:git:https://gitbox.apache.org/repos/asf/maven-apache-parent.git</developerConnection>
    <url>https://github.com/apache/maven-apache-parent/tree/${project.scm.tag}</url>
    <tag>apache-21</tag>
  </scm>

  <!-- 版本发布管理 -->
  <distributionManagement>
    <repository>
      <id>apache.releases.https</id>
      <name>Apache Release Distribution Repository</name>
      <!--　为何不是 https://repo.maven.apache.org/maven2 -->
      <url>https://repository.apache.org/service/local/staging/deploy/maven2</url>
    </repository>
    <snapshotRepository>
      <id>apache.snapshots.https</id>
      <name>${distMgmtSnapshotsName}</name>
      <url>${distMgmtSnapshotsUrl}</url>
    </snapshotRepository>
  </distributionManagement>

  <properties>
    <distMgmtSnapshotsName>Apache Development Snapshot Repository</distMgmtSnapshotsName>
    <distMgmtSnapshotsUrl>https://repository.apache.org/content/repositories/snapshots</distMgmtSnapshotsUrl>
    <organization.logo>https://www.apache.org/images/asf_logo_wide.gif</organization.logo>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    <sourceReleaseAssemblyDescriptor>source-release</sourceReleaseAssemblyDescriptor>
    <gpg.useagent>true</gpg.useagent>
    <arguments />
    <maven.compiler.source>1.7</maven.compiler.source>
    <maven.compiler.target>1.7</maven.compiler.target>
    <surefire.version>2.22.0</surefire.version>
    <assembly.tarLongFileMode>posix</assembly.tarLongFileMode>
  </properties>

  <build>
    <pluginManagement>
      <plugins>
        <!-- set versions of common plugins for reproducibility, ordered alphabetically -->
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-antrun-plugin</artifactId>
          <version>1.8</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-assembly-plugin</artifactId>
          <version>3.0.0</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-clean-plugin</artifactId>
          <version>3.1.0</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.7.0</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-dependency-plugin</artifactId>
          <version>3.1.1</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-deploy-plugin</artifactId>
          <version>2.8.2</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-docck-plugin</artifactId>
          <version>1.1</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-ear-plugin</artifactId>
          <version>3.0.1</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-enforcer-plugin</artifactId>
          <version>1.4.1</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-failsafe-plugin</artifactId>
          <version>${surefire.version}</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-gpg-plugin</artifactId>
          <version>1.6</version>
          <configuration>
            <gpgArguments>
              <arg>--digest-algo=SHA512</arg>
            </gpgArguments>
          </configuration>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-help-plugin</artifactId>
          <version>3.1.0</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-install-plugin</artifactId>
          <version>2.5.2</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-invoker-plugin</artifactId>
          <version>3.1.0</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-jar-plugin</artifactId>
          <version>3.1.0</version>
          <configuration>
            <archive>
              <manifest>
                <addDefaultSpecificationEntries>true</addDefaultSpecificationEntries>
                <addDefaultImplementationEntries>true</addDefaultImplementationEntries>
              </manifest>
            </archive>
          </configuration>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-javadoc-plugin</artifactId>
          <version>3.0.1</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-plugin-plugin</artifactId>
          <version>3.5.2</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-project-info-reports-plugin</artifactId>
          <version>3.0.0</version>
        </plugin>
        <!-- START SNIPPET: release-plugin-configuration -->
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-release-plugin</artifactId>
          <version>2.5.3</version>
          <configuration>
            <useReleaseProfile>false</useReleaseProfile>
            <goals>deploy</goals>
            <arguments>-Papache-release ${arguments}</arguments>
            <waitBeforeTagging>10</waitBeforeTagging>
          </configuration>
        </plugin>
        <!-- END SNIPPET: release-plugin-configuration -->
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-remote-resources-plugin</artifactId>
          <version>1.5</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-resources-plugin</artifactId>
          <version>3.1.0</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-scm-plugin</artifactId>
          <version>1.9.5</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-scm-publish-plugin</artifactId>
          <version>3.0.0</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-site-plugin</artifactId>
          <version>3.7.1</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-source-plugin</artifactId>
          <version>3.0.1</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-surefire-plugin</artifactId>
          <version>${surefire.version}</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-surefire-report-plugin</artifactId>
          <version>${surefire.version}</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-war-plugin</artifactId>
          <version>3.2.2</version>
        </plugin>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-shade-plugin</artifactId>
          <version>3.1.1</version>
        </plugin>
        <plugin>
          <groupId>org.apache.rat</groupId>
          <artifactId>apache-rat-plugin</artifactId>
          <version>0.12</version>
        </plugin>
        <plugin>
          <groupId>org.codehaus.mojo</groupId>
          <artifactId>clirr-maven-plugin</artifactId>
          <version>2.8</version>
        </plugin>
      </plugins>
    </pluginManagement>
    <plugins>
      <!-- We want to package up license resources in the JARs produced -->
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-remote-resources-plugin</artifactId>
        <executions>
          <execution>
            <id>process-resource-bundles</id>
            <goals>
              <goal>process</goal>
            </goals>
            <configuration>
              <resourceBundles>
                <resourceBundle>org.apache:apache-jar-resource-bundle:1.4</resourceBundle>
              </resourceBundles>
            </configuration>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-enforcer-plugin</artifactId>
        <executions>
          <execution>
            <id>enforce-maven-version</id>
            <goals>
              <goal>enforce</goal>
            </goals>
            <configuration>
              <rules>
                <requireMavenVersion>
                  <version>3.0.5</version>
                </requireMavenVersion>
              </rules>
            </configuration>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-site-plugin</artifactId>
        <executions>
          <execution>
            <id>attach-descriptor</id>
            <goals>
              <goal>attach-descriptor</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>

  <profiles>
    <!-- START SNIPPET: release-profile -->
    <profile>
      <id>apache-release</id>
      <build>
        <plugins>
          <!-- Create a source-release artifact that contains the fully buildable
               project directory source structure. This is the artifact which is
               the official subject of any release vote. -->
          <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-assembly-plugin</artifactId>
            <dependencies>
              <dependency>
                <groupId>org.apache.apache.resources</groupId>
                <artifactId>apache-source-release-assembly-descriptor</artifactId>
                <version>1.0.6</version>
              </dependency>
            </dependencies>
            <executions>
              <execution>
                <id>source-release-assembly</id>
                <phase>package</phase>
                <goals>
                  <goal>single</goal>
                </goals>
                <configuration>
                  <runOnlyAtExecutionRoot>true</runOnlyAtExecutionRoot>
                  <descriptorRefs>
                    <descriptorRef>${sourceReleaseAssemblyDescriptor}</descriptorRef>
                  </descriptorRefs>
                  <tarLongFileMode>posix</tarLongFileMode>
                </configuration>
              </execution>
            </executions>
          </plugin>
          <!-- We want to deploy the artifact to a staging location for perusal -->
          <plugin>
            <inherited>true</inherited>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-deploy-plugin</artifactId>
            <configuration>
              <updateReleaseInfo>true</updateReleaseInfo>
            </configuration>
          </plugin>
          <plugin>
            <groupId>org.apache.maven.plugins</groupId>
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
            <groupId>org.apache.maven.plugins</groupId>
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
          <!-- We want to sign the artifact, the POM, and all attached artifacts -->
          <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-gpg-plugin</artifactId>
            <executions>
              <execution>
                <id>sign-release-artifacts</id>
                <goals>
                  <goal>sign</goal>
                </goals>
              </execution>
            </executions>
          </plugin>
          <!-- calculate checksums of source release for Apache dist area -->
          <plugin>
            <groupId>net.nicoulaj.maven.plugins</groupId>
            <artifactId>checksum-maven-plugin</artifactId>
            <version>1.7</version>
            <executions>
              <execution>
                <id>source-release-checksum</id>
                <goals>
                  <goal>files</goal>
                </goals>
              </execution>
            </executions>
            <configuration>
              <algorithms>
                <algorithm>SHA-512</algorithm>
              </algorithms>
              <csvSummary>false</csvSummary>
              <fileSets>
                <fileSet>
                  <directory>${project.build.directory}</directory>
                  <includes>
                    <include>${project.artifactId}-${project.version}-source-release.zip</include>
                    <include>${project.artifactId}-${project.version}-source-release.tar*</include>
                  </includes>
                </fileSet>
              </fileSets>
              <failIfNoFiles>false</failIfNoFiles><!-- usually, no file to do checksum: don't consider error -->
            </configuration>
          </plugin>
        </plugins>
      </build>
    </profile>
    <!-- END SNIPPET: release-profile -->
  </profiles>
</project>
```

####  apm-commons pom.xml

也是一个聚合项目，包含 apm-util apm-datacarrier 两个子模块。这两个子模块依赖比较简单，略。

#### apm-protocol pom.xml

也是一个聚合项目，包含 apm-network 子模块。只分析其插件部分。

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
     ...
    <build>
        <plugins>
            <!-- 初始化构建状态阶段执行detect目标，生成系统环境变量 
					这里的环境变量是给 protobuf-maven-plugin用的
			-->
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
            <!-- 将 protocol buffers compiler（protoc）集成到 Maven 生命周期中 -->
            <plugin>
                <groupId>org.xolstice.maven.plugins</groupId>
                <artifactId>protobuf-maven-plugin</artifactId>
                <version>${protobuf-maven-plugin.version}</version>
                <configuration>
                    <!--
                      The version of protoc must match protobuf-java. If you don't depend on
                      protobuf-java directly, you will be transitively depending on the
                      protobuf-java version that grpc depends on.
                    -->
                    <!-- protoc 编译器版本 -->
                    <protocArtifact>
                        com.google.protobuf:protoc:${com.google.protobuf.protoc.version}:exe:${os.detected.classifier}
                    </protocArtifact>
                    <pluginId>grpc-java</pluginId>
                    <!-- protoc 插件版本 -->
                    <pluginArtifact>
                        io.grpc:protoc-gen-grpc-java:${protoc-gen-grpc-java.plugin.version}:exe:${os.detected.classifier}
                    </pluginArtifact>
                </configuration>
                <executions>
                    <execution>
                        <id>grpc-build</id>
                        <goals>
                            <goal>compile</goal>
                            <goal>compile-custom</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
```

#### apm-sniffer pom.xml

也是一个聚合项目，包含多个子模块。

```xml
    <modules>
        <module>apm-agent</module>
        <module>apm-agent-core</module>
        <module>apm-sdk-plugin</module>
        <module>apm-toolkit-activation</module>
        <module>apm-test-tools</module>
        <module>bootstrap-plugins</module>
        <module>optional-plugins</module>
        <module>optional-reporter-plugins</module>
    </modules>

    <properties>
        <shade.package>org.apache.skywalking.apm.dependencies</shade.package>
    </properties>
```

只分析apm-agent。

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.apache.skywalking</groupId>
        <artifactId>java-agent-sniffer</artifactId>
        <version>8.14.0</version>
    </parent>

    <artifactId>apm-agent</artifactId>
    <packaging>jar</packaging>

    <name>apm-agent</name>
    <url>http://maven.apache.org</url>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <premain.class>org.apache.skywalking.apm.agent.SkyWalkingAgent</premain.class>
        <can.redefine.classes>true</can.redefine.classes>
        <can.retransform.classes>true</can.retransform.classes>
        <shade.net.bytebuddy.source>net.bytebuddy</shade.net.bytebuddy.source>
        <shade.net.bytebuddy.target>${shade.package}.${shade.net.bytebuddy.source}</shade.net.bytebuddy.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.apache.skywalking</groupId>
            <artifactId>apm-agent-core</artifactId>
            <version>${project.version}</version>
        </dependency>
    </dependencies>

    <build>
        <finalName>skywalking-agent</finalName>
        <plugins>
            <!-- 打包 shade Jar -->
            <plugin>
                <artifactId>maven-shade-plugin</artifactId>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <!-- 是否将 shaded artifact 作为附加的构件进行发布。默认值为 true 
                                设置为 true 时，Maven 将会在构建项目后将 shaded artifact 发布到 Maven 仓库中，并将其作为项目的一个附加构件来发布。
                                用户可以通过 classifier 选择依赖附加构件还是依赖原始构件
                                <classifier>shaded</classifier>
                            -->
                            <shadedArtifactAttached>false</shadedArtifactAttached>
                            <!-- 是否创建已减少依赖的 POM 文件。默认值为 true，表示创建已减少依赖的 POM 文件 -->
                            <createDependencyReducedPom>true</createDependencyReducedPom>
                            <!-- 是否创建包含源代码的 JAR 文件。默认值为 true，表示创建包含源代码的 JAR 文件 -->
                            <createSourcesJar>true</createSourcesJar>
                            <!-- 是否将依赖项的源代码包含在 shaded artifact 中，默认值为 true -->
                            <shadeSourcesContent>true</shadeSourcesContent>
                            <transformers>
                                <!-- 在MANIFEST.MF中设置 Premain-Class、Can-Redefine-Classes Can-Retransform-Classes -->
                                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <manifestEntries>
                                        <Premain-Class>${premain.class}</Premain-Class>
                                        <Can-Redefine-Classes>${can.redefine.classes}</Can-Redefine-Classes>
                                        <Can-Retransform-Classes>${can.retransform.classes}</Can-Retransform-Classes>
                                    </manifestEntries>
                                </transformer>
                            </transformers>
                            <artifactSet>
                                <!-- 排除不需要的依赖，不会被打包到 shade Jar -->
                                <excludes>
                                    <exclude>*:gson</exclude>
                                    <exclude>io.grpc:*</exclude>
                                    <exclude>io.netty:*</exclude>
                                    <exclude>io.opencensus:*</exclude>
                                    <exclude>com.google.*:*</exclude>
                                    <exclude>com.google.guava:guava</exclude>
                                    <exclude>org.checkerframework:checker-compat-qual</exclude>
                                    <exclude>org.codehaus.mojo:animal-sniffer-annotations</exclude>
                                    <exclude>io.perfmark:*</exclude>
                                    <exclude>org.slf4j:*</exclude>
                                </excludes>
                            </artifactSet>
                            <!-- 重定位class文件，防止因为class冲突导致类加载失败
                                net.bytebuddy 打包到 org.apache.skywalking.apm.dependencies.net.bytebuddy 目录
                            -->
                            <relocations>
                                <relocation>
                                    <pattern>${shade.net.bytebuddy.source}</pattern>
                                    <shadedPattern>${shade.net.bytebuddy.target}</shadedPattern>
                                </relocation>
                            </relocations>
                            <!-- 排除打包文件 net.bytebuddy:byte-buddy META-INF/versions/9/module-info.class -->
                            <filters>
                                <filter>
                                    <artifact>net.bytebuddy:byte-buddy</artifact>
                                    <excludes>
                                        <exclude>META-INF/versions/9/module-info.class</exclude>
                                    </excludes>
                                </filter>
                            </filters>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <artifactId>maven-antrun-plugin</artifactId>
                <executions>
                    <!-- mvn clean 时删除目录 ${project.basedir}/../../skywalking-agent -->
                    <execution>
                        <id>clean</id>
                        <phase>clean</phase>
                        <goals>
                            <goal>run</goal>
                        </goals>
                        <configuration>
                            <target>
                                <delete dir="${project.basedir}/../../skywalking-agent" />
                            </target>
                        </configuration>
                    </execution>
                    <!-- 打包时创建一些文件夹并拷贝文件 -->
                    <execution>
                        <id>package</id>
                        <phase>package</phase>
                        <goals>
                            <goal>run</goal>
                        </goals>
                        <configuration>
                            <target>
                                <mkdir dir="${project.basedir}/../../skywalking-agent" />
                                <copy file="${project.build.directory}/skywalking-agent.jar" tofile="${project.basedir}/../../skywalking-agent/skywalking-agent.jar" overwrite="true" />
                                <mkdir dir="${project.basedir}/../../skywalking-agent/config" />
                                <mkdir dir="${project.basedir}/../../skywalking-agent/logs" />
                                <copydir src="${project.basedir}/../config" dest="${project.basedir}/../../skywalking-agent/config" forceoverwrite="true" />
                                <copydir src="${project.basedir}/../../dist-material" dest="${project.basedir}/../../skywalking-agent" />
                            </target>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>

</project>
```

#### apm-application-toolkit pom.xml
