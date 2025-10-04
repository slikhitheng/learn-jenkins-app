pipeline {
    agent any

    environment {
        BUILD_DIR = 'build'
        INDEX_HTML = 'index.html'
        NETLIFY_SITE_ID = 'eb5a1fab-7af2-472e-975a-6cee64e37a47'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
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
                            //args '-u root:root' !!! don't do this!!  TO SPEWCIFY ANOTHER USER & GROUP
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

        stage('Deploy') {
            agent {
                docker {
                    image 'node:22-alpine'
                    reuseNode true
                }
            }

            steps {
                sh '''
                    npm install netlify-cli
                    node_modules/.bin/netlify --version
                    echo "Deploying to production. Site ID: $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy --dir=build --prod --no-build
                '''
            }
        }

        stage ('Prod E2E Testing') {
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