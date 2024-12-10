FROM ruby:2-buster
COPY files /tmp/files/
RUN mv /tmp/files/flag.sh / && \
    mv /tmp/files/start.sh / && \
    chmod +x /flag.sh /start.sh && \
    useradd app -m && \
    mkdir /app && \
    chown -R root:root /app && \
    chmod -R 755 /app && \
    sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
	  sed -i '/security/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install nodejs npm -y && \
    npm config set registry https://registry.npm.taobao.org && \
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && \
    bundle config 'mirror.https://rubygems.org' 'https://gems.ruby-china.com/' && \
    npm config set registry https://registry.npm.taobao.org && \
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && \
    bundle config 'mirror.https://rubygems.org' 'https://gems.ruby-china.com/' && \
    su - app -c 'npm config set registry https://registry.npm.taobao.org' && \
    su - app -c 'gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/' && \
    su - app -c "bundle config 'mirror.https://rubygems.org' 'https://gems.ruby-china.com/'" && \
    apt-get install libaio1 libnuma1 psmisc libmecab2 redis-server -y && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-common_5.7.29-1debian10_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-community-client_5.7.29-1debian10_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-client_5.7.29-1debian10_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-community-server_5.7.29-1debian10_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-server_5.7.29-1debian10_amd64.deb && \
    cp -f /tmp/files/redis.conf /etc/redis/redis.conf && \
    rm -rf /tmp/files && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /app
CMD /start.sh
