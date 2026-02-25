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
              withSonarQubeEnv('Sonar') {
                sh 'mvn package Sonar:Sonar'
            }
          }
        }
    }
}
