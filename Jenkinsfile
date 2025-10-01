pipeline {
    agent any

    environment {
        BUILD_DIR = 'build'
        INDEX_HTML = 'index.html'
    }

    stages {
        stage('Build') {
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
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }

        stage ('Test') {
            agent {
                docker {
                    image 'node:22-alpine'
                    reuseNode true
                }
            }
            
            steps {
                echo 'Testing the app ...'
                sh '''
                    test -f $BUILD_DIR/'index.html'
                    npm test
                '''
            }
        }

    }
}
 
