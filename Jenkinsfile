pipeline {
  environment {
    registry = "34.27.123.128.sslip.io/testproject/myapp"
    registryCredential = 'Harbor'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/Isidrojhg/prismarepro.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Scan') {
            steps {
                // Scan the image | Input value from first script copied below, ''
                prismaCloudScanImage ca: '', cert: '', dockerAddress: 'unix:///var/run/docker.sock', ignoreImageBuildTime: true, image: '34.27.123.128.sslip.io/testproject/myapp*', key: '', logLevel: 'info', podmanPath: '', project: '', resultsFile: 'prisma-cloud-scan-results.json'
            }
        }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
  post {
      always {
        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
      }
  }
}
