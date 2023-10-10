# Roadside Assistance App

Roadside Assistance App is a mobile application designed to provide users with quick and easy access to roadside assistance services. The app allows users to book various services, such as towing, tire repair, and fuel delivery, and includes features like Google Maps integration and Firebase-based authentication, storage, and notifications.

## Features

- **Service Booking:** Users can book roadside assistance services, specifying their location and service requirements.
- **Google Maps Integration:** The app integrates with Google Maps to provide location-based services and directions.
- **Firebase Integration:** Firebase is used for user authentication, cloud storage, and push notifications.
- **User Profile:** Users can create and manage their profiles, including contact information and vehicle details.
- **Service History:** Users can view their booking history and details of past services.
- **Notifications:** Users receive notifications for service updates and important announcements.
- **Emergency Contacts:** Contact details for emergency services are readily accessible within the app.

## Technologies Used

- Android Studio
- Kotlin
- Firebase Authentication
- Firebase Cloud Storage
- Firebase Cloud Messaging (FCM)
- Google Maps API
- RecyclerView and CardView for UI components
- Retrofit for API communication
- Firebase Realtime Database for service booking tracking

## Getting Started

1. Clone the repository to your local machine:

   git clone https://github.com/Rohaid-Bhatti/Road-side-assistance.git

2. Open the project in Android Studio.

3. Set up Firebase in your project by creating a Firebase project on the [Firebase Console](https://console.firebase.google.com/).

4. Configure the necessary Firebase services, such as Authentication, Cloud Storage, and Cloud Messaging (FCM), and add your Firebase configuration files to the project.

5. Build and run the app on an Android emulator or device.

## Usage

- Users can sign in or create an account using Firebase authentication.
- After signing in, users can book a service by specifying their location and service requirements.
- The app provides service updates and notifications using Firebase Cloud Messaging (FCM).
- Users can view their service history and contact emergency services via the app.

## Contributing

If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix: `git checkout -b feature-name`.
3. Commit your changes: `git commit -m 'Add new feature'`.
4. Push to your forked repository: `git push origin feature-name`.
5. Create a pull request on the original repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to Firebase for providing a powerful backend infrastructure.
- Thanks to the Google Maps API for enabling location-based services.