#!/bin/bash
set -e

# Nome do bucket e pasta temporária
BUCKET_NAME="backup-odoo-select"
BACKUP_DIR="/tmp/odoo-backup"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Cria diretório e backup do volume Docker
mkdir -p $BACKUP_DIR
docker run --rm -v odoo-data:/data -v $BACKUP_DIR:/backup alpine   tar czf /backup/odoo-backup-$DATE.tar.gz -C /data .

# Envia para S3
aws s3 cp $BACKUP_DIR/odoo-backup-$DATE.tar.gz s3://$BUCKET_NAME/odoo/

# Limpeza
rm -rf $BACKUP_DIR
