pipeline {
    agent {label 'JAVA'}
    stages {
        stage ('git checkout') {
            steps {
               git url: 'https://github.com/sankirthana03/spring-petclinic.git',
                   branch: 'main'
            }
        }
        stage ('build and scan') {
            steps {
                sh 'mvn package Sonar:Sonar'
            }
        }
    }
}
