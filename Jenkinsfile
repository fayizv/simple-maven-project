pipeline{
    agent any
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
                }
            }
        }
        stage('SonarQube analysis') {
        steps{
        withSonarQubeEnv('sonarqube-9.2.2') { 
//         sh "mvn sonar:sonar"
    }
        }
        }
       
    }
}
