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
                '''
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'npm ci'
                }
                sh '''
                    npm run build
                    ls -la
                '''
            }
        }
        stage('Test'){
            steps{
                sh 'test -f build/index.html'
            }
        }
    }

}
