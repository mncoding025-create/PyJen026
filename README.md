# PyJen026

โปรแกรมบวกเลขด้วย Python + CI/CD ด้วย Jenkins

## รันในเครื่อง
    python3 app.py
    python3 -m pytest -v

## 1) Push ขึ้น GitHub
สร้าง repo ว่างบน GitHub ชื่อ `PyJen026` แล้วรัน:

    cd PyJen026
    git init
    git add .
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin https://github.com/<USERNAME>/PyJen026.git
    git push -u origin main

## 2) ติดตั้ง Jenkins
### ทางเลือก A: Docker Desktop
    docker compose up -d --build
    docker compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
เปิด http://localhost:8080 ใส่รหัสด้านบน แล้วเลือก "Install suggested plugins"

### ทางเลือก B: Homebrew
    brew install jenkins-lts
    brew services start jenkins-lts
(เครื่องต้องมี python3 และ git)

### ทางเลือก C: ไม่ใช้ Docker/Homebrew (ใช้ Java อย่างเดียว)
1. ติดตั้ง Java 21 (Temurin .pkg จาก https://adoptium.net) และ Python 3 + git (macOS มักมี git/python3 ผ่าน Xcode Command Line Tools: `xcode-select --install`)
2. รัน `./run-jenkins.sh` (ดาวน์โหลด jenkins.war แล้วเปิดที่ http://localhost:8080)
3. ใส่รหัสที่แสดงใน terminal แล้วเลือก "Install suggested plugins"

## 3) สร้าง Pipeline job
1. New Item -> ตั้งชื่อ `PyJen026` -> เลือก **Pipeline**
2. Pipeline -> Definition: **Pipeline script from SCM** -> SCM: **Git**
3. Repository URL: URL ของ repo, Branch: `*/main`, Script Path: `Jenkinsfile`
4. ติ๊ก trigger อย่างใดอย่างหนึ่ง:
   - **Poll SCM** ตั้ง `* * * * *` (ง่ายสุด ไม่ต้องใช้ webhook)
   - หรือ **GitHub hook trigger for GITScm polling** + ngrok:
     `ngrok http 8080` แล้วใส่ `https://<ngrok-url>/github-webhook/`
     ที่ GitHub repo -> Settings -> Webhooks (Content type: application/json, event: push)
5. Save -> Build Now

## 4) ทดสอบอัตโนมัติ
แก้ `app.py` แล้ว `git commit` + `git push` Jenkins จะ build, test, deploy เอง
จากนั้นแคปหน้าจอผล Build (Stage View / Console Output) ส่งอาจารย์
