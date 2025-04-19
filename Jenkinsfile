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
        stage("Test"){
            steps{
                sh'''
                if[-f build/index.html]; then
                    echo"found the file"
                fi
                npm  test
                '''
            }
        }

    }
}
