FROM docker.io/eclipse-temurin:25

RUN apt update && apt install -y --no-install-recommends \
    bash \
    curl \
    rlwrap \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh \
    && bash ./linux-install.sh \
    && rm linux-install.sh

ENV PATH="/app/bin:$PATH"
ENV LIMABEAN_UBERJAR=/app/limabean-standalone.jar
ENV LIMABEAN_BEANFILE=accounting.beancount

VOLUME /data

ENTRYPOINT ["limabean"]
RUN mkdir -p /app/bin
WORKDIR /app

COPY limabean-standalone.jar .
COPY release/limabean release/limabean-pod ./bin

WORKDIR /data
