# slimroach
Slimmed down CockroachDB docker image. At this point this serves as proof of concept.
Goals of this is to reduce the size and the attack surface to only what it needs to be.

| image | size |
|-------|------|
| cockroachdb/cockroach:v19.1.1 | 189MB |
| tanelmae/slimroach:v19.1.1 | 82.1MB |

About 47Mb is removed by using [distroless base image by Google](https://github.com/GoogleContainerTools/distroless/tree/master/base). BusyBox shell is added to the distroless image.
Additional 60MB is removed by compressing the cockroach binary with [upx](https://upx.github.io/).

In the slimroach container CockroachDB runs as a non-root user.
