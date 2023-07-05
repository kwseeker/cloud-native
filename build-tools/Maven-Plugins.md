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

### surefire

### jar

### war

### shade

### source

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

提供了从Maven中运行Ant任务的能力。官方推荐将任务定义在 build.xml。

目标：

+ [antrun:run](https://maven.apache.org/plugins/maven-antrun-plugin/run-mojo.html) runs Ant tasks for Maven.

案例：

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

### assembly

assembly 是装配、组合的意思。

此插件能够将项目输出组合成一个可分发的归档文件，该归档文件还包含依赖项、模块、站点文档和其他文件。



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



## 插件案例

### skywalking-java java-agent pom.xml:

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>org.apache.skywalking</groupId>
    <artifactId>java-agent</artifactId>
    <version>8.14.0</version>
    
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
    <packaging>pom</packaging>

    <name>java-agent</name>
    <url>https://github.com/apache/skywalking-java</url>

    <scm>
        <url>https://github.com/apache/skywalking-java</url>
        <connection>scm:git:https://github.com/apache/skywalking-java.git</connection>
        <developerConnection>scm:git:https://github.com/apache/skywalking-java.git</developerConnection>
        <tag>v8.14.0</tag>
    </scm>

    <issueManagement>
        <system>GitHub</system>
        <url>https://github.com/apache/skywalking/issues</url>
    </issueManagement>

    <licenses>
        <license>
            <name>The Apache Software License, Version 2.0</name>
            <url>https://www.apache.org/licenses/LICENSE-2.0.txt</url>
        </license>
    </licenses>

    <mailingLists>
        <mailingList>
            <name>SkyWalking Developer List</name>
            <post>dev@skywalking.apache.org</post>
            <subscribe>dev-subscribe@skywalking.apache.org</subscribe>
            <unsubscribe>dev-unsubscribe@skywalking.apache.org</unsubscribe>
        </mailingList>
        <mailingList>
            <name>SkyWalking Commits</name>
            <post>commits@skywalking.apache.org</post>
            <subscribe>commits-subscribe@skywalking.apache.org</subscribe>
            <unsubscribe>commits-unsubscribe@skywalking.apache.org</unsubscribe>
        </mailingList>
    </mailingLists>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <compiler.version>1.8</compiler.version>
        <powermock.version>2.0.7</powermock.version>
        <checkstyle.version>6.18</checkstyle.version>
        <junit.version>4.12</junit.version>
        <mockito-core.version>3.5.13</mockito-core.version>
        <lombok.version>1.18.20</lombok.version>

        <!-- core lib dependency -->
        <bytebuddy.version>1.12.19</bytebuddy.version>
        <grpc.version>1.50.0</grpc.version>
        <netty.version>4.1.86.Final</netty.version>
        <gson.version>2.8.9</gson.version>
        <os-maven-plugin.version>1.6.2</os-maven-plugin.version>
        <protobuf-maven-plugin.version>0.6.1</protobuf-maven-plugin.version>
        <com.google.protobuf.protoc.version>3.21.7</com.google.protobuf.protoc.version>
        <protoc-gen-grpc-java.plugin.version>1.50.0</protoc-gen-grpc-java.plugin.version>
        <netty-tcnative-boringssl-static.version>2.0.48.Final</netty-tcnative-boringssl-static.version>
        <javax.annotation-api.version>1.3.2</javax.annotation-api.version>
        <objenesis.version>3.1</objenesis.version>
        <!-- necessary for Java 9+ -->
        <org.apache.tomcat.annotations-api.version>6.0.53</org.apache.tomcat.annotations-api.version>

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
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.powermock</groupId>
            <artifactId>powermock-module-junit4</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.powermock</groupId>
            <artifactId>powermock-api-mockito2</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>net.bytebuddy</groupId>
            <artifactId>byte-buddy-agent</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.objenesis</groupId>
            <artifactId>objenesis</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.openjdk.jmh</groupId>
            <artifactId>jmh-core</artifactId>
            <version>${jmh.version}</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>${lombok.version}</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>javax.annotation</groupId>
            <artifactId>javax.annotation-api</artifactId>
            <version>${javax.annotation-api.version}</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>${junit.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.mockito</groupId>
                <artifactId>mockito-core</artifactId>
                <version>${mockito-core.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.powermock</groupId>
                <artifactId>powermock-module-junit4</artifactId>
                <version>${powermock.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.powermock</groupId>
                <artifactId>powermock-api-mockito2</artifactId>
                <version>${powermock.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>net.bytebuddy</groupId>
                <artifactId>byte-buddy-agent</artifactId>
                <version>${bytebuddy.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.objenesis</groupId>
                <artifactId>objenesis</artifactId>
                <version>${objenesis.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.openjdk.jmh</groupId>
                <artifactId>jmh-generator-annprocess</artifactId>
                <version>${jmh.version}</version>
                <scope>test</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <build>
        <pluginManagement>
            <plugins>
                <!-- mvn -N io.takari:maven:wrapper -Dmaven=3.5.4 -->
                <plugin>
                    <groupId>io.takari</groupId>
                    <artifactId>maven</artifactId>
                    <version>${takari-maven-plugin.version}</version>
                </plugin>
                <plugin>
                    <artifactId>maven-antrun-plugin</artifactId>
                    <version>${maven-antrun-plugin.version}</version>
                </plugin>
                <plugin>
                    <artifactId>maven-deploy-plugin</artifactId>
                    <version>${maven-deploy-plugin.version}</version>
                </plugin>
                <plugin>
                    <artifactId>maven-assembly-plugin</artifactId>
                    <version>${maven-assembly-plugin.version}</version>
                </plugin>
                <plugin>
                    <artifactId>maven-failsafe-plugin</artifactId>
                    <version>${maven-failsafe-plugin.version}</version>
                </plugin>
                <plugin>
                    <artifactId>maven-jar-plugin</artifactId>
                    <version>${maven-jar-plugin.version}</version>
                    <configuration>
                        <forceCreation>true</forceCreation>
                    </configuration>
                </plugin>
                <plugin>
                    <artifactId>maven-shade-plugin</artifactId>
                    <version>${maven-shade-plugin.version}</version>
                </plugin>
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
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>${maven-compiler-plugin.version}</version>
                <configuration>
                    <source>${compiler.version}</source>
                    <target>${compiler.version}</target>
                    <encoding>${project.build.sourceEncoding}</encoding>
                </configuration>
            </plugin>
            <plugin>
                <artifactId>maven-resources-plugin</artifactId>
                <version>${maven-resource-plugin.version}</version>
                <configuration>
                    <encoding>${project.build.sourceEncoding}</encoding>
                </configuration>
            </plugin>
            <plugin>
                <groupId>com.spotify</groupId>
                <artifactId>docker-maven-plugin</artifactId>
                <version>${docker.plugin.version}</version>
                <configuration>
                    <skipDocker>true</skipDocker>
                </configuration>
            </plugin>
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
        </plugins>
    </build>
</project>
```

