pipeline {
    agent any

    stages {
        stage('without docker') {
			steps{
				echo 'without docker'
			}
        }
		stage ('parllel'){
			parallel{
				stage('stage 1'){
					agent {
						docker{
							image 'node:18-alpine'
							reuseNode true
						}
					}
					steps{
						echo 'with docker 1'
					}
				}
				stage('stage 2'){
					agent {
						docker{
							image 'node:18-alpine'
							reuseNode true
						}
					}
					steps{
						echo 'with docker 2'
					}
				}
			}
		}
    }
	post{
		failure {
			echo 'always'
		}
	}
}

