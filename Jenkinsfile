pipeline {
    agent any

    stages {
        stage('AmIMaster') {
            when { branch 'master' }
            steps {
                echo 'I m on master'
            }
        }
        stage('AmIDev') {
            when { branch 'dev' }
            steps {
                echo 'I m on dev'
            }
        }
        stage('fmt') {
            when { branch 'master' }
            steps {
                withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_creds',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    dir ("terraform/prod") {
                        sh 'terraform init'
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('plan') {
            when { branch 'master' }
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
            when { branch 'master' }
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
