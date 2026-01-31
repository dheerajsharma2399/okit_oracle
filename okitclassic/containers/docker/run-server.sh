#!/bin/bash

# Copyright (c) 2020, 2024, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

echo "*******************************************************************"
echo "**                                                               **"
echo "**  Run WebServer                                                **"
echo "**                                                               **"
echo "*******************************************************************"

python3 --version

/usr/local/bin/gunicorn okitserver.wsgi:app --config /okit/config/gunicorn_http.py
