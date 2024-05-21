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

    stages {
        stage('Build') {
            steps {
                // Build your Java application using Maven
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run tests if needed
                // sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                // Copy the JAR file to the Docker context
                sh 'cp target/demo-0.0.1-SNAPSHOT.jar .'
                // Build Docker image
                sh 'docker build -t demo-app .'
                // Run Docker container
                sh 'docker run -d -p 8081:8081 --name demo-container demo-app'
            }
        }
    }
}
