#!/bin/bash

echo "activando entorno virtual"
. .venv/bin/activate

echo "Instalando dependencias"
pip install -r requirements.txt

echo "Ejecutando pruebas con pytest"

pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "Pruebas completadas. Los resultados se encuentran en la carpeta 'reports'."