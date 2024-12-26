pipeline {
    agent any

    environment {
        IMAGE_NAME = 'swethagunnam/jenkins-flask-app'
        IMAGE_TAG = "${IMAGE_NAME}:${env.GIT_COMMIT}"
        
    }

    
    stages {

        stage('Setup') {
            steps {
                sh """
                    source /var/lib/jenkins/myenv/bin/activate
                    pip install -r requirements.txt
                    """
            }
        }
        stage('Test') {
            steps {
                sh '/var/lib/jenkins/myenv/bin/pytest'
            }
        }

        stage('Login to docker hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh 'echo ${PASSWORD} | docker login -u ${USERNAME} --password-stdin'}
                echo 'Login successfully'
            }
        }

        stage('Build Docker Image')
        {
            steps
            {
                sh 'docker build -t ${IMAGE_TAG} .'
                echo "Docker image build successfully"
                sh 'docker image ls'
                
            }
        }

        stage('Push Docker Image')
        {
            steps
            {
                sh 'docker push ${IMAGE_TAG}'
                echo "Docker image push successfully"
            }
        }      
    }
}