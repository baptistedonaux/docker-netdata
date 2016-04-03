FROM debian:8

ENV NETDATA_VERSION v1.0.0

RUN apt-get update \
    && apt-get install -y \
        autoconf \
        autogen \
        automake \
        gcc \
        git \
        make \
        pkg-config \
        zlib1g-dev \
    && git clone https://github.com/firehol/netdata.git --branch $NETDATA_VERSION --depth=1 \
    && cd netdata \
    && ./netdata-installer.sh \
    && apt-get autoremove -y --purge \
        autoconf \
        autogen \
        automake \
        gcc \
        git \
        make \
        pkg-config \
        zlib1g-dev \
    && rm -rf \
        /netdata \
        /var/lib/apt/lists/* \
    && ln -sf /dev/stderr /var/log/netdata/error.log \ 
    && ln -sf /dev/stdout /var/log/netdata/access.log \
    && ln -sf /dev/stdout /var/log/netdata/debug.log

EXPOSE 19999

VOLUME /etc/netdata /usr/libexec/netdata/plugins.d /usr/share/netdata/web /var/cache/netdata /var/log/netdata 

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"] 
CMD ["netdata", "-nodeamon"]

