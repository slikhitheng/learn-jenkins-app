pipeline {
    agent any

    stages {
       /*  
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
        */
        stage("Test"){
            agent{
                docker{
                  image 'node:18-alpine'
                    reuseNode true  
                }
            }
            steps{
                sh'''
                echo "Test stage"
                if [ -f build/index.html ]; then
                   echo "found the file"
                fi
                npm  test
                '''
            }
        }
        stage("E2E"){
            agent{
                docker{
                  image 'mcr.microsoft.com/playwright:v1.52.0-noble'
                  reuseNode true  
                }
            }
            steps{
                sh'''
                npm install  serve
                serve node_modules/.bin/serve -s build
                npx playwright test
                '''
            }
        }

    }
    post{
        always{
            junit 'test-results/junit.xml'
        }
    }
}
