<?xml version='1.1' encoding='UTF-8'?>
<flow-definition plugin="workflow-job@1207.ve6191ff089f8">
  <actions>
    <org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobAction plugin="pipeline-model-definition@2.2114.v2654ca_721309"/>
    <org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobPropertyTrackerAction plugin="pipeline-model-definition@2.2114.v2654ca_721309">
      <jobProperties/>
      <triggers/>
      <parameters>
        <string>Language</string>
      </parameters>
      <options/>
    </org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobPropertyTrackerAction>
    <org.jenkinsci.plugins.workflow.multibranch.JobPropertyTrackerAction plugin="workflow-multibranch@716.vc692a_e52371b_">
      <jobPropertyDescriptors>
        <string>org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty</string>
      </jobPropertyDescriptors>
    </org.jenkinsci.plugins.workflow.multibranch.JobPropertyTrackerAction>
  </actions>
  <description>Jenkins Project</description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <com.coravy.hudson.plugins.github.GithubProjectProperty plugin="github@1.34.5">
      <projectUrl>https://github.com/eliorsade/my_projects.git/</projectUrl>
      <displayName></displayName>
    </com.coravy.hudson.plugins.github.GithubProjectProperty>
    <hudson.model.ParametersDefinitionProperty>
      <parameterDefinitions>
        <hudson.model.ChoiceParameterDefinition>
          <name>Language</name>
          <description>Scriping languages</description>
          <choices class="java.util.Arrays$ArrayList">
            <a class="string-array">
              <string>All</string>
              <string>C</string>
              <string>Python</string>
              <string>Bash</string>
            </a>
          </choices>
        </hudson.model.ChoiceParameterDefinition>
      </parameterDefinitions>
    </hudson.model.ParametersDefinitionProperty>
    <org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
      <triggers>
        <hudson.triggers.SCMTrigger>
          <spec>* * * * *</spec>
          <ignorePostCommitHooks>false</ignorePostCommitHooks>
        </hudson.triggers.SCMTrigger>
      </triggers>
    </org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsFlowDefinition" plugin="workflow-cps@2759.v87459c4eea_ca_">
    <script>pipeline {
  agent any
  parameters {
    choice(
      name: &apos;Language&apos;,
      choices: [&apos;All&apos;, &apos;C&apos;, &apos;Python&apos;, &apos;Bash&apos;],
      description: &apos;Scriping languages&apos;
    )
  }
  stages {
    stage(&apos;GitHub&apos;) {
            steps {
                script {
                    properties([pipelineTriggers([pollSCM(&apos;* * * * *&apos;)])])
                }
                git branch: &apos;Jenkins_Project&apos;, url: &apos;https://github.com/eliorsade/my_projects&apos;
                sh &apos;&apos;&apos;
                     echo ${WORKSPACE}
                     ls -ltr
                &apos;&apos;&apos;
            }
        }
    stage(&apos;Print Language&apos;) {
      steps {
          script{
              if ( Language == &apos;All&apos; )
              {    
                  echo &apos;You chose the execute all scripts (Python, Bash and C)&apos;
              }
              else
              {
                  echo &quot;The scripting language is ${params.Language}&quot;
              }
          }
        
      }
    }
  
    stage(&apos;log_files&apos;){
        steps{
          sh &apos;&apos;&apos;
                  mkdir -p &quot;${WORKSPACE}/logs&quot;
                  results_file=&quot;${WORKSPACE}/logs/results.txt&quot;
                  
                  if [ -f &quot;${results_file}&quot; ]; then
                        echo &quot;file ${results_file} exists&quot;
                  else
	                     touch ${results_file}
                        fi
                        chmod a+rwx &quot;${WORKSPACE}/logs/results.txt&quot;
                        
              &apos;&apos;&apos;
              sh &apos;true &gt; ${WORKSPACE}/logs/results.txt&apos;
             
        }
    }


    stage(&apos;Python&apos;) {
        when { expression { Language == &apos;Python&apos; || Language == &apos;All&apos; } }
            steps {
                retry(3) {
                sh &apos;&apos;&apos;
                    chmod +x ${WORKSPACE}/delete_files_python.py
                    python3 -u delete_files_python.py
                    echo &apos;Python scripts was successful&apos; &gt;&gt; &quot;${WORKSPACE}/logs/results.txt&quot;
               &apos;&apos;&apos;
            }
            }
}

    stage(&apos;Bash&apos;) {
        when { expression { Language == &apos;Bash&apos; || Language == &apos;All&apos; } }
            steps {
                retry(3) {
                sh &apos;&apos;&apos;
                chmod +x ${WORKSPACE}/create-files.sh
                ./create-files.sh
                echo &apos;Bash scripts was successful&apos; &gt;&gt; &quot;${WORKSPACE}/logs/results.txt&quot;
                echo &apos;Bash scripts was successful&apos;
                &apos;&apos;&apos;
 //               description: &apos;Creates files in old files folder&apos;

            }
            }
}
    
        stage(&apos;C&apos;) {
        when { expression { Language == &apos;C&apos; || Language == &apos;All&apos; } }
            steps {
                retry(3) {
                sh &apos;&apos;&apos;
                chmod +xrw ${WORKSPACE}/c_script_test
                ./c_script_test
                echo &apos;C scripts was successful&apos; &gt;&gt; &quot;${WORKSPACE}/logs/results.txt&quot;
                echo &apos;C scripts was successful&apos;
                &apos;&apos;&apos;
                
            }
}
}




        stage(&apos;Saving Results&apos;) {
          steps {
              sh &apos;&apos;&apos;
            echo &apos;Cleaning files&apos;
            rm ${WORKSPACE}/delete_files_python.py*
            rm ${WORKSPACE}/c_script_test*
            rm ${WORKSPACE}/create-files.sh*
            rm ${WORKSPACE}/README.md
            echo &apos;Saving Results process..&apos;
          report_file=&quot;${WORKSPACE}/logs/report.txt&quot;
	      date &gt;&gt; ${report_file}
	      echo &quot;USER=$USER JOB_NAME=$JOB_NAME&quot; &gt;&gt; ${report_file}
          echo &quot;Build Number $BUILD_NUMBER&quot; &gt;&gt; ${report_file}
          cat &quot;${WORKSPACE}/logs/results.txt&quot; &gt;&gt; ${report_file}
	      echo &quot;#############################&quot; &gt;&gt; ${report_file}
            &apos;&apos;&apos;
         }
      }
}
post {

        success {
            echo &apos;Successfully done&apos;
        }
        failure {
            echo &apos;Failure in running this job&apos;
        }
    
  }


}
</script>
    <sandbox>true</sandbox>
  </definition>
  <triggers/>
  <disabled>false</disabled>
</flow-definition>
