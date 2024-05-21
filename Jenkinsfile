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
  // Use docker directive for containerized build environment
  agent {
    docker {
      image 'maven:3.9.6-eclipse-temurin-17-alpine'
      args '-v /var/run/docker.sock:/var/run/docker.sock'  // Optional: Mount Docker socket for container-to-container communication
      workingDir '/home/jenkins'  // Working directory inside the container (lowercase drive)
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
        sh 'mvn clean package'  // Use 'sh' for shell commands within the container
      }
    }
    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."  // Use string interpolation for image name and tag
      }
    }
    stage('Run Docker Container') {
      steps {
        sh "docker run -d -p 8081:8080 --name demo-app-container ${DOCKER_IMAGE}:${DOCKER_TAG}"
      }
    }
  }
  // Post actions in 'always' will run even if a stage fails
  post {
    always {
      sh 'docker stop demo-app-container'  // Ensure container name matches the created one
      sh 'docker rm demo-app-container'
    }
  }
  // Cleanup actions in 'cleanup' will only run if the pipeline succeeds
  cleanup {
    sh "docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG}"  // Replace with actual image name and tag
  }
}
