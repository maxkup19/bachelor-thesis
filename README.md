## StudentChrono

### About app 

Student Chrono is a mobile application that helps teachers and students to manage school tasks and the process of their elaboration. 
The application has 2 roles: teacher and student. Teachers should choose their role during registration and be older than 18 y.o.
Teachers can add students by their email and manage tasks for students, student solve tasks and provide their solution through pdf or images in the chat in task detail.

### Server deploying

The source code for server application is in 'studentChrono_server/' folder. To start the application locally you need to download [Docker](https://www.docker.com/) on your local machine. You need to have running Docker application to proceed to further steps:
- run 'docker compose build' -- to build image of application and wait when it is finished
- run 'docker compose up' -- to start running the application

You can open localhost url, that you will see after running 'docker compose up' and check if everything ok. Yous should get "This is StudentChrono!" as an output.

Also the app is already deployer to Heroku and can be accessed by URL 'https://student-chrono-ff033acb5f18.herokuapp.com/\'

### Mobile app

To run a mobile app you need to install [Xcode](https://apps.apple.com/ua/app/xcode/id497799835?mt=12) and build application from the IDE.
App is available for public test in TestFlight by URL 'https://testflight.apple.com/join/ENm8Gj5q\'

Here are already created testing accounts:

| Email             | Password  | Role    |
|-------------------|-----------|---------|
|teacher1@gmail.com | qwerty123 | teacher |
|student1@gmail.com | qwerty123 | student |
|student2@gmail.com | qwerty123 | student |
|student3@gmail.com | qwerty123 | student |
