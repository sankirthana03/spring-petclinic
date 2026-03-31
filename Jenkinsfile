pipeline {
    agent { label 'JAVA' }

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

        stage('Pull Docker Image') {
            steps {
                sh '''
                sudo docker pull nginx:1.29
                '''
            }
        }

        stage('Trivy Scan') {
            steps {
                sh '''
                trivy image \
                  --format template \
                  --template "@contrib/junit.tpl" \
                  -o trivy-report.xml \
                  nginx:1.29
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region us-east-1 | \
                sudo docker login --username AWS --password-stdin 174323547094.dkr.ecr.us-east-1.amazonaws.com

                sudo docker tag nginx:1.29 174323547094.dkr.ecr.us-east-1.amazonaws.com/dev/spc-repo:latest

                sudo docker push 174323547094.dkr.ecr.us-east-1.amazonaws.com/dev/spc-repo:latest
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'trivy-report.xml', fingerprint: true
            junit 'trivy-report.xml'
        }
    }
}