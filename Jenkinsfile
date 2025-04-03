pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    #!/bin/bash
                    ls -la
                    node --version
                    npm --version

                    # Install dependencies
                    npm ci

                    # Build the project
                    npm run build
                    ls -la
                    
                '''

            }
        }
    }
}
