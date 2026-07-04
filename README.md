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

- **Instalar Jenkins con Docker Compose:**

```yml
services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins

    restart: unless-stopped

    ports:
      - "8080:8080"
      - "50000:50000"

    volumes:
      - jenkins_home:/var/jenkins_home

    environment:
      - JAVA_OPTS=-Djenkins.install.runSetupWizard=true

volumes:
  jenkins_home:
    external: true
```

```bash
docker compose up -d
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

---

La opción mas comun para utilizar con GitHub, es mediaante un webhook.
Esto se debe configurar en el repositorio de donde obtenemos el código fuente.

- Nos vamos a las configuraciones del repositorio
- Seleccionas la opción **Webhooks** y click en el botón **Add webhook** y agregas la url de tu instancia de Jenkins, en el campo **Payload URL**
  - Si estas usando Jenkins, te recomiendo utilizar una herramienta como `ngrok` para generar una url accesible para GitHub.
  - La url debe terminar con `/github-webhook`
- En el campo **Content type** seleccionas `application/json`.
- Por último, las opciones de **Which events would you like to trigger this webhook?**, seleccionas `Just the push event.`
- Finalmente das click en el botón **Add webhook** de nuevo.

Tal cual se muestra en la siguiente imagen
<img width="1378" height="924" alt="image" src="https://github.com/user-attachments/assets/d878918e-0c57-49e9-86d8-265e3db6a921" />

## Plugings

Son extenciones que se instalan a Jenkins para agregar nuevas funcionalidades.

- Podemos instalar plugins para:
  - Soporte de control de versiones como: Git, SVN, Bitbucket, etc.
  - Integración con otras herramientas de construcción como: Maven, Gradle, Node.js.
  - Soporte para notificaciónes via Email ó Slack.
  - Soporte para contenedores como: Docker y Kubernetes.
  - Pruebas automatizadas como: JUnit, Selenium, Playwright, etc.

### Pluguins mas requeridos:

- [Git Plugin](https://plugins.jenkins.io/git/): Ofrece operaciones básicas de Git para los proyectos de Jenkins. Permite consultar, descargar, realizar un checkout, crear ramas, listar, fusionar, etiquetar y enviar repositorios.

- [Maven Integration](https://plugins.jenkins.io/maven-plugin/): Sirve para integrar de forma nativa proyectos Maven con Jenkins, facilitando la compilación, pruebas y publicación de artefactos. Fue muy importante en los proyectos Freestyle clásicos, aunque hoy en día su uso ha disminuido debido al auge de los Pipelines.

- [Email Extension Plugin](https://plugins.jenkins.io/email-ext): Se utiliza para enviar notificaciones por correo electrónico mucho más personalizadas y potentes que las que ofrece el plugin básico de correo de Jenkins.

---

## Parametros en Jobs

Permiten ingresar valores al momento de ejecutar un build. Es util, por ejemplo, para seleccionar una rama especifica de Git o definir valores antes de una ejecución.s

Para ingresar parametros

1. Te dirijes a las configuraciones de un Job
   <img width="372" height="634" alt="image" src="https://github.com/user-attachments/assets/39291555-bad3-42d8-bf64-c2ff23ef3a09" />

---

2. Marca la casilla **Esta ejecución debe parametrizarse**
   <img width="1264" height="676" alt="image" src="https://github.com/user-attachments/assets/6663c521-9557-4677-92fe-f67b24f40cb0" />

---

3. Forma de utilizarlo:
   <img width="719" height="249" alt="image" src="https://github.com/user-attachments/assets/3daf2e66-2312-4123-a997-2c684ced4e58" />

## Valiables de entorno
Permiten reutilizar valores dentro de un Job. Jenkins tiene variable de entorno ya establecidas por defecto, tambien permite crear variables de entorno necesarias para el proyecto.

Algunas de las variable de entorno que Jenkins tiene preestablecidad son las siguientes:

- **BUILD_NUMBER**: Número del build actual.
- **JOB_NAME**: Nombre del Job que se está ejecutando.
- **WORKSPACE**: Directorio donde jenkins almacena los archivos del Job.
- **GIT_COMMIT**: Hash del commit (solo si el Job está utilizando Git).