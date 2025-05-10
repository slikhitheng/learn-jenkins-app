pipeline {
    agent any

    stages {
        stage('without docker') {
			steps{
				echo 'without docker'
			}
        }
		stage ('with docker'){
			agent {
				docker{
					image 'node:18-alpine'
				}
			}
			steps{
				echo 'with docker'
			}
		}

        }
    }
}
