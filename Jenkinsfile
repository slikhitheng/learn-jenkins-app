pipeline {
    agent any
 
    environment {
        NETLIFY_SITE_ID = '9ed4aaa5-1d8f-44e7-a08d-c4bc61c77513'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
        // Define environment variables for email configuration
        EMAIL_RECIPIENTS = 'satishjanghel@tranetechnologies.com'
        EMAIL_SUBJECT_SUCCESS = 'Deployment Successful'
        EMAIL_SUBJECT_FAILURE = 'Deployment Failed'
    }
 
    stages {
 
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
                            junit 'test-results/junit.xml'
                        }
                    }
                }
 
                stage('E2E') {
                    steps {
                        sh 'echo "Perform E2E test here.."'
                    }
                }
            }
        }
 
        stage('Deploy') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    npm install netlify-cli@20.1.1
                    node_modules/.bin/netlify --version
                    echo "Deploying to production. Site ID: $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy --dir=build --prod
                '''
            }
        }
    }

    post {
        success {
            script {
                emailext(
                    to: "${env.EMAIL_RECIPIENTS}",
                    subject: "${env.EMAIL_SUBJECT_SUCCESS}",
                    mimeType: 'text/html',
                    body: "The deployment was successful.\\n\\nJob: ${env.JOB_NAME}\\nBuild Number: ${env.BUILD_NUMBER}\\nBuild URL: ${env.BUILD_URL}"
                )
            }
        }

        failure {
            script {
                emailext(
                    to: "${env.EMAIL_RECIPIENTS}",
                    subject: "${env.EMAIL_SUBJECT_FAILURE}",
                    mimeType: 'text/html',
                    body: "The deployment failed.\\n\\nJob: ${env.JOB_NAME}\\nBuild Number: ${env.BUILD_NUMBER}\\nBuild URL: ${env.BUILD_URL}"
                )
            }
        }
    }
}