FROM alpine:3.19

RUN apk add --no-cache bash iputils bind-tools

WORKDIR /app

COPY app/app.sh /app/app.sh
RUN chmod +x /app/app.sh

ENTRYPOINT [ "/app/app.sh" ]
CMD ["help"]