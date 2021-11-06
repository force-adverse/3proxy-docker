# 3proxy-docker

Docker image containing a 3proxy binary.

You should build this image yourself and push it to your private registry.
See [the build Action](./.github/workflows/build-docker.yml) for more information.

## Binary

Built binary is available @ `/usr/local/bin/3proxy`

## Action

The Action will trigger build on push of modifications to Dockerfile or manual workflow dispatch.

## Info for FORAD members

Image can be found at `ghcr.io/force-adverse/3proxy-docker:latest`

## Copying binary to another Docker image (composition)

Example from one of our internal Dockerfile:

```dockerfile
FROM alpine:latest

# install 3proxy
COPY --from=ghcr.io/force-adverse/3proxy-docker:latest /usr/local/bin/3proxy /usr/local/bin/3proxy
```
