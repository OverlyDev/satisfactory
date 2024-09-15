#!/bin/bash

set -e

echo "========================================================="
echo "==================== Installing game ===================="
echo "========================================================="

steamcmd +force_install_dir /game +login anonymous +app_update 1690800 validate +quit

mkdir -p /game/FactoryGame/Certificates
if [[ ! -f /game/FactoryGame/Certificates/private_key.pem ]] || [[ ! -f /game/FactoryGame/Certificates/cert_chain.pem ]]; then
    echo "========================================================="
    echo "==================== Generating cert ===================="
    echo "========================================================="

    openssl req -x509 -newkey rsa:4096 \
        -keyout /game/FactoryGame/Certificates/private_key.pem \
        -out /game/FactoryGame/Certificates/cert_chain.pem \
        -sha256 -days 365 -nodes \
        -subj "/C=XX/ST=StateName/L=CityName/O=Ficsit/OU=ProjectAssembly/CN=Satisfactory"
else
    echo "========================================================="
    echo "================== Cert already exists =================="
    echo "========================================================="
fi

echo "========================================================="
echo "==================== Starting server ===================="
echo "========================================================="

cd /game
./FactoryServer.sh -ini:Engine:[HTTPServer.Listeners]:DefaultBindAddress=any
