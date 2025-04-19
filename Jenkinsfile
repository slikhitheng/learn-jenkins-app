pipeline {
    agent any
    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/rahul-009-git/learn-jenkins-app.git'
            }
        }

        stage('Check Git Directory') {
            steps {
                sh 'ls -la'
                sh 'git status'
                sh 'git rev-parse --is-inside-work-tree'
                sh 'git remote -v'
            }
        }

        stage('Say Hello') {
            steps {
                echo 'Hello World'
                sh 'echo "hello from jenkins"'
                sh 'whoami'
            }
        }
    }
}
