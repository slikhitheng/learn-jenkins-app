pipeline {
    agent any

    environment {
        BUILD_DIR = 'build'
        INDEX_HTML = 'index.html'
        NETLIFY_SITE_ID = 'eb5a1fab-7af2-472e-975a-6cee64e37a47'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
        REACT_APP_VERSION = "1.0.$BUILD_ID"
    }

    stages {
        // this is a comment
        /*
            this is a block comment
            second line
        */
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

        stage ('Run Tests') {
            parallel { 
                stage ('Unit Testing') {
                    agent {
                        docker {
                            image 'node:22-alpine'
                            reuseNode true
                        }
                    }

                    steps {
                        echo 'Testing the app ...'
                        sh '''
                            #test -f $BUILD_DIR/'index.html'  this is of course a linux comment
                            npm test
                        '''
                    }

                    post {
                        always {
                            junit 'jest-results/junit.xml'
                        }
                    }
                }

                stage ('End2End Testing') {
                    agent {
                        docker {
                            image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                            reuseNode true
                            //args '-u root:root' !!! don't do this!!  TO SPECIFY ANOTHER USER & GROUP
                        }
                    }

                    steps {
                        echo 'Testing the app ...'
                        sh '''
                            npm install serve
                            node_modules/.bin/serve -s build &
                            sleep 10
                            npx playwright test --reporter=html
                        '''
                    }

                    post {
                        always {
                           publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Local E2E - HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                        }
                    }
                }
            }
        }

       stage ('Staging Deployment & E2E Testing') {
            agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                    reuseNode true
                    //args '-u root:root' !!! don't do this!!  TO SPECIFY ANOTHER USER & GROUP
                }
            }
            
            environment {
                 CI_ENVIRONMENT_URL='STAGING_URL_TO_BE_SET'
            }

            steps {
                echo 'Testing the app in production ...'
                sh '''
                    npm install netlify-cli node-jq
                    node_modules/.bin/netlify --version
                    echo "Deploying to staging. Site ID: $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy --dir=build --no-build --json > staging-output.json
                    CI_ENVIRONMENT_URL=$(node_modules/.bin/node-jq -r '.deploy_url' staging-output.json)
                    npx playwright test --reporter=html
                '''
            }

            post {
                always {
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'STAGING E2E - HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                }
            }
        }

/*      Bu approval stage ile continious indelivery yapıyor idik. Bunu kaldırarak continious deployment'a geçmiş oluyoruz
        stage ('Approval') {
           steps {
                 timeout(time: 1, unit: 'MINUTES') {
                    input message: 'Ready to Deploy?', ok: 'Yes, I am sure I want to deploy!', cancel: 'No, under no circumstances!'
                }
            }
        }
*/

        stage ('Prod Deploction deployment & E2E Testing') {
            agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                    reuseNode true
                    //args '-u root:root' !!! don't do this!!  TO SPECIFY ANOTHER USER & GROUP
                }
            }
            
            environment {
                 CI_ENVIRONMENT_URL='https://production-babsom.netlify.app'
            }

            steps {
                echo 'Testing the app in production ...'
                sh '''
                    node --version
                    npm install netlify-cli
                    node_modules/.bin/netlify --version
                    echo "Deploying to production. Site ID: $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    
                    node_modules/.bin/netlify deploy --dir=build --prod --no-build
                    npx playwright test --reporter=html
                '''
            }

            post {
                always {
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'PROD E2E - HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                }
            }
        }

     }
}