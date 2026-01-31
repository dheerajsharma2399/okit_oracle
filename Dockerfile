
# Copyright (c) 2020, 2024, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

FROM ubuntu:22.04
ARG BRANCH=master
LABEL "provider"="Oracle" \
      "issues"="https://github.com/oracle/oci-designer-toolkit/issues" \
      "version"="0.70.0" \
      "description"="OKIT Web Server Container." \
      "copyright"="Copyright (c) 2020, 2024, Oracle and/or its affiliates."
ENV PYTHONIOENCODING=utf8 \
    PYTHONPATH=":/okit/modules:/okit/okitserver:/okit" \
    FLASK_APP=okitserver \
    FLASK_DEBUG=0 \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB:en \
    LC_ALL=en_GB.UTF-8 \
    PATH=/root/bin:${PATH} \
    OKIT_DIR=/okit \
    DEBIAN_FRONTEND=noninteractive
# Expose Ports
EXPOSE 5000
# Update base image and install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    python3 -m pip install --upgrade pip && \
    mkdir -p ${OKIT_DIR}/{git,local,log,instance/git,instance/local,instance/templates/user,workspace,ssl} && \
    mkdir -p /root/bin
# Copy local code
COPY requirements.txt .
COPY okitclassic/config ${OKIT_DIR}/config
COPY okitclassic/okitserver ${OKIT_DIR}/okitserver
COPY okitclassic/modules ${OKIT_DIR}/modules
COPY okitclassic/containers/docker/run-server.sh /root/bin/run-server.sh
COPY okitclassic/okitserver/static/okit/templates/reference_architecture ${OKIT_DIR}/instance/templates/reference_architecture
RUN chmod a+x /root/bin/run-server.sh \
# Install required python modules
 && python3 -m pip install --no-cache-dir -r /requirements.txt
# Add entrypoint to automatically start webserver
CMD ["run-server.sh"]
