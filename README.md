# backup-to-s3-bash

## Overview

This tool will backup all files in a directory, tarball them up and then upload to an s3 bucket.

## Requirements

This is predicated on having aws cli on the machine, and configured already. Also, an S3 bucket will need to be pre-provisioned.

## Usage

Copy the config template file over and modify the variables accordingly.

```bash
cp backup_to_s3.config.template backup_to_s3.config
```

`BACKUP_DIRECTORY` will need to be assigned the path to the directory you wish to backup. Quotes are not necessary.

`AWS_S3_BACKUP_BUCKET_NAME` will need to be assigned the name of the S3 bucket, the `s3://` prefix is not necessary.
