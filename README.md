# CrowDate


## How To Use The App

 - This app features 2 ways of authentication. The first way is the
   Google Authentication[^auth]  and the second is the anonymous sign
   in.
 - When logged into the app the user will be presented with a list of
   popular events fetched from the TicketMaster API in ascending order
   by date.

 - The user can view the details of any event by clicking the "Details" button.

 - The event card also has a "add to my following list" button on the bottom right corner.

 - The drawer shows the current users details as well as buttons where the user can either log out or view their followed events.

 - The search screen can be accessed by using the search button at the top right corner of the app bar.


## App Functions and How To Trigger Them

The app was designed to be as minimalistic and intuative as possible.

 - In order to trigger a database write any event can be added to the following list. 
 - Triggering a database read can be accomplished by viewing the following list.
 - A database delete operation is triggered when any event that's being followed is removed from the following list.
 - A notification will be queued when any event is added to the following list using Alarm Manager and Flutter Local Notifications.
  

[^auth]: If the compiled app does not have the same SHA1 fingerprint as we have put in the Firebase Console the Google Authentication won't be functional. A securely signed version of the app is included within the projects zip file.