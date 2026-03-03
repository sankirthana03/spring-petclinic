pipeline {
    agent {label 'JAVA'}
    stages {
        stage('git checkout') {
            steps {
               git url: 'https://github.com/sankirthana03/spring-petclinic.git',
                   branch: 'main'
            }
        }
        stage('build, test and scan') {
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
        stage('Binary file store') {
          steps {
            rtUpload (
              serverId: 'JFROG',
              spec: '''{
              "files": [
                  {
                  "pattern": "target/*.jar",
                  "target": "spcjava-spc/"
                  }
              ]  
           }'''
         )
          //rtPublishBuildInfo(serverId: 'JFROG')
        }
      }
    }
     post {
          always {
            junit 'target/surefire-reports/*.xml'
           }
         }
  }
