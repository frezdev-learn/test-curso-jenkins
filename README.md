# Curso de Jenkins

## Instalación de Jenkins

- **Instalar Jenkins con Docker:**

```bash
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
```

**Explicación:**

```bash
docker run -d --name jenkins
-p 8080:8080 # Exponer puerto de Jenkins
-p 50000:50000 # Exponer puerto para los agentes
-v jenkins_home:/var/jenkins_home # Crear volumen
```

Obten la contraseña de Administrador:

```bash
# Ejecuta la terminal bash del contenerdo:
docker exec -it jenkins bash

# Mostrar la contraseña
cat /var/jenkins_home/secrets/initialAdminPassword

# Copia el contenido y pegalo en el input de la interfaz de Jenkins
```

## Conceptos:

### Jobs

- Es una tarea automatizada -> se ejecuta en el servidor Jenkins
- Un Job puede:
  - Compilar código
  - Ejecutar pruebas
  - Realizar despliegue
  - o cualquier otro proceso

**Tipos de Jobs:**

- **Freestyle Project** -> El mas básico y fácil de configurar.
- **Pipeline** -> Usado para los flujos de integración y despliegue continuo (CI/CD)
- **Multibranch Pipeline** -> Ideal para proyectos con varias ramas en git
- **Maven Project** -> Usado para proyecto Java con Maven

### Build

- Es la ejecución de un Job
- Cada vez que se haga una ejecución, se genera un Build
- Para ejecutar un build, Jenkins hace lo siguiente:
  - Obtiene el código fuente (desde GitHub, si es el caso)
  - Ejecuta los pasos que se han definido prebiamente en el Job (pasos de compilación, pruebas, despliegue, etc.)
  - Registra la salida en el Console Output
  - Guardar los arefactos que genera (opcional)
  - Muestra el resultado del build en la interfaz

## Triggers (Disparadores)

#### Triggers automaticos

Jenkins permite ejecutar Builds automaticamente con diferentes métodos.

**Tipos:**

- **Polling SCM:** Revisa periodicamente si hay cambios en el repositorio de Git.
- **Webhook:** Dispara el Job cuando hay algin cambio en el repositorio de GitHub, GitLab u otros.
- **Cron Programado:** Ejecuta el Job en intervalos de tiempo especificos.
- **Disparo por otro Job:** Un Job puede ejecutar otro Job cuando termine.
