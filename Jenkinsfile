@Library('my-shared-library@feature/ks/jenkins-minikube') _

pipeline {

    agent { label 'k8s-agent' }

    stages {

        stage('Build Image') {
            steps {

                qaBuild(
                    repoUrl: 'https://github.com/krimeshshah/python-flaskapp.git',
                    imageRepo: 'localhost:5000/python-flaskapp'
                )

            }
        }

        stage('Deploy to QA') {
            when {
                branch 'main'
            }
            steps {
                sh """
                  kubectl set image deployment/flask-app \
                    flask-app=${IMAGE}:${TAG} \
                    -n ${NAMESPACE}
                """
            }
        }

    }

}
