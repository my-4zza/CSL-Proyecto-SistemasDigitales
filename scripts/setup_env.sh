#!/bin/bash
# Configuración del entorno para Tang Nano 9K

echo "Actualizando repositorios..."
sudo apt update

echo "Instalando openFPGALoader..."
sudo apt install -y openfpgaloader

echo "Entorno listo. Ahora puedes flashear la tarjeta con deploy.sh"