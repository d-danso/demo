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
                           // Run tests if needed
                           bat 'mvn test'
                       }
                   }

                   stage('Deploy') {
                       steps {
                           // Copy the JAR file to the Docker context
//                            bat 'cp target/demo-0.0.1-SNAPSHOT.jar .'
                           // Build Docker image
                           bat 'docker build -t demo-app .'
                           // Run Docker container
                           bat 'docker run -d -p 8081:8081 --name demo-container demo-app'
                       }
                   }
    }
     post {
            always {
                // Clean up Docker container and image after use
                bat 'docker stop demo-container'
                bat 'docker rm demo-container'
                bat 'docker rmi demo-app:latest'
            }
        }}
