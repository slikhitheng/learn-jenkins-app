pipeline {
    agent any
    
    stages {
        stage("Build"){
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps{
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

        stage("Test"){
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps{
                sh '''
                    test -f build/index.html
                    npm test
                '''
            }
        }

        
        stage("E2E"){
            agent {
                docker {
                    image 'mcr.microsoft.com/playwrite:v1.39.0-jammy'
                    reuseNode true
                }
            }
            steps{
                sh '''
                    npm install -g serv
                    serve -s build
                    npx playwrite test
                '''
            }
        }
    }

    post {
        always {
            junit 'test-results/junit.xml'
        }
    }
    
}