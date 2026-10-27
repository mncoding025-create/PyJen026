#!/bin/bash
# รัน Jenkins แบบไม่ต้องใช้ Docker/Homebrew (ต้องมี Java 17 หรือ 21)
set -e
cd "$(dirname "$0")"
mkdir -p jenkins-local && cd jenkins-local

if ! command -v java >/dev/null; then
  echo "ไม่พบ Java: ติดตั้ง Temurin 21 จาก https://adoptium.net แล้วรันใหม่"; exit 1
fi

[ -f jenkins.war ] || curl -L -o jenkins.war https://get.jenkins.io/war-stable/latest/jenkins.war

export JENKINS_HOME="$PWD/home"
echo "เปิด http://localhost:8080  (รหัสเริ่มต้นจะแสดงด้านล่าง / อยู่ที่ $JENKINS_HOME/secrets/initialAdminPassword)"
java -jar jenkins.war --httpPort=8080
