pipeline {
  agent any

  environment {
    NODE_ENV = "${BRANCH_NAME}"
    CYPRESS_CACHE_FOLDER="./cache/Cypress"
  }

  stages {
    // first stage installs node dependencies and Cypress binary
    stage('build') {
      when { anyOf { branch 'main'; branch 'master'; branch 'qa' } }
      steps {
        // there a few default environment variables on Jenkins
        // on local Jenkins machine (assuming port 8080) see
        // http://localhost:8080/pipeline-syntax/globals#env
        echo "Running build ${env.BUILD_ID} on ${env.JENKINS_URL}"
        // sh "export CYPRESS_CACHE_FOLDER=cache/Cypress"
        // sh 'chown -R $(whoami) "~/.npm"'
        // sh 'npm cache clean --force'
        // sh 'npm ci'
        sh "echo ${NODE_ENV}"
        sh "make docker-build"
      }
    }

    // this stage runs end-to-end tests, and each agent uses the workspace
    // from the previous stage
    stage('cypress parallel tests') {
      when { anyOf { branch 'main'; branch 'master'; branch 'qa' } }
      steps { 
        sh "make docker-run"
      }
      // https://jenkins.io/doc/book/pipeline/syntax/#parallel
      // parallel {
      //   // start several test jobs in parallel, and they all
      //   // will use Cypress Dashboard to load balance any found spec files
      //   stage('tester A') {
      //     steps {
      //       echo "Running build ${env.BUILD_ID}"
      //       sh "npm test"
      //     }
      //   }

      //   // second tester runs the same command
      //   stage('tester B') {
      //     steps {
      //       echo "Running build ${env.BUILD_ID}"
      //       sh "npm test"
      //     }
      //   }
      // }
    }

    stage('Clean Image'){
      steps {
        sh "make docker-clean"
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
