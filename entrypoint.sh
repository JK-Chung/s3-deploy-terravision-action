#!/bin/bash -l
AWS_ACCESS_KEY_ID="$1"
AWS_SECRET_ACCESS_KEY="$2"
AWS_S3_BUCKET_BASE_URI="$3"

cd /github/workspace

ls

terravision graphdata --outfile architecture.json
cat architecture.json

aws s3 cp architecture.json $AWS_S3_BUCKET_BASE_URI/architecture.json