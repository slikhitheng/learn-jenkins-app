pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                deleteDir()
                sh '''
                    ls -la 
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }
    }
}
