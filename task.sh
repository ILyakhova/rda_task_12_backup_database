#! /bin/bash
# Зчитування змінних середовища
DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"

# Шлях до директорії для тимчасових файлів резервних копій
BACKUP_PATH="/tmp"

# Створення повного бекапу ShopDB і відновлення у ShopDBReserve
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --databases ShopDB > "$BACKUP_PATH/ShopDB.sql"
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < "$BACKUP_PATH/ShopDB.sql"

# Створення бекапу лише даних ShopDB і відновлення у ShopDBDevelopment
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info --skip-add-drop-table ShopDB > "$BACKUP_PATH/ShopDBDataOnly.sql"
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < "$BACKUP_PATH/ShopDBDataOnly.sql"