pipeline {
    agent any

    stages {
        stage('Parallel Stages') {
            parallel {
                stage('Stage 1') {
                    steps {
                        echo 'Running Stage 1'
                        sleep 5
                    }
                }
                stage('Stage 2') {
                    steps {
                        echo 'Running Stage 2'
                        sleep 3
                    }
                }
            }
        }
    }
}
