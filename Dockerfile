FROM ubuntu:xenial

MAINTAINER Manish Ahluwalia, manish.ahluwalia@gmail.com

# Update box
RUN apt-get update

# Install the dependencies for youtube-dl
RUN apt-get install -y python ffmpeg mplayer aria2 libav-tools axel curl wget httpie

# The URL to download youtube-dl from. We resolve the redirect and get the final download url, with the version, upfront so that everyone has the same version (i.e. we cover for the extremely rare case when a new version is release in the middle of a build!)
ARG YT_DL_URL

# Write version in the filesystem
RUN echo $YT_DL_URL | sed 's/^.*\/downloads\///' | sed 's/\/youtube-dl.*//' > /VERSION

# install youtube-dl itself
RUN wget ${YT_DL_URL#302} -O /usr/local/bin/youtube-dl \
     && chmod a+rx /usr/local/bin/youtube-dl

COPY youtube-dl-wrapper /

# We want the user the mount a /Downloads. If the user doesn't, we want to find that (it itsn't mounted) and fail. The ENTRYPOINT wrapper below will perform the check
# That's why we don't declare /Downloads as a VOLUME or WORKDIR, we want it to NOT exist if the user didn't -v mount it at `docker run' time


ENTRYPOINT ["/youtube-dl-wrapper"]
CMD ["--help"]
