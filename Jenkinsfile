pipeline {
    agent any
    def terraformpath = ''

    stages {
        stage('WhereAmi') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/master') {
                        echo 'I only execute on the master branch'
                        terraformpath='terraform/prod'
                    } else if (env.GIT_BRANCH == 'origin/dev') {
                        echo 'I only execute on the dev branch'
                        terraformpath='terraform/dev'
                    } else {
                        echo 'I execute elsewhere'
                        echo env.GIT_BRANCH
                    }
                }
            }
        }
        stage('fmt') {
            steps {
                withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_creds',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    dir (terraformpath) {
                        sh 'terraform init'
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('plan') {
            steps {
                withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_creds',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    dir ("terraform/prod") {
                        sh 'terraform plan'
                    }
                }
            }
        }
        stage('apply') {
            steps {
                withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_creds',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    dir ("terraform/prod") {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
}
