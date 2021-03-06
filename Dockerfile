FROM python:3.6-slim

WORKDIR /servo

# Install dependencies, plus apache-benchmark
RUN pip3 install requests PyYAML python-dateutil && \
	apt-get update && apt-get install -y apache2-utils

ADD https://storage.googleapis.com/kubernetes-release/release/v1.10.0/bin/linux/amd64/kubectl /usr/local/bin/kubectl

# Install servo:  k8s adjust driver does uses adjust.py
# alt:  https://raw.githubusercontent.com/opsani/servo-ab/master/measure
ADD https://raw.githubusercontent.com/opsani/servo-k8s/master/adjust \
    https://raw.githubusercontent.com/opsani/servo-newrelic/master/measure \
    https://raw.githubusercontent.com/opsani/servo/master/measure.py \
    https://raw.githubusercontent.com/opsani/servo/master/servo \
    https://raw.githubusercontent.com/opsani/servo/master/adjust.py \
    /servo/

ADD https://raw.githubusercontent.com/opsani/servo/master/encoders/__init__.py \
    https://raw.githubusercontent.com/opsani/servo/master/encoders/base.py \
    https://raw.githubusercontent.com/opsani/encoder-jvm/master/encoders/jvm.py \
    /servo/encoders/

RUN chmod a+rwx /servo/adjust /servo/measure /servo/servo /usr/local/bin/kubectl
RUN chmod a+rw /servo/measure.py

ENV PYTHONUNBUFFERED=1

ENTRYPOINT [ "python3", "servo" ]
