pipeline {
    agent any
    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }
        stage('Checkout SCM') {
            steps {
                git url: 'https://github.com/rahul-009-git/learn-jenkins-app.git', branch: 'main'
            }
        }
        stage('Hello') {
            steps {
                echo 'Hello World'
                sh 'echo "hello from jenkins"'
                sh 'whoami'
            }
        }
    }
}
