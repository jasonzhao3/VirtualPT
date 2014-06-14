Development Log
===============
20140426
Done:
1. add horizontal scroll bar for motivation


20140427
Done: 
1. add user tap pain figure
2. add motivation questions

TODO:
1. store motivation into core data
2. Chagne goal to select from a image panel pool?? with a little "Add" sign?
3. store exercise in the core data
4. enable search, add to my own exercise list -- but I think this is the job a therapist will do

1. what 
2. interact with their electronic form -- dont' need double-documentation
3. thumbnail for preview => download to your phone
4. daily task => my exercises
5. Fitstar 
6. check excel -- daily
7. icon for each task




20140429
Done:
1. Customized Table cell with thumbnails and check label
2. read exercise from csv and load into core data


TODO:
1. individual exercise info page
2. individual exercise play page
3. conditional segue
4. merge play with exercise page
5. add exercise from library



20140430
1. individual exercise info

Note: 
1.  Audio file was not located under "Copy Build Resources," which is located under "Build Phases".
2. 

TODO:
1. encapsulate code into category
2. radio for distributed app



20140508
Meeting App Demo:
Done:
1. Exercise Library stored in database
2. support csv file importing -- easy for clinic import
3. thumbnail and title integration
4. two timers for exercise demo

Questions:
1. Can user add their own exercise? Or the physician help user subscribe exercise? I think it should be a web application functionality rather than a user behavoir? Or we enable both?  Maybe in practice mode, user can subscribe to any exercise, while in virtual PT mode, user have to follow the scheduled exercise plan?
2. It's not so user-friendly to have two different exercise screens at the same Menu level. How about have only one exercise screen, and then have a button "View more exercise" or "subscribe more exercise"?
3. Then final menue item should be a utilities => some help menues
4. About next week's task:
   1) finish the user profile storage 
   2) finish the summary view of the user profile
   3) 
   
   
   
   1. personalized progress session  
   2. csv file
   3. help => directions
   4. add a column about the exercise frequency into csv
   5. home -- some pages pop up only the first time, then gone => like application notification
   6. share m exercise on facebook




20140509
Note:
1. create csv using excel may have some tab-separator problem. Parse cannot successfully import 

Done:
1. Connect exercise database with Parse, now can load exercise from Parse everytime
2. Connect facebook login with Parse

20140510
Done:
1. Connect user signup with Parse
2. enable user cache in ios App
3. enable slidding menu only if the user is logged in (call selector defined in another class => target is another controller rather than self)
4. design profile database:
 injury: ";" separated attribute string
 inspiration: ";" separated attribute string


Note:
1. Currently I store the data into core database every time I click "Next" segue  -- not everytime I click the injury position -- whether is this a good way to do this?
2. Parse pointer cannot be a round pointer. e.g. PFUser points to profile, so profile cannot point back to PFUser again. (Maybe not the problem?)
3. check if (currUser[@"profile"] == nil)  doesn't work => it seems that the pointer is already created when the user is created
4. Parse pointer type


TODO:
1. add profile attributes to Parse User => enable "add profile" during signup  and "edit profile"




20140511
Done:
1. finish signup and directly log in -- use delegate. Asychnous sign up and login kinda takes a while
2. fetch profile info


Note:
1. "fetch profile info" has to be inside fetchIfNeededInBackgroundWithBlock's block => because it's asynchrous
2. 


TODO:
1. signup create => pop out window to ask whether continue adding profile
2.


20140512
TODO:
1. View personal exercise first
2. Then view personal profile
3. validate existed user account


20140513
Done:
1. Yesterday, today, tomorrow -> different queries
2.

TODO:
1. Image and video file are now local => should push to server side, load with spinner
2. upload image to server: http://www.raywenderlich.com/44640/integrating-facebook-and-parse-tutorial-part-1


20140514
Done:
1. Create customized UIView with customized navigation bar button, then subclass it 
2. "TodayExercise" => add empty exercise library check to avoid index overflow
3. Integrate rating and today exercise together with timer
4. add profile table => now click profile photo, profile table will pop out


Note:
1. We can add class method to the category => work as helper functions
2. 

TODO:
1. spinner for populating the table
2. 

20140517
Done:
1. add rating database
2. enable the rating different face and questions


20140518
Done:
1. Accomplishment table (New popout-style table)

Note:
1. popout-style tabel: use custom table cell and VC xib file => not entirely clear about the mechanism yet.  But the critical point is that initiateCoder and initilize with nib file, which has to be within the main bundle



20140526 & 20140527
Done:
1. Tab-bar based Motivation page
2. Database for Motivation
3. Tab-bar logo from thenounproject
4. update new hep2go csv file
5. half-way done with reminder
6. change the database and web UI for new csv file

TODO:
1. finish the integration of reminder and calendar
2. add 20s break between each exercise, update the timer
3. keep track of timer, and store them into database
4. batch web input
5. pop out window every one week (check date condition)

Note:
1. Parse fetchifneeded should be a wrapper block for all operations upon relation objects
2. reminder actionsheet add action is very complicated -- still haven't done yet
