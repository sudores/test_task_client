pipeline {
    agent any
    environment {
        USER         = "vepl"
        IMAGE_NAME   = "test-task-client"
        COMMIT       = ""
    }
    stages {
        stage("Need") {
            steps {
                script {
                    echo 'environment is done, need is runing'
                    echo "USER $USER"
                    echo "IMAGE_NAME $IMAGE_NAME"
                    COMMIT = getStartedCommit()
                    echo "$COMMIT"
                    echo "COMMIT $COMMIT"
                }
            }
        }
        stage("Test") {
            agent docker {
                image "node:17.7.1-alpine3.14"
            }
            steps {
                sh """set -e; yarn; yarn test --all --watchAll=false"""
            }
        } 
        stage("Build") {
            steps {
                script {
                    img = docker.build("$USER/$IMAGE_NAME:$COMMIT", ".")
                    img.push()
                    img.push("latest")
                }
           } 
        }

    }
}

// Get commit id which triggered build 
String getStartedCommit() {
    String result = sh(
            returnStdout: true,
            script: "git log -1 --pretty=format:'%h'"
            ).trim()
    return result
}
