pipeline {
  agent any

   stages {
      stage('Clone Sources') {
        steps {	  
          checkout scm
        } 
      }
	  stage('Checking environment') {
         steps {
            sh 'printenv'
         }
      }
	  
	  
      stage('Build a docker image') {
         steps {
            echo 'Build process..'            
            sh '''
                docker build -t="mywebsite:${BUILD_NUMBER}" -f Dockerfile-non-m1 .
            '''
         }
      }
      stage('Push a docker image') {
         steps {
			sh '''
				docker tag mywebsite:${BUILD_NUMBER} ${REPO_NAME}/webserver-non-mac:${BUILD_NUMBER}
				docker push ${REPO_NAME}/webserver-non-mac:${BUILD_NUMBER}
			'''
         }
      }
      stage('Deploy the website') {
         steps {
            echo 'Deploy process..'
			sh '''
				echo "Stopping running containers"
				CONTAINER=`docker ps -q`
				if [ -z "$CONTAINER" ]; then
					echo "No running containers. Nothing to stop"
				else									
					docker stop ${CONTAINER}
					docker rm ${CONTAINER}
				fi
				echo "Running a new container"
				docker run -d -p 80:80 ${REPO_NAME}/webserver-non-mac:${BUILD_NUMBER}
				echo "Check the URL: http://`hostname`:80"
			'''
         }
      }
      
   }
}
