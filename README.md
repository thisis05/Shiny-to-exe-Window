# Shiny-to-exe-Window

Creating Standalone Apps from Shiny with Electron [2023, Window]
Update ver : 2023.04.12

## test Version 

R ver 4.2.3
Window 11

## Before

1. Node.js 설치 https://nodejs.org/en

2. chocolatey 설치 https://chocolatey.org/install

  - Window PowerShell 관리자 권한으로 실행
  - Run :  choco install innoextract
  - Run : choco install sudo 
  
3. Electron forge 설치

  - Window Powershell (or any terminal) -> run : sudo npm i -g @electron-forge/cli
  
4. Cygwin 설치 https://cygwin.com/

   - https://superuser.com/questions/693284/wget-command-not-working-in-cygwin
   - wget packages 선택 후 설치
   
5. node, npm 버전 체크

  - Using any terminal
  - Run : node -v (maybe : 19.9.0 in 2023.04.12)
  - Run : npm -v (maybe : 9.6.3 in 2023.04.12 )

6. repo fork / clone to your local
  
  - https://github.com/thisis05/Shiny-to-exe-Window
  
--- 

## Main Process 

0. clone repository Rstudio에서 불러오기 및 Rstudio 실행
 

1. Electron local에 설치 

  - Using R studio Terminal
  - Run : npx create-electron-app [appName] 
  - My example appName : ShinyBasic
  
  ** local R version과 1.의 Shiny electron app의 R version이 같아야 함 **

2. 생성된 [appName] 폴더의 src directory를 clone repo의 src directory로 바꿔주기

3. [appName] 폴더에 다음 파일 copy 

  - get-r-win.sh : **반드시 R version in this file 체크 (local의 R version과 일치하는 지)** 
  - add-cran-binary-pkgs.R
  - start-shiny.R
  - shiny directory : 원하는 shiny app으로 바꿔도 무방, but example 해본 후 성공할 시 변경 추천

4. install package automagic 

  - install.packages("automagic") in console

5. App 생성

  - Run : cd [appName] : change Directroy 
  - Run : sh ./get-r-win.sh : R app 생성 (R version 별 기본 packages가 설치됨)
  - error 사항 https://github.com/lawalter/r-shiny-electron-app 의 Advanced Window steps 참조
  - check : [appName]/r-win 생성 확인
  
5. package.json 수정

  - license에 repository 추가
  - dependencies / devDependencies 수정
  - name / productName / author - name / author - email 수정정  
  - 수정 후 Run : sudo npm install in Terminal
{
  "name": "[Your exe file name]",
  "productName": "[Your exe file name]",
  "version": "1.0.0",
  "description": "My Electron application description",
  "main": "src/index.js",
  "scripts": {
    "start": "electron-forge start",
    "package": "electron-forge package",
    "make": "electron-forge make",
    "publish": "electron-forge publish",
    "lint": "echo \"No linting configured\""
  },
  "keywords": [],
  "author": {
    "name": "[UserName]",
    "email": "[User github e-mail]"
  },
  "license": "MIT",
    "repository": {
      "type": "git",
      "url" : "[Your git repo url]"
  },
  "dependencies": {
    "axios" : "0.27.2",
    "esm" : "^3.2.25",
    "execa" : "^5.1.1",
    "electron-squirrel-startup": "^1.0.0"
  },
  "devDependencies": {
    "@babel/core" : "^7.21.0",
    "@babel/plugin-transform-async-to-generator": "^7.20.7",
    "@babel/preset-env": "^7.20.2",
    "@babel/preset-react": "^7.18.6",
    "eslint": "^8.35.0",
    "eslint-config-airbnb": "^19.0.4",
    "eslint-plugin-import": "^2.27.5",
    "eslint-plugin-jsx-a11y": "^6.7.1",
    "eslint-plugin-react": "^7.32.2",
    "eslint-plugin-react-hooks": "^4.6.0",
    "fs-extra": "^11.1.0",
    "@electron-forge/cli": "^6.0.5",
    "@electron-forge/maker-deb": "^6.0.5",
    "@electron-forge/maker-rpm": "^6.0.5",
    "@electron-forge/maker-squirrel": "^6.0.5",
    "@electron-forge/maker-zip": "^6.0.5",
    "electron": "23.1.3"
  }
}

6. add-cran-binary-pkgs.R 수정 

  - user_pkgs에 필요한 packages 추가 
  - 저장 후 Run : Rscript add-cran-binary-pkgs.R
  - check : r-win/library에 설치한 packages가 정상적으로 존재하는지 확인

  
7. Exe test 
 - R studio restart
 - Run : electron-forge start

8. Exe build
 - Run : electron-forge make
 - wait....
 - out/[Your exe file name]-win32-x64/[Your exe file name].exe를 확인하실 수 있습니다.
 - [Your exe file name]-win32-x64 directory만 따로 빼서 배포가 가능합니다. 
 
 Error 사항들은 Issues에 남겨주시면 감사하겠습니다. 
 
 
 


