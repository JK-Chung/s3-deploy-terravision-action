#!/bin/bash -l
export AWS_ACCESS_KEY_ID="$1"
export AWS_SECRET_ACCESS_KEY="$2"
export AWS_DEFAULT_REGION="$3"
export AWS_S3_BUCKET_BASE_URI="$4"

# Copy over the git repository contents into our own directory
cp -r /github/workspace /actions
cd /actions/workspace

terravision graphdata --outfile architecture.json
cat architecture.json

aws s3 cp architecture.json $AWS_S3_BUCKET_BASE_URI/architecture.json