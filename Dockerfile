FROM alpine:latest
MAINTAINER neilweixing

WORKDIR /usr/local

ADD jdk-8u202-linux-x64.tar.gz /usr/local/

COPY locale.md /usr/local/locale.md

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/main/" > /etc/apk/repositories && \
apk --no-cache add ca-certificates wget && \
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-bin-2.30-r0.apk && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-i18n-2.30-r0.apk && \
apk add glibc-bin-2.30-r0.apk glibc-i18n-2.30-r0.apk glibc-2.30-r0.apk && \
cat locale.md | xargs -i /usr/glibc-compat/bin/localedef -i {} -f UTF-8 {}.UTF-8 && \
rm -rf *.apk && \
rm -rf /var/cache/apk/* && \
rm -rf locale.md

ENV JAVA_HOME=/usr/local/jdk1.8.0_202
ENV CLASSPATH=$JAVA_HOME/bin
ENV PATH=.:$JAVA_HOME/bin:$PATH
ENV LANG=zh_CN.UTF-8 \
  LANGUAGE=zh_CN.UTF-8
CMD ["java","-version"]
