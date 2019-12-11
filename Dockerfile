FROM cockroachdb/cockroach:v19.1.1 as source

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y upx-ucl wget
RUN upx /cockroach/cockroach

FROM busybox as shell

# See https://github.com/GoogleContainerTools/distroless/tree/master/base
FROM gcr.io/distroless/base as target
COPY --from=source /cockroach/* /cockroach/
COPY --from=shell /bin/busybox /bin/busybox
COPY --from=shell /bin/sh /bin/sh
COPY --from=shell /bin/cat /bin/cat

ENV COCKROACH_CHANNEL=official-docker
EXPOSE 26257 8080
USER 1042
ENTRYPOINT ["/cockroach/cockroach.sh"]
