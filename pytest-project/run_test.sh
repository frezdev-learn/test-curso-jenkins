#!/bin/bash

cd ./pytest-project
echo "Activando entorno virtual"

pwd
if [ ! -d .venv ]; then
    echo "Creando entorno virtual"
    python3 -m venv .venv
fi
pwd
if [ ! -f .venv/bin/activate ]; then
    echo "No se encontró el archivo de activación del entorno virtual."
    rm -rf .venv
    exit 1
else
    . .venv/bin/activate
fi

echo "Instalando dependencias"
pip install --upgrade pip
pip install -r requirements.txt

echo "Ejecutando pruebas con pytest"

pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "Pruebas completadas. Los resultados se encuentran en la carpeta 'reports'."