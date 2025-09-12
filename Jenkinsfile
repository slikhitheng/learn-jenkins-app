pipeline {
  agent any
  options {
      timeout(time:10, unit: 'SECONDS')
  }
  environment {
    NAME = 'Yehor'
  }
  stages {
    stage('Hello') {
      steps {
        echo 'Cleaning the workspace..'
        cleanWs()

        sh '''
          mkdir -p build
          echo "Test artifact" > build/output.txt
        '''

        sh 'whoami'
        echo '-------------------'
        echo "Hello ${env.NAME}"
        echo "The Build Number is: ${env.BUILD_NUMBER}"
        echo "The Build URL is: ${env.BUILD_URL}"
      }
    }
  }
  
  post {
      success {
          archiveArtifacts artifacts: 'build/**'
      }
  }
}