pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                sh '''
                echo "Hello from Jenkins"
                test -f build/index.html && echo "Файл найден"
                npm install
                npm --version
                npm test
                '''
            }
        }
    }
}
