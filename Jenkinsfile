pipeline {
    agent any

    environment{
       REACT_APP_VERSION = "1.0.$BUILD_ID"
       AWS_DEFAULT_REGION = 'us-east-1'

    }
    stages {
/*
        stage('Docekr'){
            steps{
                sh'''
                docker image build -t my-playwright .

                '''
            }
        }
*/    


        stage('Build') {
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

        stage('build Docker image') { 
            steps {
                sh '''
                    docker image build   -t myjenkinsapp .
                '''
            }
        }






   
   
    }
}
