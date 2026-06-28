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
