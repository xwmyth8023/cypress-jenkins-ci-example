pipeline {
  agent {
    // this image provides everything needed to run Cypress
    docker {
      image 'cypress/base:10'
    }
  }

  stages {
    // first stage installs node dependencies and Cypress binary
    stage('build') {
      steps {
        container('docker'){
        
          // there a few default environment variables on Jenkins
          // on local Jenkins machine (assuming port 8080) see
          // http://localhost:8080/pipeline-syntax/globals#env
          echo "Running build ${env.BUILD_ID} on ${env.JENKINS_URL}"
          sh 'npm ci'
        }
      }
    }

    // this stage runs end-to-end tests, and each agent uses the workspace
    // from the previous stage
    stage('cypress parallel tests') {

      // https://jenkins.io/doc/book/pipeline/syntax/#parallel
      parallel {
        // start several test jobs in parallel, and they all
        // will use Cypress Dashboard to load balance any found spec files
        stage('tester A') {
          steps {
            container('docker'){
              echo "Running build ${env.BUILD_ID}"
              sh "npm test"
            }
          }
        }

        // second tester runs the same command
        stage('tester B') {
          steps {
            container('docker'){
            
              echo "Running build ${env.BUILD_ID}"
              sh "npm test"
            }
          }
        }
      }
    }
  }

  post {
    // shutdown the server running in the background
    always {
      echo 'Stopping local server'
    }
  }
}