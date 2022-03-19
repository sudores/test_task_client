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
                    COMMIT = getStartedCommit()
                    echo "USER $USER"
                    echo "IMAGE_NAME $IMAGE_NAME"
                    echo "COMMIT $COMMIT"
                    echo "BRANCH $BRANCH_NAME"
                }
            }
        }
        stage("Test") {
            when {
                not {
                    equals expected: 0, actual: currentBuild.changeSets.size() 
                }
            }
            agent {
                docker {
                    image "node:17.7.1-alpine3.14"
                }
            }
            steps {
                sh """set -e; yarn; yarn test --all --watchAll=false"""
            }
        } 
        stage("Build") {
            when {
                anyOf {
                    branch "master";
                    branch "dev";
                }
            }
            steps {
                script {
                    img = docker.build("$USER/$IMAGE_NAME-$BRANCH_NAME:$COMMIT", ".")
                }
           } 
        }
        stage("Deploy") {
            when {
                anyOf {
                    branch "master";
                    branch "dev";
                }
            }
            steps {
                script {
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

