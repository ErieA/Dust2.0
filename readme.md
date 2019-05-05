# Dust2.0


Dust2.0: 
- Our application automates the checking of distribution requirements for students within Cornell’s College of Arts & Sciences.


### Contributing Github Repos:

- https://github.com/ErieA/Dust2.0.git
- https://github.com/duboisbarron/appdev-project

### Screenshots:
![screenshot 1](https://imgur.com/a/Rio9M9E)
![screenshot 2](https://imgur.com/a/1PxfoaP)
![screenshot 3](https://imgur.com/a/aaUXUkh)

### Description:
- Our application allows users to input a class and find out which Arts Distribution requirements that class will fill. Users select a class by year ("19"), semester("FA"), subject (“MATH”), and course number (“1920”). Our backend returns a list of the distribution requirements that that class will fill within Arts & Sciences (for example, “MQR-AS” classes fill the “Math & Quantitative Reasoning” requirements).
- The API also returns a list of subjects offered in a given semester and a list of classes offered within a specific subject in a given semester. These two API endpoints can be used to make dynamic drop down selection boxes by the frontend.
- We were inspired to develop this system when we found out that both Arts & Sciences and CALS have an online DUST report system. DUST reports show a student’s progress through their college requirements. Interestingly, though CALS’ system generates a report electronically based on a students’ course history, Arts & Sciences generates each report by hand. This often leads to mistakes in the 4,000 DUST reports that Arts & Sciences maintains every academic year. These mistakes are costly for the University and lead to confusion and frustration for Cornell students.

### AppDev Requirements:
- Our backend consists of a wrapper around the Cornell Course Roster API which filters out irrelevant data regarding the courses that the end-user supplies. Since we were unable to obtain access to Cornell’s LDAP (net ID login) System, we found the use of a database to maintain state unnecessary. 
- The backend was deployed to Heroku instead of Google Cloud since we have much more experience with Heroku. 
- The IOS portion contains a table view in the main screen that updates whenever a class is added, as well as custom table views that are used as drop down menus to select subjects offered in a semester and year (this information is obtained by sending a request to the API) and to select the number of the class (this information is also obtained by sending a request to the API. Checking requirements brings the user to another screen that displays their classes and the requirements that they fulfill, all displayed in a table view.
### Extra information:
- We deployed backend on Heroku instead of Google Cloud. Because Heroku Dynos on the “Free Tier” sleep after 30min of inactivity, you might have to repeatedly send requests in order to “wake” them. 

