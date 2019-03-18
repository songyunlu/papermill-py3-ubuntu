FROM ubuntu:16.04

LABEL maitainer="songyunlu <gn00023040@gmail.com>" \
      name="papermill-py3-ubuntu" \
      keywords="python papermill jupyter ubuntu" \
      url="https://hub.docker.com/r/gn00023040/papermill" \
      vcs-url="https://github.com/songyunlu/papermill-py3-ubuntu" \
      description="Netflix's Papermill with Python3." \
      version="0.19.0-py3-ubuntu"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN set -xe \
    && apt-get update && apt-get upgrade -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.6 \
    && apt-get install -y python3.6-dev \
    && apt-get install -y curl \
    && curl -so /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \
    && python3.6 /tmp/get-pip.py \
    && ln -sf /usr/bin/python3.6 /usr/bin/python3 \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && python3 -m pip install dumb-init \
    && python3 -m pip install papermill \
    && python3 -m pip install papermill s3 \
    && python3 -m pip install papermill azure \
    && python3 -m pip install papermill gcloud \
    && python3 -m pip install ipykernel \
    && python3 -m ipykernel install \
    && apt-get remove -y curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

ENTRYPOINT ["dumb-init", "--", "papermill"]
