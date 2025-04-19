pipeline {
    agent any

    stages {
        stage('Build') {
            agent{
                docker{
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh'''
                ls -al
                node --version
                npm --version
                npm ci
                ls 
                npm run build

                '''
            }
        }
    }
}
