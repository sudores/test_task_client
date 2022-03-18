pipeline {
    agent any
    //environment {
    //    USER         = "vepl"
    //    IMAGE_NAME   = "test-task-client"
    //    COMMIT       = ""
    //    IMAGE_TAG    = ""
    //}
    stages {
        stage("Need") {
            steps {
                echo 'environment is done, need is runing'
                script {
                    env.COMMIT = sh 'git log --pretty=format:'%h' -1'
                    echo env.COMMIT
                }
            }
        }
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
                script {
                    def img = docker.build("$USER/$IMAGE_NAME:$COMMIT", ".")
                    img.push("$USER/$IMAGE_NAME:$COMMIT")
                }
           } 
        }

    }
}
