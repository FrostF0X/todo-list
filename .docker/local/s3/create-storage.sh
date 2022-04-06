#!/usr/bin/env bash

set -euo pipefail

while ! curl --fail http://${MINIO_HOST}/minio/health/live; do echo "Waiting for ${MINIO_HOST} to be healthy"; sleep 1; done;
/usr/bin/mc config host add s3 http://${MINIO_HOST} ${MINIO_ROOT_USER} ${MINIO_ROOT_PASSWORD}
/usr/bin/mc mb s3/${MINIO_BUCKET};
/usr/bin/mc policy set download s3/${MINIO_BUCKET};
exit 0;
