## 简介

使用docker来构建你的专属esp8266编译环境。

## 使用

1. 根据Dockerfile来构建你自己的镜像

   ```shell
   # -t 镜像名:tag版本号
   docker build -t esp8266_build:0.3 .
   ```

   如果没有意外，则会生成一个新的镜像

   ```shell
   ...
   Removing intermediate container 06a113df7d71
    ---> 169c91ec4473
   Step 18/19 : CMD echo "----end----"
    ---> Running in 1525cda390c2
   Removing intermediate container 1525cda390c2
    ---> d3971d2e0475
   Step 19/19 : CMD /bin/bash
    ---> Running in eb2fd55115ec
   Removing intermediate container eb2fd55115ec
    ---> 634717b38dab
   Successfully built 634717b38dab
   Successfully tagged esp8266_build:0.3
   [root@VM-87-165-centos /home/docker_esp8266_build]# docker images
   REPOSITORY            TAG       IMAGE ID       CREATED          SIZE
   esp8266_build         0.3       634717b38dab   18 seconds ago   696MB
   ```

   

2. 运行该镜像

   ```shell
   # -v 你主机的项目路径:docker容器的路径
   docker run -it -v /home/docker_test:/home/esp8266_proj 634717b38dab /bin/bash
   ```

3. 编译你自己的项目

```shell
# 进入到刚才挂载的 /home/esp8266_proj目录下
# 找到你的项目 直接编译
[root@7309b04f134c dynreg_demo]# pwd
/home/esp8266_proj/lesson1/dynreg_demo
[root@7309b04f134c dynreg_demo]# make -j8
# 编译完成生成可执行文件 烧录到esp8266

To flash all build output, run 'make flash' or:
python /home/esp8266/ESP8266_RTOS_SDK/components/esptool_py/esptool/esptool.py --chip esp8266 --port /dev/ttyUSB0 --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 40m --flash_size 4MB 0x0000 /home/esp8266_proj/lesson1/dynreg_demo/build/bootloader/bootloader.bin 0x10000 /home/esp8266_proj/lesson1/dynreg_demo/build/esp8266-qcloud-iot.bin 0x8000 /home/esp8266_proj/lesson1/dynreg_demo/build/partitions_qcloud_demo.bin
```

## 直接从docker hub上获取该镜像

当然你也可以直接从docker hub上获取该镜像直接使用

```shell
docker pull hubertxxu/esp8266_build:0.1
```

