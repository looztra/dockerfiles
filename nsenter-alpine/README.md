# nsenter in alpine

## What?

This image allows you to simulate a ssh into the host (at least to see the host processes). Must be run `priviledged` so use at your own risks.

`docker run -it --privileged --pid=host looztra/alpine36-nsenter`

