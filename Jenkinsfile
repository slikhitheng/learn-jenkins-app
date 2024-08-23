pipeline {
    agent any

    stages {
        stage('Yapi') {
            agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                    reuseNode true
                }
            }
            steps {
                /*
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    ls -la
                '''
                */
                sh '''
                    npm install --save-dev @playwright/test
                    npx playwright install
                    npx playwright test
                '''
            }
            
        }
        stage('Test'){
		    agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
				}
            }
            steps {
                sh '''
                    echo "Test aşaması.."
                    test -f  public/index.html
                    npm test
                '''
            }
        }
    }
    post {
        always {
            echo 'Her zaman çalışırım'
            junit 'test-results/junit.xml'
        }
        success {
            echo 'Başarılıysa çalışırım'
        }
        failure {
            echo 'Hatalıysam çalışırım'
        }
    }
}
