# Maven settings.xml 配置

官方文档：[Settings Reference](https://maven.apache.org/settings.html)

文件位置：

1. `M2_HOME/conf/settings.xml`
2. `{user.home}/.m2/settings.xml`



## 配置项说明

参考官方文档。

顶级配置元素：

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">
  <localRepository/>
  <interactiveMode/>
  <offline/>
  <pluginGroups/>
  <servers/>
  <mirrors/>
  <proxies/>
  <profiles/>
  <activeProfiles/>
</settings>
```

### Profiles 中配置私服 Repositories

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">
  ...
  <profiles>
    <profile>
      ...
      <repositories>
        <repository>
          <id>codehausSnapshots</id>
          <name>Codehaus Snapshots</name>
          <!-- releases 和 snapshots 分别是针对发布版和快照版的配置，POM 文件可以在一个仓库中独立地对这两种类型的 artifact 进行配置。
          例如，可以只允许下载快照版，用于开发目的。 
          releases 是默认开启的，而 snapshots 是默认关闭的。
          -->
          <releases>
            <enabled>false</enabled>
            <!-- 更新检查的策略，Maven 会将本地 POM 文件（保存在仓库的 maven-metadata 文件中）的时间戳与远程仓库进行比较。
            可选值为 always、daily（默认值）、interval:X（X 为整数分钟）或 never。 
            -->
            <updatePolicy>always</updatePolicy>
            <!-- 对于 checksum 文件丢失或错误时的处理方式，可选值为 ignore、fail 或 warn。 -->
            <checksumPolicy>warn</checksumPolicy>
          </releases>
          <snapshots>
            <enabled>true</enabled>
            <updatePolicy>never</updatePolicy>
            <checksumPolicy>fail</checksumPolicy>
          </snapshots>
          <url>http://snapshots.maven.codehaus.org/maven2</url>
          <!-- 仓库布局 -->
          <layout>default</layout>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <id>myPluginRepo</id>
          <name>My Plugins repo</name>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <url>https://maven-central-eu....com/maven2/</url>
        </pluginRepository>
      </pluginRepositories>
      ...
    </profile>
  </profiles>
  ...
</settings>
```



## 配置问题解决备忘

### 私服仓库和阿里云镜像无法同时使用

公司私服无法和阿里云镜像同时使用，排查其实是因为仓库ID取名的问题，另外本地阿里云镜像配置 mirrorOf 也有问题。

这里复现下问题，里面敏感内容已经和谐。

**私服配置**:

server定义用户名密码， profile 定义私服仓库 repository。

```xml
<servers>
    <server>
        <username>kwseeker</username>
        <password>password</password>
        <id>central</id>
    </server>
    <server>
        <username>kwseeker</username>
        <password>password</password>
        <id>snapshots</id>
    </server>
</servers>

<profiles>
    <profile>
        <id>artifactory</id>
        <repositories>
            <repository>
                <id>central</id>
                <name>myrepo-public</name>
                <snapshots>
                    <enabled>false</enabled>
                </snapshots>
                <url>https://xxx/artifactory/myrepo-public</url>
            </repository>
            <repository>
                 <id>snapshots</id>
                <name>myrepo-public</name>
                <snapshots />
                <url>https://xxx/artifactory/myrepo-public</url>
            </repository>
            <!-- 这里添加阿里云镜像仓库 -->
        </repositories>
        <pluginRepositories>
            <pluginRepository>
                <id>central</id>
                <name>myrepo-public</name>
                <snapshots>
                    <enabled>false</enabled>
                </snapshots>
                <url>https://xxx/artifactory/myrepo-public</url>
            </pluginRepository>
            <pluginRepository>
                <id>snapshots</id>
                <name>myrepo-public</name>
                <snapshots />
                <url>https://xxx/artifactory/myrepo-public</url>
            </pluginRepository>
            <!-- 这里添加阿里云镜像仓库 -->
        </pluginRepositories>
    </profile>
</profiles>
```

**阿里云镜像**：

```xml
<mirrors>
    <mirror>
        <id>alimaven</id>
       <!-- <mirrorOf>*</mirrorOf>-->
        <mirrorOf>central</mirrorOf>
        <name>阿里云公共仓库</name>
        <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
</mirrors>
```

**分析原因**：

开始是配置的` <mirrorOf>*</mirrorOf`，参考《Maven实战》C6.7，mirrorOf 为 * 表示此镜像为所有Maven远程仓库的镜像，自然也会被当作私服的镜像，应该改为 central 将作为中央仓库的镜像。

**这个 central 的来源其实是来源于超级 pom 文件，里面有配置 id 为 central 的仓库为 Maven 官方的仓库**。上面私服配置的id也叫 central 的话明显会覆盖 Maven官方的仓库, !!!这样设置是不对的，不应该这么设置。但是公司已经这么配置了很久了，不方便改id，本地想同时用阿里云怎么办？

其实还可以在私服下面直接添加配置阿里云的仓库（可以配置多个仓库），不是用镜像的方式：

```xml
<repository>
    <id>aliyun</id>
    <url>https://maven.aliyun.com/repository/public</url>
    <releases>
   		<enabled>true</enabled>
    </releases>
</repository>

<pluginRepository>
    <id>central</id>
    <url>https://maven.aliyun.com/repository/public</url>
    <releases>
        <enabled>true</enabled>
    </releases>
    <snapshots>
        <enabled>true</enabled>
    </snapshots>
</pluginRepository>
```







