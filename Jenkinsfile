pipeline {
    agent {
        docker {
            image 'node:18'
        }
    }

    stages {
        stage('Hello') {
            steps {
                sh '''
                echo "Hello from Jenkins"
                npm --version 
                test -f build/index.html && echo "Файл найден, все хорошо"
                npm test
                '''
            }
        }
    }
}
