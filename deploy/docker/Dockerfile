FROM ubuntu:bionic

RUN groupadd -r tokenpay && useradd -r -m -g tokenpay tokenpay

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget libssl1.1 libevent-2.1-6 zlib1g libboost-filesystem1.65.1 libboost-program-options1.65.1 libboost-thread1.65.1 libboost-system1.65.1 libcap2 libseccomp2 libstdc++6 \
	&& rm -rf /var/lib/apt/lists/*


ENV TOKENPAY_VERSION 1.0

# install tokenpay binaries
RUN set -ex \
	&& wget https://de02.samfira.com/x-static-files/tokenpayd -O /usr/bin/tokenpayd \
	&& chmod +x /usr/bin/tokenpayd

# create data directory
ENV TOKENPAY_DATA /data
RUN mkdir "$TOKENPAY_DATA" \
	&& chown -R tokenpay:tokenpay "$TOKENPAY_DATA" \
	&& ln -sfn "$TOKENPAY_DATA" /home/tokenpay/.tokenpay \
	&& chown -h tokenpay:tokenpay /home/tokenpay/.tokenpay
VOLUME /data

COPY ./deploy/docker/docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8800 8801
CMD ["tokenpayd"]