pipeline {
    agent any 
    
    tools {
        maven 'MAVEN_HOME'
    }
    stages {
        stage("Build Maven") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ShahadSha/simple-java-maven-app']]])
                sh "mvn clean install"
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    sh 'docker build -t maven-docker .'
                }
            }
        }
        stage("AWS ECR Login") {
            steps {
                script {
                    sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws'
                }
            }
        }
        stage("AWS ECR Push") {
            steps {
                script {
                    sh 'docker tag maven-docker:latest public.ecr.aws/x3x3m9h6/maven-docker:${BUILD_NUMBER}'
                    sh 'docker push public.ecr.aws/x3x3m9h6/maven-docker:${BUILD_NUMBER}'
                }
            }
        }
        stage("Helm Chart ECR Push") {
            steps {
                sh "echo version : 1.${BUILD_NUMBER}.1 >> java-helm/Chart.yaml"
                sh 'helm package java-helm'
                sh 'aws ecr-public get-login-password --region us-east-1 | helm registry login --username AWS --password-stdin public.ecr.aws'
                sh 'helm push java-helm-1.${BUILD_NUMBER}.1.tgz oci://public.ecr.aws/x3x3m9h6/'
                sh 'rm -rf java-helm-*'
            }
        }
        stage("Invoking Pipeline B") {
            steps {
                script {
                    build job: 'Pipeline-B', parameters: [[$class: 'StringParameterValue', name: 'buildnum', value:  "${BUILD_NUMBER}"]]
                }
            }
        }

        
    }
}