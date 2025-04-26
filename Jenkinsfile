pipeline {
    agent any

    tools {
        nodejs 'LocalNodeJs'
    }

    stages {
        stage('Build') {
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
        stage('Test') {
            steps {
                sh '''
                    echo "Test stage"
                    npm test
                '''
            }
        }
        stage('E2E') {
            steps {
                sh '''
                    npm install -g serve
                    serve -s build
                    npx playwright test
                '''
            }
        }
    }
    post {
        always {
            junit 'test-results/junit.xml'
        }
    }
}
