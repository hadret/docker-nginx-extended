# vim:set ft=dockerfile:
FROM ubuntu:bionic

LABEL maintainer="Filip Chabik <hadret@gmail.com>"

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
                                             software-properties-common \
    && add-apt-repository ppa:hadret/nginx \
    && apt-get update \
    && apt-get install -y nginx-full \
    && apt-get remove -y --purge --auto-remove apt-transport-https \
                                                   ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	  && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
