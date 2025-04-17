pipeline {
    agent{
        docker{
            image 'node:18'
        }
    }

    stages {
        stage('Hello') {
            steps {
                sh '''
                echo "Hello from Jenkins"
                test -f build/index.html && echo "Файл найден"
                npm --version
                npm test
                '''
            }
        }
    }
}
