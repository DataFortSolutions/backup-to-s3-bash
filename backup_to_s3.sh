#!/bin/bash
set -e

orig_dir=$(pwd)
timestamp=$(date +%Y%m%d_%H%M%S)
logfile=backup_to_s3.log

log() {
    echo -e "[$(date +%FT%T%Z)]" "$@" >> $orig_dir/$logfile
}

exec 3>&1 1>>"$orig_dir/$logfile" 2>&1
log "Starting backup run at $timestamp"
backup_filename="datafort_backup_"$timestamp".tar.gz"

# load configuration file
source backup_to_s3.config
trap "echo '[$(date +%FT%T%Z)] ERROR: An error occurred, please check the backup_to_s3.log file for details' >&3" ERR

cd $BACKUP_DIRECTORY

log "Compressing these files: "
tar --exclude="datafort*.tar.gz" -czvf $backup_filename * &>> $orig_dir/$logfile

log "Uploading $backup_filename to S3 bucket $AWS_S3_BACKUP_BUCKET_NAME"
aws s3 cp $backup_filename s3://$AWS_S3_BACKUP_BUCKET_NAME &>> $orig_dir/$logfile
log "Finished backing up files and uploading to S3\n"