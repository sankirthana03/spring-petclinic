pipeline {
    agent {label 'nginx-container'}
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage('git checkout') {
            steps {
               git url: 'https://github.com/sankirthana03/spring-petclinic.git',
                   branch: 'main'
            }
        }
    //     stage('build, test and scan') {
    //         steps {
    //           withCredentials([string(credentialsId: 'sk_id', variable: 'SONAR_TOKEN')]) {
    //           withSonarQubeEnv('Sonar') {
    //             sh '''mvn package sonar:sonar \
    //                   -Dsonar.projectKey=sankirthana03_spring-petclinic \
    //                   -Dsonar.organization=sankirthana03 \
    //                   -Dsonar.host.url=https://sonarcloud.io/ \
    //                   -Dsonar.login=$SONAR_TOKEN'''
    //         }
    //       }
    //     }
    //     post {
    //       always {
    //         junit 'target/surefire-reports/*.xml'
    //     }
    //   }
    //  }
    //  stage('Binary file store') {
    //    rtupload (
    //       serverId: 'JFROG',
    //       spec: '''{
    //           "files": [
    //               {
    //               "pattern": "target/*.jar",
    //               "target": "spcjava-spc"
    //               }
    //           ]  
    //   }'''
    //   )
    //  }
        stage('Pull image from dockerhub and push to ECR') {
           steps {
            sh '''docker image pull nginx:1.29 && \
                  aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 174323547094.dkr.ecr.us-east-1.amazonaws.com && \
                  docker tag nginx:1.29 174323547094.dkr.ecr.us-east-1.amazonaws.com/dev/spc-repo:latest && \
                  docker push 174323547094.dkr.ecr.us-east-1.amazonaws.com/dev/spc-repo:latest'''
          }
        }
   }
}
