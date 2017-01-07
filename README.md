# Docker container for youtube-dl and dependencies

[youtube-dl](https://github.com/rg3/youtube-dl) is a really cool tool. However, many operations require dependencies. This is [docker](https://www.docker.com) container with these dependencies built-in. With this, you can use youtube-dl with one (docker) command without having to preinstall the tool or its dependencies.

The container downloads all files in a `/Downloads` directory inside the container. This means that you have to share the (host) directory where you really want to store the downloaded files and [bind mount](https://docs.docker.com/engine/tutorials/dockervolumes/#/mount-a-host-directory-as-a-data-volume) the target host directory inside the container as `/Downloads`.

    docker run -v /dir/to/store/files:/Downloads fakepseudonym/youtube-dl 'https://youtube.com/url'

If you forget to bind mount `/Downloads`, the container will complain.

The github repo is at [https://github.com/manishahluwalia/youtube-dl-docker](https://github.com/manishahluwalia/youtube-dl-docker).

The docker hub for the image is at [https://hub.docker.com/r/fakepseudonym/youtube-dl/](https://hub.docker.com/r/fakepseudonym/youtube-dl/).
