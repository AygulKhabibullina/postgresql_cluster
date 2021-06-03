#! /bin/sh
# подгружаем профиль с настройками
. /home/backup_user/.bash_profile
# вызываем команду создания копии, в качестве параметра передаем метод создания бэкапа (FULL, DELTA и т.д.)
pg_probackup backup --instance=db1 -j 2 --progress -b $1 --compress --stream --delete-expired 
# Получаем статус последней копии и отправляем его в zabbix.
#if [ "$(pg_probackup show --instance=db1 --format=json | jq -c '.[].backups[0].status')" == '"OK"' ]; then
#  result=0;
#else
#  result=1;
#fi
# в zabbix уже должен быть создан элемент данных типа zabbix_trapper и ключом pg.db_backup
# Логику обработки полученного значения я предлагаю вам настроить самостоятельно, например может учитываться не только значение, которое пришло, но и время с момента последнего обновления этого элемента.
#/opt/zabbix/bin/zabbix_sender -c /opt/zabbix/etc/pg.zabbix_agentd.conf -k pg.db_backup -o $result
