FROM docker.io/library/docker:24-dind

RUN apk add --no-cache bash curl

COPY entrypoint.sh .

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]