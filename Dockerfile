FROM ubuntu:xenial

MAINTAINER Manish Ahluwalia, manish.ahluwalia@gmail.com


# Install the dependencies for youtube
RUN apt-get update \
     && apt-get install -y python ffmpeg mplayer aria2 libav-tools axel curl wget httpie

# The version of youtube-dl
ARG VERSION

LABEL youtube-dl version $VERSION

# If the version we will use has changed, force a modification of the image stack. This is needed because
# the command iteslf doesn't change with different versions, so docker build has no way of knowing that something has changed if the version of youtube-dl changes.
RUN echo $VERSION > /VERSION

# install youtube-dl itself
RUN wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl \
     && chmod a+rx /usr/local/bin/youtube-dl

COPY youtube-dl-wrapper /

# We want the user the mount a /Downloads. If the user doesn't, we want to find that (it itsn't mounted) and fail. The ENTRYPOINT wrapper below will perform the check
# That's why we don't declare /Downloads as a VOLUME or WORKDIR, we want it to NOT exist if the user didn't -v mount it at `docker run' time


ENTRYPOINT ["/youtube-dl-wrapper"]
CMD ["--help"]
