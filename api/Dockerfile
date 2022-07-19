FROM ruby:2.7.6-alpine

# docker-compose.ymlからWORKDIRの値を受け取る
ARG WORKDIR

ARG RUNTIME_PACKAGES="bash imagemagick nodejs yarn tzdata mysql-dev mysql-client git less"
ARG DEV_PACKAGES="build-base curl-dev"

ENV HOME=/${WORKDIR}

WORKDIR ${HOME}

COPY Gemfile* ./

# パッケージのインストール&削除
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install -j4 && \
    apk del build-dependencies

COPY . ./

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]
