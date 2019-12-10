FROM cockroachdb/cockroach:v19.1.1 as source

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y upx-ucl
RUN upx /cockroach/cockroach

FROM gcr.io/distroless/base as target

COPY --from=source /cockroach/cockroach /bin/cockroach
ENV COCKROACH_CHANNEL=official-docker
EXPOSE 26257 8080

ENTRYPOINT ["/bin/cockroach"]
