pipeline {
    agent any

    stages {
        stage('Prepare Docker') {
            steps {
                script {
                    // Пробуем скачать образ с 3 попытками
                    retry(3) {
                        sh 'docker pull node:18-alpine || true'
                    }
                    // Проверяем, что образ действительно загрузился
                    def imageExists = sh(script: 'docker inspect --type=image node:18-alpine >/dev/null 2>&1 && echo "exists" || echo "not exists"', returnStdout: true).trim()
                    if (imageExists == "not exists") {
                        error("Docker image node:18-alpine не был загружен!")
                    }
                }
            }
        }

        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                    // Дополнительные настройки, если нужно
                    args '-v /tmp:/tmp'  // пример монтирования volume
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
    }
}