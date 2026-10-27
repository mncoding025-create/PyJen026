pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install -r requirements.txt
                    python -m py_compile app.py
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    . .venv/bin/activate
                    pytest -v --junitxml=test-results.xml
                '''
            }
            post {
                always {
                    junit 'test-results.xml'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    mkdir -p deploy
                    cp app.py deploy/
                    echo "Deployed app.py to $(pwd)/deploy"
                    echo "5 + 7" | python3 -c "from deploy.app import add; print('Smoke test: 5 + 7 =', add(5, 7))"
                '''
            }
        }
    }

    post {
        success { echo 'Build, test, deploy สำเร็จ' }
        failure { echo 'Pipeline ล้มเหลว' }
    }
}
