pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred-attilio')
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t adicorato/msr-new:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push adicorato/msr-new:latest'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}