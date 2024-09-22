pipeline {
    agent any

    stages {
        stage('w/odocker') {
            steps {
                sh '''
                    echo 'without docker'
                    ls -la
                    touch container-no.txt
                '''
            }
        }
        stage('w docker') {
            agent {
                docker {
                    image 'node:18-alpine'
                    args '-u root' // Optional: Run as root user if needed
                }
            }
            steps {
                sh '''
                    echo 'with docker'
                    ls -la
                    touch container-yes.txt
                '''
            }
        }
    }
}


