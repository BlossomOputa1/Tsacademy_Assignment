FROM alpine:latest

# install bash and other necessary tools
RUN apk add --no-cache bash iputils netcat-openbsd bind-tools

WORKDIR /app
COPY app/ /app/

RUN chmod +x /app/diagnostic.sh /app/health-check.sh

# Set the Entrypoint
ENTRYPOINT ["/app/diagnostic.sh"]
CMD ["help"]
