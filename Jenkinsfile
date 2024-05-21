// pipeline {
//     agent {
//         docker {
//             image 'maven:3.9.6-eclipse-temurin-17-alpine'
//             workingDir '/home/jenkins'
//         }
//     }
//     environment {
//         DOCKER_IMAGE = 'demo-app'
//         DOCKER_TAG = 'latest'
//     }
//     stages {
//         stage('Checkout') {
//             steps {
//                 checkout scm
//             }
//         }
//         stage('Build') {
//             steps {
//                 bat 'mvn clean package'
//             }
//         }
//         stage('Test') {
//             steps {
//                 bat 'mvn test'
//             }
//         }
//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
//                 }
//             }
//         }
//         stage('Run Docker Container') {
//             steps {
//                 script {
//                     bat 'docker run -d -p 8081:8080 --name demo-app-container ${DOCKER_IMAGE}:${DOCKER_TAG}'
//                 }
//             }
//         }
//     }
//     post {
//         always {
//             node('ddanso') {
//                 script {
//                     bat 'docker stop demo-app-container'
//                     bat 'docker rm demo-app-container'
//                 }
//             }
//         }
//         cleanup {
//             node('ddanso') {
//                 script {
//                     bat 'docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG}'
//                 }
//             }
//         }
//     }
// }

pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-docker-image:latest' // Adjust the image name here
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        // Other stages in your pipeline
    }

    post {
        always {
            // Clean up Docker resources
            script {
                docker.image("${DOCKER_IMAGE}").remove()
            }
        }
    }
}
