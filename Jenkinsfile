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
        stage('Tests'){
            parallel{
                
        stage("unit tests"){
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
         post{
        always{
            junit 'jest-results/junit.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'PlaywrightHTML Report', reportTitles: '', useWrapperFileDirectly: true])
        }
    }
        stage("E2E"){
            agent{
                docker{
                  image 'mcr.microsoft.com/playwright:v1.39.0-focal'
                  reuseNode true  
                }
            }
            steps{
                sh'''
                npm install  serve
                node_modules/.bin/serve -s build &
                sleep 10
                npx playwright test --reporter=html
                '''
            }
        }
         post{
        always{
            junit 'jest-results/junit.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'PlaywrightHTML Report', reportTitles: '', useWrapperFileDirectly: true])
        }
    }

            }

        }

    }
    post{
        always{
            junit 'jest-results/junit.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'PlaywrightHTML Report', reportTitles: '', useWrapperFileDirectly: true])
        }
    }
}
