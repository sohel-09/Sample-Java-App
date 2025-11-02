pipeline {
    agent any

    environment {
        PROJECT_ID = "fluted-factor-438905-d2"
        REGION = "asia-south1"
        REPO = "java-sample-repo"
        IMAGE_NAME = "java-sample-app"
        GAR_PATH = "${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO}/${IMAGE_NAME}"
        GCP_KEY_PATH = "C:/Users/LENOVO/Downloads/gcp-key.json"
    }

    stages {

        stage('Checkout Source Code') {
            steps {
                git branch: 'main', url: 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Authenticate to GCP') {
            steps {
                sh "gcloud auth activate-service-account --key-file=${GCP_KEY_PATH}"
                sh "gcloud auth configure-docker ${REGION}-docker.pkg.dev --quiet"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Get Current Version') {
            steps {
                script {
                    def tags = sh(script: "gcloud artifacts docker tags list ${GAR_PATH} --format='value(tag)' || true", returnStdout: true).trim().split('\n')
                    def versionNumbers = tags.findAll { it ==~ /v\\d+/ }.collect { it.replace('v','').toInteger() }
                    def latestVersion = versionNumbers ? versionNumbers.max() : 0
                    env.NEW_VERSION = "v${latestVersion + 1}"
                    echo "✅ New image version: ${env.NEW_VERSION}"
                }
            }
        }

        stage('Tag and Push Docker Image') {
            steps {
                sh """
                    docker tag ${IMAGE_NAME}:latest ${GAR_PATH}:${NEW_VERSION}
                    docker push ${GAR_PATH}:${NEW_VERSION}
                """
            }
        }
    }

    post {
        success {
            echo "🎉 Docker image pushed successfully: ${GAR_PATH}:${NEW_VERSION}"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
