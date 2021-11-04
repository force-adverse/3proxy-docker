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
