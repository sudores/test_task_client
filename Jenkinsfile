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
                echo 'environment is done, need is runing'
                echo "USER $USER"
                echo "IMAGE_NAME $IMAGE_NAME"
                COMMIT = getStartedCommit()
                echo "$COMMIT"
                echo "COMMIT $COMMIT"
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
