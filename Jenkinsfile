pipeline {
    agent {
        node {
            label 'master'
        }
    }

    stages {

        stage('terraform started') {
            steps {
                sh 'echo "Started...!" '
            }
        }
        stage('git clone') {
            steps {
                 git 'https://github.com/asdjkbfhjabf123/TerraformJob.git'
            }
        }
        stage('terraform init') {
            steps {
                withCredentials([string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                      string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh '''
            terraform init
            terraform plan
            terraform apply -auto-approve
            '''
            }
          }
        }
        stage('terraform ended') {
            steps {
                sh 'echo "Ended....!!"'
            }
        }
    }
}
