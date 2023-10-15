# Quizy - A Flutter Quiz App with Firebase Integration


![IMG_20231015_161107](https://github.com/3MR7OSSAM/Quizy/assets/83048066/1deff3c3-0a72-45b9-8cb9-7eee965cdc68)


Quizy is a versatile quiz application developed using Flutter and Firebase. It offers a seamless experience for both students and teachers. Students can create quizzes, track the number of students who have completed a quiz, and view their scores along with the date of completion. Teachers, on the other hand, can log in, sign up, manage their profiles, oversee the student quizzes, and create and manage quizzes.

## Features

### Student Interface

1. **Login and Signup**: Students can log in using their credentials or sign up for a new account.

2. **Quiz Selection**: After logging in, students can choose from a list of available quizzes by entering the quiz ID.

3. **Quiz Completion Tracking**: Students can see the number of students who have finished a particular quiz.

4. **Quiz Scores**: Once a student completes a quiz, they can view their scores.

5. **Quiz History**: Students can access a history of quizzes they have completed, including the date of completion.

### Teacher Interface

1. **Login and Signup**: Teachers can log in using their credentials or sign up for a new account.

2. **Profile Management**: Teachers can manage their profiles, update their information, and change their passwords.

3. **Quiz Management**: Teachers can create quizzes and share unique codes with students for quiz access.

4. **Student Progress Tracking**: Teachers can track student progress on their quizzes, including student names, scores, and completion dates.

### Firebase Integration

1. **Authentication**: Firebase is used for user authentication, ensuring secure access to the app.

2. **Real-time Database**: Firebase Realtime Database is employed to store quiz data, student results, and other app-related information.

## Installation

1. **Clone the Repository**: `git clone https://github.com/your-username/quizy.git`

2. **Navigate to the Project Directory**: `cd quizy`

3. **Install Dependencies**: `flutter pub get`

4. **Configure Firebase**: Set up your Firebase project and add the configuration files (google-services.json for Android and GoogleService-Info.plist for iOS) to the project. Make sure Firebase Authentication and Realtime Database are enabled.

5. **Run the App**: `flutter run`

## Usage

1. **Student Interface**:
   - Log in with your student account or create a new one.
   - Choose a quiz by entering the quiz ID.
   - Complete the quiz and check your scores.
   - View your quiz completion history with the dates.

2. **Teacher Interface**:
   - Log in with your teacher account or sign up for one.
   - Manage your profile details, including password changes.
   - Create quizzes and share access codes with students.
   - Track student progress on quizzes, including names, scores, and completion dates.

## Firebase Configuration

To set up Firebase for this project:

1. Create a Firebase project on the [Firebase Console](https://console.firebase.google.com/).

2. Add the configuration files for Android and iOS to the project.

3. Enable Firebase Authentication and Realtime Database in your project.

4. Update the Firebase configurations in the Flutter app, typically found in `lib/main.dart`.

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests to help improve the app.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Authors

- Amr Hossam
- Amr70.vip@gmail.com

## Contact

For any inquiries or support, you can contact us at [amr70.vipl@gmail.com](mailto:your-email@example.com).

**Happy quizzing with Quizy!**
