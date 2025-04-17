pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'node:18-alpine'
        DOCKER_REGISTRY = 'registry-1.docker.io'  // или альтернативный mirror
    }

    stages {
        stage('Prepare Docker') {
            steps {
                script {
                    // Проверяем, есть ли образ локально
                    def imageExists = sh(script: "docker inspect --type=image ${DOCKER_IMAGE} >/dev/null 2>&1 && echo 'exists' || echo 'not exists'", returnStdout: true).trim()
                    
                    if (imageExists == 'not exists') {
                        echo "Образ ${DOCKER_IMAGE} не найден локально, пытаюсь загрузить..."
                        
                        // Пробуем загрузить с нескольких mirrors
                        def mirrors = [
                            "registry-1.docker.io/library/${DOCKER_IMAGE}",
                            "mirror.gcr.io/library/${DOCKER_IMAGE}",
                            "registry.yandex.net/library/${DOCKER_IMAGE}"
                        ]
                        
                        def pulled = false
                        for (mirror in mirrors) {
                            try {
                                echo "Пробую загрузить из ${mirror}"
                                sh "docker pull ${mirror}"
                                sh "docker tag ${mirror} ${DOCKER_IMAGE}"
                                pulled = true
                                break
                            } catch (Exception e) {
                                echo "Не удалось загрузить из ${mirror}: ${e.getMessage()}"
                            }
                        }
                        
                        if (!pulled) {
                            error("Не удалось загрузить образ ${DOCKER_IMAGE} ни из одного источника")
                        }
                    }
                }
            }
        }

        stage('Build') {
            agent {
                docker {
                    image "${DOCKER_IMAGE}"
                    reuseNode true
                    args '-v /tmp:/tmp'
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