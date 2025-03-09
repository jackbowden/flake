# Flake

Flake is a Flutter application that allows users to place bets on various participants and choose their preferred payment method. The app provides a user-friendly interface for selecting participants, setting bet amounts, and processing payments through credit/debit cards or Apple Pay.

## Features

- Select participants to place bets on
- Choose bet amounts
- Payment options include credit/debit cards and Apple Pay

## Getting Started

### Prerequisites

To run this project, you need to have Flutter and the Firebase CLI installed on your computer.

### Installing Flutter

1. **Download Flutter**: Visit the [Flutter website](https://flutter.dev/docs/get-started/install) and download the appropriate version for your operating system.
2. **Extract Flutter**: Extract the downloaded file to the desired location on your system.
3. **Update Path**: Add the Flutter `bin` directory to your system's PATH.
   - For macOS and Linux:
     ```sh
     export PATH="$PATH:`pwd`/flutter/bin"
     ```
   - For Windows:
     ```sh
     set PATH=%PATH%;C:\path\to\flutter\bin
     ```
4. **Run Flutter Doctor**: Open a terminal and run the following command to check for any dependencies you may need to install:
   ```sh
   flutter doctor
   ```

### Installing Firebase CLI

1. **Install Node.js**: The Firebase CLI requires Node.js. Download and install it from the [Node.js website](https://nodejs.org/).
2. **Install Firebase CLI**: Open a terminal and run the following command to install the Firebase CLI globally:
   ```sh
   npm install -g firebase-tools
   ```
3. **Login to Firebase**: Run the following command to log in to your Firebase account:
   ```sh
   firebase login
   ```

### Running the App

1. **Clone the Repository**: Clone this repository to your local machine.
   ```sh
   git clone https://github.com/jackbowden/flake.git
   ```
2. **Navigate to the Project Directory**: Change to the project directory.
   ```sh
   cd flake
   ```
3. **Get Dependencies**: Run the following command to get all the necessary dependencies.
   ```sh
   flutter pub get
   ```
4. **Run the App**: Use the following command to run the app on your connected device or emulator.
   ```sh
   flutter run
   ```

## Deployment via Firebase

To deploy the Flutter web app using Firebase Hosting, follow these steps:

1. **Build the Flutter Web App**:
   Build the Flutter web app by running:
   ```sh
   flutter build web
   ```
   This command generates the web build in the `build/web` directory.

2. **Deploy to Firebase Hosting**:

   - **Deploy to the main website**:
     To deploy to the main website, use the following command:
     ```sh
     firebase deploy
     ```

   - **Deploy to a preview channel**:
     To deploy to a preview channel (e.g., staging), use the following command:
     ```sh
     firebase hosting:channel:deploy staging
     ```
     **Best Practices for Naming Preview Channels**:
       - Use descriptive names like `staging`, `dev`, or `feature-branch-name`.
       - Choose names that indicate the purpose or environment of the channel.
       - Keep names consistent across your team.

Now your Flutter web app is deployed on Firebase Hosting!

## Main Components

### main.dart

The `main.dart` file initializes the Flutter application and sets up the main structure of the app. It includes the following key components:

- **MyApp**: The root widget of the application.
- **HomePage**: The main screen where users can interact with the app.

```dart
// filepath: /Users/jackbowden/Documents/repos/flake/lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/betting_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flake',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flake'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return BettingDialog(participants: ['Alice', 'Bob', 'Charlie']);
              },
            );
          },
          child: const Text('Place Bet'),
        ),
      ),
    );
  }
}
```

This file sets up the basic structure of the app and provides a button to open the betting dialog.

For more detailed information, please refer to the source code and comments within the files.
