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

**Forma de utilizar:**

  <img width="724" height="393" alt="image" src="https://github.com/user-attachments/assets/8dd7975a-d6d3-4d52-a315-6de3974eea32" />

## Ejecutar un programa en python desde Jenkins

- Cuando lanzamos un contenedor Docker de la imagen de Jenkins, dicha imagen tiene un sistema operativo muy ligero para evitar que la imagen pese demacioado, por esta razón no tiene Python instalado por defecto,
  - Docker -> Contenedor(Linux - Jenkins)

- Para instalar Python necesitamos acceder a la linea de comandos del contenedor con el usuario `root`:

```bash
docker exec -it --user root jenkins /bin/bash
```

- **Instalar `python3` y `python3.pip`**
  Una vez dentro de la terminal del contenedor, ejecutamos lo siguiente:

1. Actualizar paquetes:

```bash
apt-get update
```

2. Instalar `python`

```bash
apt-get install python3 python3.pip
```

## Configuración de notificaciones vía Email:

1. Ir a la opción de **Administrar Jenkins** (⚙️)
2. Ir a System Configuration -> System
3. Buscar la opción **System Admin e-mail address**

- Aqui colocarémos el nombre que se mostrará en los correos enviados a los destinatarios
  <img width="868" height="484" alt="image" src="https://github.com/user-attachments/assets/2d4b9adf-1fb2-4125-8d66-d4aa8f68109b" />

4. Ir a la sección **Notificación por correo electrónico** (normalmente ubicado al final)

- Aquí añadiremos la siguiente configuración:
  1. En **Servidor de correo saliente (SMTP)** colocaremos el servidor SMTP, para este ejemplo usaremos en de **Gmail**.
     - `smtp.gmail.com`
  2. Click en el toggle que dice **Avanzado**
     - Aquí llenaremos los siguiente campos
       - Marca la opción **Use SMTP Authentication** (si no está marcada aún)
         - **Nombre de usuario**: Direción de correo electronico desde la cual se enviaran los correos. Ej. admin@tudominio.com ó tucorreo@gmail.com

         - **Contraseña**: Aquí debes colocar una contraseña de aplicación, para el caso de Gmail, debes ir a tu cuenta de Google (con el mismo correo que utilizaste en el campo **Nombre de usuario**), activar la verificación de dos pasos (2FA), ir a la opción **Contraseñas de aplicación** y crear una contraseña para tu Jenkins.
           - <img width="874" height="764" alt="image" src="https://github.com/user-attachments/assets/0801f427-d8c8-49bb-a001-94ff2c950d24" />
           - <img width="874" height="764" alt="image" src="https://github.com/user-attachments/assets/71334ffc-fda5-43ed-b7cc-789a550ceda8" />
             Esta contraseña será la que utilizará en el campo **Contraseña**

       - Marca la opción **Usar seguridad TLS (STARTTLS)**

       - Puerto de SMTP: `587` (recomendado para Gmail)

**Ejemplo:**

<img width="874" height="764" alt="image" src="https://github.com/user-attachments/assets/d01f921c-8914-4de9-bb9c-b522d4ed6c66" />
