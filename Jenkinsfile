pipeline {
    agent { label 'nginx-container' }

    triggers {
        pollSCM('* * * * *')
    }

    parameters {
        choice(
            name: 'goals',
            choices: ['package', 'clean install', 'verify'],
            description: 'Select the Maven goal to execute during the build'
        )
    }

    stages {

        stage('Git Checkout') {
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
    // some
       stage('Pull image from DockerHub and push to ECR') {
            steps {
                sh '''
                sudo docker pull nginx:1.29

                aws ecr get-login-password --region us-east-1 | \
                sudo docker login --username AWS --password-stdin 174323547094.dkr.ecr.us-east-1.amazonaws.com

                sudo docker tag nginx:1.29 174323547094.dkr.ecr.us-east-1.amazonaws.com/dev/spc-repo:latest

                sudo docker push 174323547094.dkr.ecr.us-east-1.amazonaws.com/dev/spc-repo:latest
                '''
            }
        }
    }
}