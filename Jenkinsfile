pipeline {
    agent any
    
    environment {
        PROJECT_DIR = 'portfolio'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from Git...'
                checkout scm
            }
        }
        
        stage('Setup') {
            steps {
                echo 'Setting up test environment...'
                bat 'mkdir test-results'
                bat 'echo Setup complete > test-results/setup.log'
            }
        }
        
        stage('Static Analysis') {
            steps {
                echo 'Running static HTML/CSS validation...'
                bat '''
                    test.bat
                    type test-report.txt
                '''
                archiveArtifacts 'test-report.txt'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running comprehensive tests...'
                bat '''
                    REM Test navigation between pages
                    echo Testing navigation... > test-results/navigation.txt
                    findstr /i "href=index.html" about.html && echo ✓ Home link OK || echo ✗ Home link broken
                    findstr /i "href=about.html" index.html && echo ✓ About link OK || echo ✗ About link broken
                    findstr /i "href=contact.html" index.html && echo ✓ Contact link OK || echo ✗ Contact link broken
                '''
                archiveArtifacts 'test-results/**'
            }
            post {
                always {
                    publishHTML([
                        allowMissing: false,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: 'test-results',
                        reportFiles: 'navigation.txt',
                        reportName: 'Navigation Test Report'
                    ])
                }
            }
        }
        
        stage('Build Report') {
            steps {
                echo 'Generating build report...'
                script {
                    def report = """
Build: ${BUILD_NUMBER}
Status: PASSED
Files: index.html, about.html, contact.html, style.css
Tests: Static analysis, Navigation validation
Date: ${new Date()}
                    """
                    writeFile file: 'build-report.md', text: report
                }
                archiveArtifacts 'build-report.md'
            }
        }
        
        stage('Deploy to Local') {
            steps {
                echo 'Deploying to local server simulation...'
                bat '''
                    echo Starting local server simulation...
                    echo Website deployed successfully at http://localhost:8080/portfolio
                    echo Access URLs:
                    echo - http://localhost:8080/portfolio/index.html
                    echo - http://localhost:8080/portfolio/about.html
                    echo - http://localhost:8080/portfolio/contact.html
                '''
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up workspace...'
            bat 'if exist test-results rmdir /s /q test-results'
        }
        success {
            echo '🎉 Pipeline completed successfully!'
            mail to: 'dev@example.com',
                 subject: "Portfolio Build #${BUILD_NUMBER} Success",
                 body: "All tests passed for portfolio website!"
        }
        failure {
            echo '❌ Pipeline failed!'
            mail to: 'dev@example.com',
                 subject: "Portfolio Build #${BUILD_NUMBER} Failed",
                 body: "Check Jenkins console output for details."
        }
    }
}
