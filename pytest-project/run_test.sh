#!/bin/bash

echo "activando entorno virtual"
cd ./pytest-project

if [ ! -d .venv ]; then
    echo "Creando entorno virtual"
    python3 -m venv .venv
fi

. .venv/bin/activate

echo "Instalando dependencias"
pip install --upgrade pip
pip install -r requirements.txt

echo "Ejecutando pruebas con pytest"

pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "Pruebas completadas. Los resultados se encuentran en la carpeta 'reports'."