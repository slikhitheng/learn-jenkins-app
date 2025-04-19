pipeline {
    agent any
    stages {

        stage('Clean Workspace') {
            steps {
                deleteDir() // Cleans the workspace before any build
            }
        }
        stage('Checkout SCM') {
            steps {
                checkout scm // Checks out the code from the configured Git repository
            }
        }
        stage('Hello') {
            steps {
                echo 'Hello World'
                sh 'echo "hello from jenkins"'
                echo 'who am i'
            }
        }
    }
}
