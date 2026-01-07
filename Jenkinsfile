@Library('my-shared-library') _

pipeline {
    agent {
        kubernetes {
            label 'kaniko'
            defaultContainer 'jnlp'
        }
    }

    environment {
        IMAGE = "123456789012.dkr.ecr.eu-west-1.amazonaws.com/flask-app"
        TAG   = "${BUILD_NUMBER}"
        NAMESPACE = "qa"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                kanikoBuild(
                    image: IMAGE,
                    tag: TAG
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
