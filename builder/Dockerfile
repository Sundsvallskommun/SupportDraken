FROM maven:3.9-eclipse-temurin-21-alpine

RUN apk add --no-cache bash git docker-cli

WORKDIR /work

COPY . .

RUN chmod +x /work/entrypoint.sh

ENTRYPOINT ["/work/entrypoint.sh"]
