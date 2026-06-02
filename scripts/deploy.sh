#!/bin/bash
# Flashear el bitstream (.fs) a la FPGA Tang Nano 9K

BITSTREAM_PATH="impl/pnr/top_velocista.fs"

if [ ! -f "$BITSTREAM_PATH" ]; then
    echo "Error: No se encontró el archivo $BITSTREAM_PATH. Sintetiza el proyecto en Gowin primero."
    exit 1
fi

echo "Cargando bitstream en la Tang Nano 9K..."
openFPGALoader -b tangnano9k $BITSTREAM_PATH

echo "¡Flasheo completado!"