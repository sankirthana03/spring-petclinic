pipeline {
    agent {label 'JAVA'}
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
        stage('build and scan') {
            steps {
              withCredentials([string(credentialsId: 'sk_id', variable: 'SONAR_TOKEN')]) {
              withSonarQubeEnv('Sonar') {
                sh '''mvn package sonar:sonar \
                      -Dsonar.projectKey=sankirthana03_spring-petclinic \
                      -Dsonar.organization=sankirthana03 \
                      -Dsonar.host.url=https://sonarcloud.io/ \
                      -Dsonar.login=$SONAR_TOKEN'''
            }
          }
        }
     }
   }
}
