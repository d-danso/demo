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
  agent {
    docker {
      image 'maven:3.9.6-eclipse-temurin-17-alpine'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
  }
  environment {
    DOCKER_IMAGE = 'demo-app'
    DOCKER_TAG = 'latest'
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
      }
    }
    stage('Run Docker Container') {
      steps {
        sh "docker run -d -p 8081:8080 --name demo-app-container ${DOCKER_IMAGE}:${DOCKER_TAG}"
      }
    }
  }
  post {
    always {
      sh 'docker stop demo-app-container'
      sh 'docker rm demo-app-container'
    }
    success {
      sh "docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG}"
    }
  }
}
