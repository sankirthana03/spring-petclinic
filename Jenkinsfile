pipeline {
    agent {label 'JAVA'}
    triggers{
        pollSCM('* * * * *')
    }
    stages {
        stage ('git checkout') {
            steps {
               git url: 'https://github.com/sankirthana03/spring-petclinic.git',
                   branch: 'main'
            }
        }
        stage ('build and scan') {
            steps {
              withCredentials([string(credentialsId: 'myid', variable: 'SONAR_TOKEN')]) {
              withSonarQubeEnv('Sonar') {
                sh """mvn package Sonar:Sonar \
                      -Dsonar.projectkey=sankirthana03_spring-framework \
                      -Dsonar.organization=sankirthana03 \
                      -Dsonar.host.url=https://sonarcloud.io/ \
                      -Dsonar.login=$SONAR_TOKEN"""
            }
          }
        }
     }
   }
}
