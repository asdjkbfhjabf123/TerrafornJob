node {
    stage("Git Clone") {
        git 'https://github.com/asdjkbfhjabf123/TerraformJob.git'
    }
    stage("Maven Clean Build") {
      // def mvnHome = tool name: 'Maven', type: 'maven'
       sh "mvn package"
    }
    stage('terraform started') {
                sh 'echo "Started...!" '
        }
    stage("Create Docker Image") {
        sh "docker build -t 853306/spring-boot-mongo ."
    }
    stage("Push Docker Image") {
    sh "docker login -u 853306 -p pintu1996"
    sh "docker push 853306/spring-boot-mongo "
    }
    stage('terraform init, validate, plan and apply') {
                withCredentials([string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                      string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh '''
            sudo terraform init
            sudo terraform validate
            sudo terraform plan
            sudo terraform apply -auto-approve
            '''
            } 
           input 'destroy'
            stage('terraform destroy') {
                withCredentials([string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                      string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh 'sudo terraform destroy -auto-approve'
            }
            }
          }
         stage("Deploy Application To K8s") {
          sh 'kubectl create -f springBootMongo.yml' 
}
}
