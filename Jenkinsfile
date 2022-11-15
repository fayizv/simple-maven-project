pipeline{
    agent any
    tools {
        maven 'local_maven'
    }
    stages {
        stage("Build Maven") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/fayizv/simple-maven-project']]])
            }
        }       
       stage("Build Docker Image") {
            steps {
                script {
                    sh 'docker build -t my-app:1.01 .'
                    sh 'mvn -version'
                }
            }
        }
         
       stage('pushing to dockerhub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                    // some block
                    sh 'docker login -u fayizv -p ${dockerhubpwd}'
                    }
//                     sh 'docker tag my-app:1.01 fayizv/myapp:1.01 '
//                     sh 'echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin'

                    sh 'docker push fayizv/myapp:1.01 '
                }
            }
        }  
        
        stage('logout docker') {
            steps {
                script {
                    sh 'docker logout'
                }
            }
        }

        
        stage('build && SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonarqube-9.2.2') {
                    // Optionally use a Maven environment you've configured already
                   
                        sh 'mvn clean package sonar:sonar'
                    
                }
            }
        }

//         stage("Quality gate") {
//             steps {
//                 waitForQualityGate abortPipeline: true
//             }
//         }
       
    }
}
