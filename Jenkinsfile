pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }

        stage('Build') {
            steps {
                sh 'python3 ./src/saludo.py'
            }
        }
    }
}