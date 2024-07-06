pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/NicolaLancellotti/task-runners.git'
            }
        }
        stage('Requirements') {
            steps {
                sh './script.sh venv-create'
            }
        }
        stage('Checks') {
            parallel {
                stage('Format') {
                    steps {
                        sh './script.sh format-check'
                    }
                }
                stage('Lint') {
                    steps {
                        sh './script.sh lint'
                    }
                }
                stage('Test') {
                    steps {
                        sh './script.sh test-and-coverage'
                    }
                }
                stage('Run') {
                    steps {
                        sh './script.sh run --help'
                    }
                }
            }
        }
    }
    post {
      always {
        junit '**/DerivedData/junitxml.xml'
        recordCoverage(tools: [[parser: 'COBERTURA', pattern: '**/DerivedData/coverage.xml']])
      }
   }
}
