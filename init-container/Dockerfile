FROM debian:latest
COPY image /image
COPY /init-container/init-script /init-script
ENTRYPOINT ["/init-script"]
