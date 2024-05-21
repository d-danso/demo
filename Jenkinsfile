pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Check if the container exists and remove it if necessary
                    def containerExists = bat(script: 'docker ps -a -q -f name=demo-container', returnStdout: true).trim()
                    if (containerExists) {
                        bat 'docker stop demo-container'
                        bat 'docker rm demo-container'
                    }

                    // Copy the JAR file to the Docker context if needed
                    // bat 'copy target\\demo-0.0.1-SNAPSHOT.jar .'

                    // Build Docker image
                    bat 'docker build -t demo-app .'

                    // Run Docker container
                    bat 'docker run -d -p 8081:8081 --name demo-container demo-app'
                }
            }
        }
    }
    post {
        always {
            script {
                // Clean up Docker container and image after use
                def containerExists = bat(script: 'docker ps -a -q -f name=demo-container', returnStdout: true).trim()
                if (containerExists) {
                    bat 'docker stop demo-container'
                    bat 'docker rm demo-container'
                }

                def imageExists = bat(script: 'docker images -q demo-app', returnStdout: true).trim()
                if (imageExists) {
                    bat 'docker rmi demo-app'
                }
            }
        }
    }
}
