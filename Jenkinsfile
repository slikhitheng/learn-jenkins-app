pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    test -d build || { echo "Error: build directory not found"; exit 1; }
                    ls -la
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'node:18-alpine'
                }
            }
            steps {
                sh '''
                    npm ci  # Ensure dependencies are installed
                    test -d build || mkdir build  # Ensure build directory exists
                    npm test
                '''
            }
        }

        stage('E2E') {
            agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.50.1-noble'
                }
            }
            steps {
                sh '''
                    npm install serve
                    nohup node_modules/.bin/serve -s build > serve.log 2>&1 &
                    sleep 15
                    curl -I http://localhost:3000 || { echo "Server failed to start"; exit 1; }
                    npx playwright install --with-deps
                    npx playwright test --reporter=junit,junit-results.xml
                '''
            }
        }
    }

    post {
        always {
            junit 'junit-results.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report'])
        }
    }
}
