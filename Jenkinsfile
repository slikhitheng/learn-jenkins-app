pipeline {
    agent any

    environment {
        NETLIFY_SITE_ID = '5442992f-7eab-44d7-82cb-6fdfcb958f70'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
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
                            junit 'jest-results/junit.xml'
                        }
                    }
                }

                stage('E2E') {
                    agent {
                        docker {
                            image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
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
                            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                        }
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
                    npm install netlify-cli
                    node_modules/.bin/netlify --version
                    echo "Deploying to production. Site ID: $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy --no-build --dir=build --prod
                '''
            }
        }
    }
}




















// pipeline {
//     agent any

//     environment {
//         NETLIFY_SITE_ID = '5442992f-7eab-44d7-82cb-6fdfcb958f70'
//         NETLIFY_AUTH_TOKEN = credentials('netlify-token')
//     }

//     stages {

//         stage('Build') {
//             agent {
//                 docker {
//                     image 'node:18-alpine'
//                     reuseNode true
//                 }
//             }
//             steps {
//                 sh '''
//                     ls -la
//                     node --version
//                     npm --version
//                     npm ci
//                     npm run build
//                     ls -la
//                 '''
//             }
//         }

//         stage('Tests') {
//             parallel {
//                 stage('Unit tests') {
//                     agent {
//                         docker {
//                             image 'node:18-alpine'
//                             reuseNode true
//                         }
//                     }

//                     steps {
//                         sh '''
//                             #test -f build/index.html
//                             npm test
//                         '''
//                     }
//                     post {
//                         always {
//                             junit 'test-results/junit.xml'
//                         }
//                     }
//                 }

//                 stage('E2E') {
//                     agent {
//                         docker {
//                             image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
//                             reuseNode true
//                         }
//                     }

//                     steps {
//                         sh '''
//                             npm install serve
//                             node_modules/.bin/serve -s build &
//                             sleep 10
//                             npx playwright test  --reporter=html
//                         '''
//                     }

//                     post {
//                         always {
//                             publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
//                         }
//                     }
//                 }
//             }
//         }

//         stage('Deploy') {
//             agent {
//                 docker {
//                     image 'node:18-alpine'
//                     reuseNode true
//                 }
//             }
//             steps {
//                 sh '''
//                     apk add --no-cache bash
//                     npm install netlify-cli
//                     node_modules/.bin/netlify --version
//                     echo "Deploying to production. Site ID: $NETLIFY_SITE_ID"
//                     node_modules/.bin/netlify status
//                     node_modules/.bin/netlify deploy --dir=build --prod
//                 '''
//             }
//         }
//     }
// }



















// ====================

// pipeline {
//     agent any

//     stages {
//         stage('Build') {
//             agent {
//                 docker {
//                     image 'node:18-alpine'
//                     reuseNode true
//                 }
//             }
//             steps {
//                 sh '''
//                     ls -la
//                     node --version
//                     npm --version
//                     npm ci
//                     npm run build
//                     ls -la
//                 '''
//             }
//         }

//         stage('Test') {
//             agent {
//                 docker {
//                     image 'node:18-alpine'
//                     reuseNode true
//                 }
//             }

//             steps {
//                 sh '''
//                     test -f build/index.html
//                     npm test
//                 '''
//             }
//         }
//     }

//     post {
//         always {
//             junit 'test-results/junit.xml'
//         }
//     }
// }



// ================

// pipeline {
//     agent any

//     stages {
//         stage('Build') {
//             agent {
//                 docker {
//                     image 'node:18-alpine'
//                     reuseNode true
//                 }
//             }
//             steps {
//                 sh '''
//                     ls -la
//                     node --version
//                     npm --version
//                     npm install
//                     npm run build || echo "Build failed"
//                     ls -la
//                 '''
//             }
//         }

//         stage('Test') {
//             agent {
//                 docker {
//                     image 'node:18-alpine'
//                     reuseNode true
//                 }
//             }
//             steps {
//                 sh '''
//                     test -f build/index.html
//                     npm test || echo "Tests failed"
//                 '''
//             }
//         }
//     }

//     post {
//         always {
//             script {
//                 if (fileExists('test-results/junit.xml')) {
//                     junit 'test-results/junit.xml'
//                 } else {
//                     echo "No JUnit test results found."
//                 }
//             }
//         }
//     }
// }