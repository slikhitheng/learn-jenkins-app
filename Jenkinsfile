pipeline {
    agent any

    stages {
        stage('docker') {
            agent {
                docker {
                    image 'docker:20.10.7'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node -v
                    npm -v
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }
    }
}
