pipeline {
    agent { docker { image 'ruby' } }

    /* agent { docker { image 'ruby' } } */
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'sudo docker-compose build'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'rails test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}
