
# Copyright (c) 2020, 2024, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

FROM oraclelinux:8
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
RUN yum update -y && yum install -y \
        python3 \
        python3-pip && \
    yum clean all && rm -rf /var/cache/yum/* && \
    python3 -m pip install --upgrade pip && \
    mkdir -p ${OKIT_DIR}/{git,local,log,instance/git,instance/local,instance/templates/user,workspace,ssl} && \
    mkdir -p /root/bin
# Copy local code
COPY ./okitclassic/config ${OKIT_DIR}/config
COPY ./okitclassic/okitserver ${OKIT_DIR}/okitserver
COPY ./okitclassic/modules ${OKIT_DIR}/modules
COPY ./okitclassic/containers/docker/run-server.sh /root/bin/run-server.sh
COPY ./okitclassic/okitserver/static/okit/templates/reference_architecture ${OKIT_DIR}/instance/templates/reference_architecture
RUN chmod a+x /root/bin/run-server.sh && \
    python3 -m pip install --no-cache-dir \
        authlib>=0.15.3 \
        flask>=1.1.2 \
        gitpython \
        git-url-parse \
        gunicorn>=20.0.4 \
        oci>=2.100.0 \
        openpyxl \
        python-magic>=0.4.22 \
        pyyaml>=5.4.1 \
        requests>=2.25.1
# Add entrypoint to automatically start webserver
CMD ["run-server.sh"]
