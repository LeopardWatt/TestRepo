#!/bin/bash
directory=$(pwd)
backup_dir=$directory/backup/
old_backup_dir=$directory/old_backup/
log_dir=$directory/log/
date_time=`date +%F_%T`
list=`ls $directory | grep .txt`
log=$log_dir/backup.log
err=$log_dir/err_backup.log

#create directories
mkdir -p $backup_dir $old_backup_dir $log_dir

#move files from directory older than 5 min
find $backup_dir -type f -mmin +5 -name "*tar.gz" -exec mv {} $old_backup_dir \; 2>>$err 1>>$log

#create new one
for file in $list
do
tar -zcvf $backup_dir$file"_"$date_time.tar.gz $file 1>>$log 2>>$err
done

# delete files older than 30min
cd $old_backup_dir && find . -name "*.tar.gz" -type f -mmin +30 -delete
