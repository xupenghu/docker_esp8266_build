FROM centos		
MAINTAINER hubertxxu<xupenghu@outlook.com> 

ENV MYPATH /usr/home  
WORKDIR $MYPATH 		

COPY README.md	/usr/home/README.md

ADD xtensa-lx106-elf-linux64-1.22.0-92-g8facf4c-5.2.0.tar.gz /opt/toolchain/
ADD gperf-3.1.tar.gz /opt/
ADD ESP8266_RTOS_SDK.tar.gz /home/esp8266/


RUN yum -y install gcc git wget make ncurses-devel flex bison python36 gcc-c++

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip3 install pyserial

RUN cd /opt/gperf-3.1
RUN mkdir build&&cd build
RUN /opt/gperf-3.1/configure --prefix=/usr CFLAGS='-O2 -v'
RUN make&&make install


ENV IDF_PATH=/home/esp8266/ESP8266_RTOS_SDK
ENV PATH=$PATH:/opt/toolchain/xtensa-lx106-elf/bin

CMD echo "----end----"
CMD /bin/bash
