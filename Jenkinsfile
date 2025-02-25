pipeline {
    agent any

    stages {
        stage('docker') {
            agent {
                docker {
                    image 'node:18-alpine'
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

        stage('test')  {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    test -f build/index.html
                    npm test
                    '''
            }
        }
    }

    post {
        always {
            sh 'ln -s test-results/junit.xml $WORKSPACE'
            junit './test-results/junit.xml'
        }
    }
}
