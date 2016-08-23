FROM ubuntu:14.04
MAINTAINER Binh Nguyen <binh.nguyen@razerzone.com>
LABEL Description="Fluentd docker image" Vendor="Fluent Organization" Version="1.0"

RUN apt-get update -y && apt-get install -y \
              autoconf \
              bison \
              build-essential \
              curl \
              git \
              libffi-dev \
              libgdbm3 \
              libgdbm-dev \
              libncurses5-dev \
              libreadline6-dev \
              libssl-dev \
              libyaml-dev \
              zlib1g-dev \
        && rm -rf /var/lib/apt/lists/*

# for log storage (maybe shared with host)
RUN mkdir -p /fluentd/log
# configuration/plugins path (default: copied from .)
RUN mkdir -p /fluentd/etc
RUN mkdir -p /fluentd/plugins

WORKDIR /home/ubuntu

RUN git clone https://github.com/tagomoris/xbuild.git /home/ubuntu/.xbuild
RUN /home/ubuntu/.xbuild/ruby-install 2.2.2 /home/ubuntu/ruby

ENV PATH /home/ubuntu/ruby/bin:$PATH
RUN gem install fluentd

RUN gem install -V fluent-plugin-s3 \
        fluent-plugin-kinesis \
        fluent-plugin-aws-elasticsearch-service \
        fluent-plugin-elasticsearch \
        fluent-plugin-influxdb \
        fluent-plugin-mongo

COPY fluent.conf /fluentd/etc/fluent.conf

WORKDIR /home/ubuntu

ENV FLUENTD_OPT=""
ENV FLUENTD_CONF="fluent.conf"

EXPOSE 24224
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
