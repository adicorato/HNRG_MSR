pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('readData') {
      steps {
        git(url: 'https://github.com/adicorato/HNRG_MSR.git', branch: 'release')
      }
    }

    stage('build') {
      steps {
        powershell(script: 'docker build -t hnrg/adicorato/msr .', returnStatus: true, returnStdout: true)
      }
    }

  }
}