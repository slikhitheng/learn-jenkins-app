Jenkins Installation on Local machine using Docker Desktop
	https://github.com/vdespa/install-jenkins-docker  clone to local folder
	
	1. Build Docker : docker build -t my-jenkins .
	2. Start Jenkins: 	docker compose up -d
	3. Open Jenkins by going to: http://localhost:8080/ and finish the installation process.
	4. If you wish to stop Jenkins and get back to it later, run: docker compose down
	5. Removing Jenkins: docker compose down --volumes --rmi all 
	
	***************************************************************************
	
	1. Configure Jenkins:
	
	login inside container
	docker ps --> get container id of jenkins
	docker exec -it 02c84b48e87b /bin/bash
	cat /var/jenkins_home/secrets/initialAdminPassword and get password 
	
	NOTE: Docker Desktop doesn't start or open. Go to BIOS and enable virtualization (Hyper-V).  Also, ensure that Virtual Machine and Hyper-V were enabled in the Windows settings.
	
	username:AWS-Learning password: AWS-Learning
	
	2. Installing "Stage view" Jenkins plugin  --> Pipeline: Stage View 
	
	***************************************************************************
	
	JENKINS BASICS
	
		1. Jenkins workspace : is directory on Jenkins controller where agent build and stores results 
				job --> workspace --> path to workspace where jenkins is saving all the files
				
				SOLUTION 1 : TO CLEAN UP WORKSPACE DIRECTORY --> USE POST BUILD ACTIONS IN JENKINS
				
						post {
							always {
								cleanWs()
							}
						}
				
				SOLUTION 2 : If only the pipeline is successful so we can keep the Build artifact and clean workspace before start of jobs. so put cleanWs() as first line in first step.

						pipeline {
						agent any

						stages {
							stage('Build') {
								steps {
									cleanWs()
				
						*********************************
						
							post {
								success {
									archiveArtifacts artifacts: 'build/**'
								}
							}
						
				NOTE : if we have always and success in post build step : always will get priority and executed first 
						
		2. Defining environment variables
		
				GLOBAL VARIABLE AVAIALABKE FOR ALL STAGES TO BE USED --> BUILD_FILE_NAME
				
					pipeline {
					agent any

					environment {
						BUILD_FILE_NAME = 'laptop.txt'
					}

					stages {
						stage('Build') {
							steps {
								cleanWs()
								echo 'Building a new laptop ...'
								sh '''
									echo $BUILD_FILE_NAME
									mkdir -p build
									
	***************************************************************************
	
	PIPELINE AS CODE - MEANS STORING JENKINSFILE INSIDE SOURCE CODE IN GITHUB
	
		TO GET MORE KNOWLEDGE ON PIPELINE AS CODE : USE BELOW PROJECT SETUP
		
		clone repo into local and github --> git@github.com:Pushpie0801/learn-jenkins-app.git 
		Open Code into vscode and from terminal add dependancy --> npm install
		
		
MAIN STEPS TO BUILD APPLICATION FROM LOCALLY TO JENKINS 

	1. We used some steps to run on local machine like nmp install or npm start
			and now we want jenkins to do this task for us so inorder to automate any task , we need to check if that software is availale on jenkins nodes?
			
			for example --> we need to run npm command to build ,
							to check if we have npm install on jenkins --> create new job and run npm --version to test .
		TO RESOLVE THIS SOFTWARE ISSUE ->
			1. Install software manually on jenkins Agent 
			2. use docker with container
		***************************************************************************
		***************************************************************************		
	To use docker in steps for jenkins Piple line --> add docker plugin in jenkins 	--> Docker Pipeline
	
				pipeline {
					agent any

					stages {
						stage('docker') {
							agent {
								docker {
									image 'node:18-alpine'
								}
							}
							steps {
								sh 'npm --version'
							}
						}
					}
				}			
				
	HOW JENKINS WORKS WITH CONTAINERS: AND WHAT HAPPEN TO WORKSPACE WITH DOCKER AND WITHOUT DOCKER 
	
	 IF USING CONTAINER -> JENKINS AGENT CREATE CONTAINER WITH DOCKER IMAGE AND EXECUTE STEPS AND ONCE WORK DONE , STOPS CONTAINER 
	 
	 FOR WORKSPACE - BY DEFAULT BOTH WILL CREATE THEIR OWN WORKSPACE FOLDER IN WORKSPACE
			
			TO SHARE SAME WORKSPACE BY DOCKER AS WELL AS OTHER JOBS IN JENKINS NODE , WE NEED TO PASS :::  reuseNode true
			
			https://www.jenkins.io/doc/book/pipeline/docker/#workspace-synchronization 
	 
	    ***************************************************************************
		***************************************************************************	
	2. BACK TO PROJECT , CREATE Jenkisfile in project in vs code

			1. create Jenkinsfile 
			2. create new job in jenkins and in Pipeline section --> use Pipleline script from SCM and provide github details 
			 also validate all parameters and jenkinsfile name should match with source code.
			 
			 pipeline {
				agent any

				stages {
					stage('Build') {
						agent {
							docker {
								image 'node:18-alpine'
								reuseNode true
							}
						}
						steps {
							sh '''
								ls -la
								node --version
								npm --version
								npm ci
								npm run build
								ls -la
							'''
						}
					}
				}
			}

3. Add test stage 

pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }

            steps {
                sh '''
                    test -f build/index.html
                    npm test
                '''
            }
        }
    }
}


4. Publishing a JUnit test report : Junit report is a file generated by junit testing framework in java project in XML format

pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }

            steps {
                sh '''
                    test -f build/index.html
                    npm test
                '''
            }
        }
    }

    post {
        always {
            junit 'test-results/junit.xml'
        }
    }
}




			
		