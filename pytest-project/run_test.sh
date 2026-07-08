#!/bin/bash

echo "activando entorno virtual"
cd ./pytest-project

pwd
if [ ! -d .venv ]; then
    echo "Creando entorno virtual"
    python3 -m venv .venv
fi
pwd
ls -a
if [ -f .venv/bin/activate ]; then
    source .venv/bin/activate
else
    echo "No se pudo activar el entorno virtual. Asegúrate de que Python esté instalado y configurado correctamente."
    exit 1
fi

echo "Instalando dependencias"
pip install --upgrade pip
pip install -r requirements.txt

echo "Ejecutando pruebas con pytest"

pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "Pruebas completadas. Los resultados se encuentran en la carpeta 'reports'."