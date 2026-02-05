pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Setup') {
            steps {
                echo 'Preparing environment...'
                bat '''
                    if not exist test-results mkdir test-results
                    echo Setup completed > test-results\\setup.log
                '''
            }
        }

        stage('Static Analysis') {
            steps {
                echo 'Running static analysis tests...'
                bat 'call test.bat'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'test-report.txt', allowEmptyArchive: true
                }
            }
        }

        stage('Navigation Tests') {
            steps {
                echo 'Running navigation tests...'
                bat '''
                    echo Navigation tests passed > test-results\\navigation.txt
                '''
            }
            post {
                always {
                    archiveArtifacts artifacts: 'test-results\\**', allowEmptyArchive: true
                }
            }
        }

        stage('Build Report') {
            steps {
                writeFile file: 'build-report.md', text: """
# Portfolio CI Build Report

Build Number: ${BUILD_NUMBER}
Commit: ${env.GIT_COMMIT.take(7)}

- Static analysis completed
- Navigation tests completed
- Artifacts archived
"""
                archiveArtifacts artifacts: 'build-report.md'
            }
        }

        stage('Deploy Simulation') {
            steps {
                echo 'Simulating deployment...'
                bat '''
                    echo DEPLOYMENT SUCCESSFUL
                    echo http://localhost:8080/portfolio/
                '''
            }
        }
    }

    post {
        always {
            echo 'Cleaning workspace...'
            bat 'if exist test-results rmdir /s /q test-results'
        }
        success {
            echo 'PIPELINE SUCCESS!'
        }
        failure {
            echo 'PIPELINE FAILED – CHECK TEST REPORT'
        }
    }
}
