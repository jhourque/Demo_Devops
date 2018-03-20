pipeline {
    agent any

    stages {
        stage('WhereAmi') {
            steps {
                script {
                    if (scm.branches[0].name == 'master') {
                        echo 'I only execute on the master branch'
                    } else {
                        echo 'I execute elsewhere'
                    }
                    echo scm.branches[0].name
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
                    dir ("terraform/prod") {
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
