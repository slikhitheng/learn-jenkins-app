pipeline {
    agent any

    stages {
        stage('BuildStage') {
            agent {
                docker {
                    image 'node:22-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm cache clean --force
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }
    }
}
