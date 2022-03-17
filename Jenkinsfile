pipeline {
    agent any
    stages {
        stage("Test") {
            steps {
                sh 'node -v'
                sh 'npm -v'
                sh 'yarn -v'
                sh 'yarn run install'
                sh 'yarn run test'
            }
        }
    }
}
