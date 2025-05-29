#!/bin/bash

cd /home/ubuntu/infra-odoo-aws

echo "📥 Atualizando projeto..."
git pull origin main

echo "♻️ Recriando containers..."
docker compose down
docker compose --env-file .env up -d
