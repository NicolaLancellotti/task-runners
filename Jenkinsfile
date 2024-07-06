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
                sh './run.sh venv_create'
            }
        }
        stage('Checks') {
            parallel {
                stage('Format') {
                    steps {
                        sh './run.sh format_check'
                    }
                }
                stage('Lint') {
                    steps {
                        sh './run.sh lint'
                    }
                }
                stage('Test') {
                    steps {
                        sh './run.sh test_and_coverage'
                    }
                }
                stage('Run') {
                    steps {
                        sh './run.sh run --help'
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
