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

        post {
            always {
                JUnit 'test-results/test-results.xml'
            }
            // success {
            //     echo 'This will run only if successful'
            // }
            // failure {
            //     echo 'This will run only if failed'
            // }
            // unstable {
            //     echo 'This will run only if the run was marked as unstable'
            // }
            // changed {
            //     echo 'This will run only if the state of the Pipeline has changed'
            //     echo 'For example, if the Pipeline was previously failing but is now successful'
            }
        }
    }
}
