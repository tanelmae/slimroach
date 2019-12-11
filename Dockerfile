FROM cockroachdb/cockroach:v19.1.1 as source

WORKDIR /workspace
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y upx-ucl wget
RUN upx /cockroach/cockroach
RUN wget https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64 && \
    chmod +x /workspace/busybox-x86_64

# See https://github.com/GoogleContainerTools/distroless/tree/master/base
FROM gcr.io/distroless/base as target
COPY --from=source /cockroach/* /cockroach/
COPY --from=source /workspace/busybox-x86_64 /bin/sh

ENV COCKROACH_CHANNEL=official-docker
EXPOSE 26257 8080
USER 1042

ENTRYPOINT ["/cockroach/cockroach.sh"]
