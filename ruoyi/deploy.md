
# 数据库初始化

## 创库

```
create database if not exists `ry-config`;
create database if not exists `ry-cloud`;
```
## 创表
1. 进入ruoyi-cloud 代码仓
2. 执行 ry_*.sql            
3. 执行 ry_config_*.sql



# nacos部署

nacos版本： 2.3.2

##  下载对应版本解压

## 数据库配置

修改 ${nacos_home}/conf/application.properties

```
# db mysql
spring.datasource.platform=mysql
db.num=1
db.url.0=jdbc:mysql://localhost:3306/ry-config?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useUnicode=true&useSSL=false&serverTimezone=UTC
db.user.0=root
db.password.0=
```

## 启动nacos服务
```
cd ${nacos_home}
sh bin/startup.sh -m standalone     // 启动
sh bin/shutdown.sh                  // 关闭
```

## nacos配置
进入nacos管理页面 `http://127.0.0.1:8848/nacos/`
配置管理中添加 数据库连接，redis连接等微服务共享配置，示例如下：
```
mybatis:
  mapper-locations: classpath*:mapper/**/*.xml
spring:
  datasource:
    dynamic:
      primary: one
      datasource:
        one:
          url: jdbc:mysql://127.0.0.1:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B8&allowMultiQueries=true
          driver-class-name: com.mysql.cj.jdbc.Driver
          username: root
```

# 启动若依模块

cd /root/gs/melon-cloud
## ruoyi-gateway
java -jar ruoyi-gateway/target/ruoyi-gateway.jar &
## ruoyi-auth
java -jar ruoyi-auth/target/ruoyi-auth.jar &
## ruoyi-system
java -jar ruoyi-modules/ruoyi-system/target/ruoyi-modules-system.jar &
## ruoyi-gen
java -jar ruoyi-modules/ruoyi-gen/target/ruoyi-modules-gen.jar &


# 参考部署文档
1. nacos [https://nacos.io/zh-cn/docs/v2/quickstart/quick-start.html](https://nacos.io/zh-cn/docs/v2/quickstart/quick-start.html)
2. ruoyi [https://doc.ruoyi.vip/ruoyi-cloud/document/hjbs.html#%E5%87%86%E5%A4%87%E5%B7%A5%E4%BD%9C](https://doc.ruoyi.vip/ruoyi-cloud/document/hjbs.html#%E5%87%86%E5%A4%87%E5%B7%A5%E4%BD%9C)



