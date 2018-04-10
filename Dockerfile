FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
      apt-transport-https \
      build-essential \
      ca-certificates \
      curl \
      git-core \
      python-software-properties && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get -y autoclean
CMD ["bash"]
