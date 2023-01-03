#/bin/bash
directory=~/
backup_dir=$directory/backup
old_backup_dir=$directory/old_backup
log_dir=$directory/log/
date_1=`date -I`
list=`ls $directory | grep .txt`
log=$log_dir/backup.log
err=$log_dir/err_backup.log

#move files from directory older than 5 min
mkdir -p $backup_dir $old_backup_dir $log_dir
find $backup_dir -type f -mmin +5 -name "tar.gz" -exec mv {} $old_backup_dir \; 2>>$err 1>>$log

#create new one
for file in $list
do
tar -zcf $backup_dir$file"_"$date_1.tar.gz $file 1>>$log 2>>$err
done