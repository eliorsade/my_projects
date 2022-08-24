pipeline {
  agent any
  parameters {
    choice(
      name: 'Language',
      choices: ['All', 'C', 'Python', 'Bash'],
      description: 'Scriping languages'
    )
  }
  stages {
    stage('GitHub clone') {
        steps {	  
          checkout scm
          sh 'ls -ltr'
        } 
      }
    stage('Print Language') {
      steps {
          script{
              if ( Language == 'All' )
              {    
                  echo 'You chose the execute all scripts (Python, Bash and C)'
              }
              else
              {
                  echo "The scripting language is ${params.Language}"
              }
          }
        
      }
    }
  
    stage('log_files'){
        steps{
          sh '''
                  mkdir -p "${WORKSPACE}/logs"
                  results_file="${WORKSPACE}/logs/results.txt"
                  
                  if [ -f "${results_file}" ]; then
                        echo "file ${results_file} exists"
                  else
	                     touch ${results_file}
                        fi
                        chmod a+rwx "${WORKSPACE}/logs/results.txt"
                        
              '''
              sh 'true > ${WORKSPACE}/logs/results.txt'
             
        }
    }


    stage('Python') {
        when { expression { Language == 'Python' || Language == 'All' } }
            steps {
                retry(3) {
                sh '''
                    chmod +x ${WORKSPACE}/delete_files_python.py
                    python3 -u delete_files_python.py
                    echo 'Python scripts was successful' >> "${WORKSPACE}/logs/results.txt"
               '''
            }
            }
}

    stage('Bash') {
        when { expression { Language == 'Bash' || Language == 'All' } }
            steps {
                retry(3) {
                sh '''
                chmod +x ${WORKSPACE}/create-files.sh
                ./create-files.sh
                echo 'Bash scripts was successful' >> "${WORKSPACE}/logs/results.txt"
                echo 'Bash scripts was successful'
                '''
 //               description: 'Creates files in old files folder'

            }
            }
}
    
        stage('C') {
        when { expression { Language == 'C' || Language == 'All' } }
            steps {
                retry(3) {
                sh '''
                chmod +xrw ${WORKSPACE}/c_script_test
                ./c_script_test
                echo 'C scripts was successful' >> "${WORKSPACE}/logs/results.txt"
                echo 'C scripts was successful'
                '''
                
            }
}
}




        stage('Saving Results') {
          steps {
              sh '''
            echo 'Cleaning files'
            rm ${WORKSPACE}/delete_files_python.py*
            rm ${WORKSPACE}/c_script_test*
            rm ${WORKSPACE}/create-files.sh*
            rm ${WORKSPACE}/README.md
            rm ${WORKSPACE}/Jenkinsfile
            echo 'Saving Results process..'
          report_file="${WORKSPACE}/logs/report.txt"
	      date >> ${report_file}
	      echo "USER=$USER JOB_NAME=$JOB_NAME" >> ${report_file}
          echo "Build Number $BUILD_NUMBER" >> ${report_file}
          cat "${WORKSPACE}/logs/results.txt" >> ${report_file}
	      echo "#############################" >> ${report_file}
            '''
         }
      }
}
post {

        success {
            echo 'Successfully done'
        }
        failure {
            echo 'Failure in running this job'
        }
    
  }


}
