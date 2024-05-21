pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'maven:3.9.6-eclipse-temurin-17-alpine'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container
                    docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").run("-d -p 8081:8081 -v /path/to/host/dir:/app --name demo-app-container")
                }
            }
        }
    }

    post {
        always {
            // Stop and remove the Docker container
            script {
                docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").stop()
                docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").remove()
            }
        }
    }
}
