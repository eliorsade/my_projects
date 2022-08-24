pipeline {
  agent { node { label 'Slave_1' } }

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
	  stage('To update sources of the website') {
         steps {
	 sh '''
	    echo "Input param ${NAME}"		
	    echo "<p>Hello from ${NAME}!</p>" >> index.html
	 '''
         }
      }
	  
      stage('Build a docker image') {
         steps {
            echo 'Build process..'            
            sh '''
                docker build -t="mywebsite:${BUILD_NUMBER}" .
            '''
         }
      }
      stage('Push a docker image') {
         steps {
			sh '''
				docker tag mywebsite:${BUILD_NUMBER} ${REPO_NAME}/web-server:${BUILD_NUMBER}
				docker push ${REPO_NAME}/web-server:${BUILD_NUMBER}
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
				docker run -d -p 80:80 ${REPO_NAME}/web-server:${BUILD_NUMBER} /bin/bash
				echo "Check the URL: http://`hostname`:80"
			'''
         }
      }
      
   }
}
