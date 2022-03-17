pipeline {
    agent any
    stages {
        stage("Test") {
            steps {
                sh 'node -v'
                sh 'npm -v'
                sh 'yarn -v'
                sh 'yarn install'
                sh 'yarn run test'
            }
        } 
        stage("Build") {
            steps {
                sh 'docker build . -t vepl/test_task_client:latest'
                sh 'docker push vepl/test_task_client:latest'
            }
        }

    }
}
