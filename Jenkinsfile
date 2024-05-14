// pipeline {
//     agent any
//     environment {
//         DOCKER_IMAGE = 'demo-app'
//         DOCKER_TAG = 'latest'
//         }
//
//
//     stages {
//         stage('Checkout') {
//             steps {
//                 checkout scm
//             }
//         }
//         stage('Build') {
//             steps {
//                 sh 'mvn clean package -DskipTests'
//             }
//         }
//         stage('Test') {
//             steps {
//                 sh 'mvn test'
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
//                     sh 'docker run -d -p 8081:8080 --name demo-app-container ${DOCKER_IMAGE}:${DOCKER_TAG}'
//                 }
//             }
//         }
//     }
//     post {
//         always {
//             // Clean up: Stop and remove the Docker container
//             script {
//                 sh 'docker stop demo-app-container || true'
//                 sh 'docker rm demo-app-container || true'
//             }
//         }
//         cleanup {
//             // Remove the Docker image
//             script {
//                 sh 'docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG} || true'
//             }
//         }
//     }
// }
pipeline {
    agent { docker { image 'maven:3.9.6-eclipse-temurin-17-alpine' } }
    stages {
        stage('build') {
            steps {
                sh 'mvn --version'
            }
        }
    }
