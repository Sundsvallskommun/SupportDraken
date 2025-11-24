FROM maven:3.9-eclipse-temurin-21-alpine

RUN apk add --no-cache bash git docker-cli openssl

WORKDIR /work

COPY scripts/builder /work/scripts/builder

RUN chmod +x /work/scripts/builder/entrypoint.sh /work/scripts/builder/build-draken-public.sh /work/scripts/builder/build-smaug.sh

ENTRYPOINT ["/work/scripts/builder/entrypoint.sh"]
