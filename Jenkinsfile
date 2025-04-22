pipeline {
    agent any

    environment{
        NETLIFY_SITE_ID = '0564507d-66f9-4c48-a744-453f6ac6afed'
        NETLIFY_AUTH_TOKEN =  credentials('netlify-token')
    }

    stages {
        stage('Docekr'){
            steps{
                sh'''
                docker image build -t my-playwright .

                '''
            }
        }

        /*        
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

        
        stage('Tests') {
            parallel {
                stage('Unit tests') {
                    agent {
                        docker {
                            image 'node:18-alpine'
                            reuseNode true
                        }
                    }

                    steps {
                        sh '''
                            #test -f build/index.html
                            npm test
                        '''
                    }
                    post {
                        always {
                            junit 'jest-results/junit.xml'
                        }
                    }
                }

                stage('E2E') {
                    agent {
                        docker {
                            image 'mcr.microsoft.com/playwright:v1.39.0-focal'
                            reuseNode true
                        }
                    }

                    steps {
                        sh '''
                            npm install serve
                            node_modules/.bin/serve -s build &
                            sleep 10
                            npx playwright test  --reporter=html
                        '''
                    }

                    post {
                        always {
                            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright local HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                        }
                    }
                }
            }
        }
        */
        stage('deploy staging') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                   echo "small changes"
                   node_modules/.bin/netlify --version
                   echo "deploying the staging: ${NETLIFY_SITE_ID}"
                   node_modules/.bin/netlify status
                   node_modules/.bin/netlify deploy --dir=build --json > deploy-output.json
                   node_modules/.bin/node-jq -r .deploy_url  deploy-output.json
                '''
            script{
                env.STAGINING_URL = sh(script: ' node_modules/.bin/node-jq -r .deploy_url  deploy-output.json', returnStdout: true)
            }
            }
           
        } 

        stage('staging E2E') {
                agent {
                    docker {
                        image 'my-playwright'
                        reuseNode true
                    }
                }

                environment{
               // NETLIFY_SITE_ID = '0564507d-66f9-4c48-a744-453f6ac6afed'
               // NETLIFY_AUTH_TOKEN =  credentials('netlify-token')
                CI_ENVIRONMENT_URL = "$env.STAGINING_URL"
                }


                steps {
                    sh '''
                        echo "check the netlify website"
                        npx playwright test  --reporter=html
                    '''
                }

                post {
                    always {
                        publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright staging E2E Report', reportTitles: '', useWrapperFileDirectly: true])
                    }
                }
            }

        
        
        stage('Approval') {
            steps {
                timeout(time: 15, unit: 'MINUTES') {
                    input message: 'Do you wish to deploy to production?', ok: 'Yes, I am sure!'
                }
            }

        }
        stage('deploy proud') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                   echo "small changes"
                   npm install netlify-cli 
                   node_modules/.bin/netlify --version
                   echo "this is the production site env ${NETLIFY_SITE_ID}"
                   node_modules/.bin/netlify status
                   node_modules/.bin/netlify deploy --dir=build --prod
                '''
            }
        }

        stage('Prod E2E') {
                agent {
                    docker {
                        image 'my-playwright'
                        reuseNode true
                    }
                }

                environment{
               // NETLIFY_SITE_ID = '0564507d-66f9-4c48-a744-453f6ac6afed'
               // NETLIFY_AUTH_TOKEN =  credentials('netlify-token')
                CI_ENVIRONMENT_URL = 'https://superlative-kataifi-bc2e4d.netlify.app/'
                }


                steps {
                    sh '''
                        echo "check the netlify website"
                        npx playwright test  --reporter=html
                    '''
                }

                post {
                    always {
                        publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright E2E Report', reportTitles: '', useWrapperFileDirectly: true])
                    }
                }
            }
    }
}
