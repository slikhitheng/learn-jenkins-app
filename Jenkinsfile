pipeline {
    agent any

    stages {
        stage('Yapi') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
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
        stage('Test'){
            steps {
                sh '''
                    echo "Test aşaması.."
                    test -f  public/index.html
                '''
            }
        }
    }
}
