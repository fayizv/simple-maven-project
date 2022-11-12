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
//         stage('SonarQube analysis') {
//         steps{
//         withSonarQubeEnv('sonarqube-9.2.2') { 
// //         sh "mvn sonar:sonar"
//     }
//         }
//         }
        
        stage('build && SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonarqube-9.2.2') {
                    // Optionally use a Maven environment you've configured already
                   
                        sh 'mvn clean package sonar:sonar'
                    
                }
            }
        }
//         stage("Quality Gate") {
//             steps {
//                 timeout(time: 1, unit: 'MINUTES') {
//                     // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
//                     // true = set pipeline to UNSTABLE, false = don't
//                     waitForQualityGate abortPipeline: true
//                 }
//             }
//         }
       
    }
}
