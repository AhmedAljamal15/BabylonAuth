# Flutter/Dart Development Internship Assessment

This project is my submission for the Babylon Radio Flutter/Dart Internship coding assessment.  
The app is a simple Flutter application integrated with Firebase Authentication that supports user registration, login, and logout.



##  Features
- **Login Page** with  Name, Email, and Password fields.  
- **Form validation** for all input fields.  
- **Firebase Authentication** for user registration and login.  
- **Home Page** that greets the logged-in user by name.  
- **Logout button** to sign out and return to the login page.  
- **userChanges()** used to automatically switch between Login and Home depending on authentication state.  
- **State Mangement(Cubit)** for All Application



## Setup Instructions

2. Install dependencies:
 
   flutter pub get
  

3. Add Firebase configuration:
   - Download **`google-services.json`** (for Android) and place it in `androi app/`.  
   -  Add **`GoogleService-Info.plist`** in `ios/Runner/`.  
   - Enable **Email/Password Authentication** in Firebase Console.  

4. Run the app:
   
   flutter run
   



##  Approach
I built a simple Flutter app that uses **Firebase Authentication** to handle user registration, login, and logout.  
- The **Login Page** contains fields for Full Name, Email, and Password with validation.  
- When a new user registers, their full name is stored in Firebase Authentication (`displayName`).  
- After successful login, the user is redirected to a **Home Page** that displays a personalized greeting with their name and provides a logout button.  
- I used `userChanges()` to automatically switch between LoginPage and HomePage depending on authentication state.  



##  Challenges
- Setting up Firebase correctly.  
- Handling null safety in Dart (avoiding crashes when `currentUser` becomes null after logout).  
- Ensuring form validation works properly for all fields.  
- State Mangement (Cubit) 



##  Future Improvements
- Add password reset functionality.  
- Store user profiles in Firestore (with additional fields like photo, phone number, Country).  
- Improve UI/UX design using more advanced Flutter widgets.  (animations) 




##  Submission
This project was developed as part of the Babylon Radio Internship coding assessment.  
