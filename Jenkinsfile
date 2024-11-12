pipeline {
    agent any
        stage('w/ docker') {
            agent {
                docker {
                    image 'node:22.11.0-alpine3.20'
                    reuseNode true
                }
            }
            steps {
                sh 'echo "With docker"'
                sh 'node --version'
                sh 'npm --version'
                sh 'npm ci'
                sh 'npm run build'
            }
        }
    }
}