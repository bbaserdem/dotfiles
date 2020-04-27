#!/bin/sh

echo "[default]
access_key = $(pass AWS | awk '/access-key-id/ {print $2}')
secret_key = $(pass AWS | awk '/secret-access-key/ {print $2}')" > ~/.s3cfg
