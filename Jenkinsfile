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
                    sh 'docker build -t my-app .'
                    sh 'mvn -version'
                }
            }
        }
         
    
        stage('Push image') {
            withDockerRegistry([ credentialsId: "dockerhubaccount", url: "https://hub.docker.com/u/fayizv" ]) {
                dockerImage.push()
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

        stage("Quality gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }
       
    }
}
