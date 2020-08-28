import 'package:eliud_model/model/abstract_repository_singleton.dart';
import 'package:eliud_model/model/background_model.dart';
import 'package:eliud_pkg_apps/apps/eliud_app/eliud_app.dart';
import 'package:eliud_model/model/page_model.dart';
import 'package:eliud_model/model/app_bar_model.dart';
import 'package:eliud_model/model/drawer_model.dart';
import 'package:eliud_model/model/home_menu_model.dart';

import 'package:eliud_pkg_apps/apps/tools/tools.dart';

class HelloWorldPages {
  static String _gotoHomeFirebase = "Goto your projects home page on firebase. You can find this from https://console.firebase.google.com and selecting your project.";

  final AppBarModel appBar;
  final HomeMenuModel homeMenu;
  final BackgroundModel pageBackground;
  final DrawerModel drawer;
  final DrawerModel endDrawer;

  final Tools newAppTools;

  HelloWorldPages(this.newAppTools, this.appBar, this.homeMenu, this.pageBackground, this.drawer, this.endDrawer);

  static String _createFlutterCode = """
  import 'package:eliud_model/core/eliud.dart';
  import 'package:eliud_model/core/tools/simple_bloc_delegate.dart';
  import 'package:eliud_model/shared/abstract_repository_singleton.dart';
  import 'package:eliud_model/shared/eliud_app.dart';
  import 'package:eliud_model/shared/repository_singleton.dart';
  import 'package:flutter/material.dart';
  import 'package:bloc/bloc.dart';
  import 'package:eliud_model/platform/platform.dart';
  import 'package:eliud_model/platform/mobile_platform.dart';
  
  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    BlocSupervisor.delegate = SimpleBlocDelegate();
  
    AbstractRepositorySingleton.singleton = RepositorySingleton();
    AbstractPlatform.platform = MobilePlatform();
  
    await Future<void>.value(SetupNewApp().run("eliud_app_1", "https://live.staticflickr.com/65535/49606007538_cf3ca070b9_o.png", "logo.gif"))
        .then((value) {
      print("Success");
      Eliud.runEliudApp("ELIUD_APP_1");
    }).catchError((onError) => print("Error \${onError}"));
  }
  """;

  static String _pubSpecYamlCode = """
name: charlotteflutterapp
description: A new Flutter application

version: 1.0.0+1

environment:
  sdk: ">=2.1.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^0.1.2

  eliud_model:
    path: ../../../eliud/eliud_model


flutter:

  uses-material-design: true
  """;

  // ************************ Tutorial: Flutter Project *****************
  static String CREATE_FLUTTER_PROJECT = "create-flutter-project";

  Future<PageModel> _setupCreateFlutterProject() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, CREATE_FLUTTER_PROJECT,
        "Create Flutter Project", "Create Flutter Project", "Follow the below steps to create your first flutter project.",
        [ "create-flutter-project1", "create-flutter-project2", "create-flutter-project3", "create-flutter-project4", null, null, null ],
        [ null, null, null, null, _createFlutterCode, _pubSpecYamlCode, null, ],
        [
          "1. Start Android Studio. From Android Studio, select File > New > New Flutter Project",
          "2. Select Flutter Application",
          "3. Specify Project name, Flutter SDK path, Project location and Description. Then click Next",
          "4. Select Company domain. Then click Finish.",
          "5. Create a new dart file with this content",
          "6. Update your pubspec.yaml file",
          "7. Update the file andoid/app/build.gradle and specify minSdkVersion 21"
        ]
    )).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, CREATE_FLUTTER_PROJECT, "Create Flutter Project", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Tutorial: Google Account *****************
  static String CREATE_GOOGLE_ACCOUNT = "create-google-account";

  Future<PageModel> _setupCreateGoogleAccount() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, CREATE_GOOGLE_ACCOUNT,
        "Create Google Account", "Create Google Account", "Follow the below steps to create a google account.",
        [ "create-google-account1", "create-google-account3", "create-google-account2", "create-google-account4", "create-google-account5", ],
        [ null, null, null, null, null, ],
        [
          "1. Goto https://accounts.google.com/sigNup, specify First name, Last name, Username and password. Then press Next.",
          "2. Specify phone number, recovery email, date of birth, gender. Then press Next.",
          "3. Specify country and phone number and verify your code.",
          "4. You should have received a verification code you've specified in the previous step. Enter the verification code and press Verify.",
          "5. Agree to the google terms and processing of information and press Create Account.",
    ]
    )).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, CREATE_GOOGLE_ACCOUNT, "Create Google Account", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Tutorial: Firebase project *****************
  static String CREATE_FIREBASE_PROJECT = "create-firebase-project";

  Future<PageModel> _setupCreateFirebaseProject() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, CREATE_FIREBASE_PROJECT,
        "Create Firebase Project",
        "Firebase Project", "Follow the below steps to create a Firebase Project.",
    [ "create-firebase-project1", "create-firebase-project2", "create-firebase-project3", "create-firebase-project4", "create-firebase-project5", "create-firebase-project6", ],
    [ null, null, null, null, null, null, ],
    [
      "1. Goto https://console.firebase.google.com/ and press Create a project",
      "2. Specify a project name, accept the firebase terms and click Continue.",
      "3. Enable Google Analytics for this project and click Continue.",
      "4. Specify Analytics location, specify the data sharing settings and Google Analytics terms and press Create Project",
      "5. Wait for the project to be created",
      "6. Ones the project is created, press Continue",
    ])).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, CREATE_FIREBASE_PROJECT, "Create Firebase Project", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Tutorial: Android App *****************
  static String CREATE_ANDROID_APP = "create-android-app";

  Future<PageModel> _setupCreateFirebaseAndroidApp() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, CREATE_ANDROID_APP, "Create Android App",
        "Create Firebase Android App", "Follow the below steps to create an Android App.",
    [ "create-android-app1", "firebase-home", "create-android-app2", "create-android-app4", "create-android-app3", "create-android-app5", "create-android-app6", "create-android-app7", ],
    [ null, null, null, null, null, null, null, null, ],
    [
      "1. First step into creating an Android app on Firebase is creating an SHA1 Certifcate footprint. Open a command line and run the command and run: 'keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\\.android\\debug.keystore'. Specify default parameters by pressing enter. Then copy the entry next to SHA1. Find more information at https://developers.google.com/android/guides/client-auth",
      "2. " + _gotoHomeFirebase + ". Click 'Add app' and select platform 'Android'",
      "3. Specify the Android package name, optionally an App nickname and paste the SHA1 Certifcate footprint you've retrieved in the first step earlier. Then click Register App",
      "4. Now download google-services.json to your local disk and press Next",
      "5. Now goto Android Studio, open your project and copy the downloaded google-services.json file into your project as indicated.",
      "6. Now follow the guidelines specified, i.e. make sure you've updated the 2 build.gradle files correctly as indicated. Then press Next",
      "7. Allow this screen to indicate your app is working correctly. Run your app form Android Studio.",
      "8. The screen should indicate your app is working correctly and connected to firebase as required. Success! If not, go through the different steps of the tutorial ones again and verify if you've followed each step correctly.",
    ])).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, CREATE_ANDROID_APP, "Create Android App", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Tutorial: Database *****************
  static String CREATE_DATABASE = "create-database";

  Future<PageModel> _setupCreateFirebaseDatabase() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, CREATE_DATABASE, "Create Database",
        "Create Database", "Follow the below steps to create the firebase database.",
    [ "firebase-home", "create-database1", "create-database2", "create-database3"],
    [null, null, null, null], [
      "1." + _gotoHomeFirebase,
      "2. Select Database from the left hand side menu. Then press Create database",
      "3. When prompted for the database specifications, select 'Start in test mode'. At a later stage we will update these settings / rules to make your database safe. But for now, we're happy with test mode. Click Next",
      "4. Select a Cloud Firestire location and press Done"
    ])).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, CREATE_DATABASE, "Create Database", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Tutorial: Storage *****************
  static String CREATE_STORAGE = "create-storage";

  Future<PageModel> _setupCreateFirebaseStorage() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, CREATE_STORAGE, "Create Storage",
        "Create Storage", "Follow the below steps to create the storage.",
    [ "firebase-home", "create-storage1", "create-storage2", "create-storage3", "create-storage4" ],
    [ null, null, null, null, null],
    [
      "1. " + _gotoHomeFirebase,
      "2. Select Storage from the left hand side menu. Then press Get started",
      "3. Leave default values when setting up cloud storage. Press Next",
      "4. Select a cloud storage location and press Done",
      "5. Select the Rules tab and specify the rules as indicated, i.e. allow read and write for all."
    ])).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, CREATE_STORAGE, "Create Storage", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Tutorial: Authentication *****************
  static String CREATE_AUTHENTICATION = "create-authentication";

  Future<PageModel> _setupFirebaseAuthentication() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, CREATE_AUTHENTICATION, "Setup Authentication",
        "Setup Authentication", "Follow the below steps to setup authentication.",
    [ "firebase-home", "create-authentication1", "create-authentication2"],
    [ null, null, null],
    [
      "1. " + _gotoHomeFirebase,
      "2. Select Authentication from the left hand side menu. Then press Set up sign-in method",
      "3. Find Google from the Sign-in method, enabld and specify the project-level settings. Press Save"
    ])).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, CREATE_AUTHENTICATION, "Setup Authentication", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Tutorial: Flutter Project *****************
  static String _createFlutterWebCode = """
import 'package:eliud_model/core/eliud.dart';
import 'package:eliud_model/platform/web.dart';
import 'package:eliud_model/shared/abstract_repository_singleton.dart';
import 'package:eliud_model/shared/js_repository_singleton.dart';
import 'package:eliud_model/platform/platform.dart';

void main() {
  AbstractRepositorySingleton.singleton = JsRepositorySingleton();
  AbstractPlatform.platform = Web();
  Eliud.runEliudAppWithFlareFlutterIntro("eliud_app_1", "assets/flare/Filip.flr", "idle");
}
  """;

  static String _pubSpecYamlWebCode = """
name: eliud_web_app
description: A new Flutter application.

publish_to: 'none' # Remove this line if you wish to publish to pub.dev

version: 1.0.0+1

environment:
  sdk: ">=2.7.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  eliud_model:
    path: ../eliud_model

  cupertino_icons: ^0.1.3

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
  """;

  static String _index = """
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="A Charlotte Web application.">

  <!-- iOS meta tags & icons -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Charlotte Web App">
  <meta name="google-signin-client_id" content="YOUR_GOOGLE_SIGN_IN_CLIENT_ID">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Favicon -->
  <link rel="shortcut icon" type="image/png" href="favicon.png"/>

  <title>Charlotte Web App</title>
  <link rel="manifest" href="manifest.json">
</head>
<body>
<script src="https://www.gstatic.com/firebasejs/7.14.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.14.0/firebase-firestore.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.14.0/firebase-auth.js"></script>
<script>
    // Your web app's Firebase configuration
    var firebaseConfig = {
      apiKey: "YOUR_API_KEY",
      authDomain: "YOUR_AUTH_DOMAIN",
      databaseURL: "YOUR_DATABASE_URL",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_STORAGE_BUCKET",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      appId: "YOUR_APP_ID",
      measurementId: "YOUR_MEASUREMENT_ID"
    };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
  </script>
<script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', function () {
        navigator.serviceWorker.register('flutter_service_worker.js');
      });
    }
  </script>
<script src="main.dart.js" type="application/javascript"></script>
</body>
</html>
  """;

  static String signin_instructions = """
1. Goto https://developers.google.com/identity/sign-in/web/sign-in#before_you_begin
2. Click 'Configure a project' and follow instructions.
This will create a google api console project and client ID. We will need this in the next step
  """;

  static String CREATE_FLUTTER_WEBPROJECT = "create-flutter-webproject";

  Future<PageModel> _setupCreateFlutterWebProject() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, CREATE_FLUTTER_WEBPROJECT,
        "Create Flutter Web Project", "Create Flutter Web Project", "Follow the below steps to create your first flutter project.",
        // We can reuse the flutter-project images
        [ "create-flutter-project1", "create-flutter-project2", "create-flutter-webproject3", "create-flutter-project4", null, null, null, null, null, null],
        [ null, null, null, null, _createFlutterWebCode, _pubSpecYamlWebCode, signin_instructions, _index, null, null ],
        [
          "1. Start Android Studio. From Android Studio, select File > New > New Flutter Project",
          "2. Select Flutter Application",
          "3. Specify Project name, Flutter SDK path, Project location and Description. Then click Next",
          "4. Select Company domain. Then click Finish.",
          "5. Create a main dart file with this content",
          "6. Update your pubspec.yaml file",
          "7. Setup google signin web",
          "8. Specify your google-signin-client_id which you've created in step. Go to your project in the Firebase Console. Next, click the gear icon beside the Project Overview in the sidebar to the left at the top and click on project settings. Under the general tab, which is what should open up by default, scroll down a bit til you get to the your apps section. Inside that area, you will find the Firebase SDK Snippet heading. Under that, you'll have three checkboxes. Go for the Config checkbox, and you will see a JS object declaration. Copy this into your html",
          "9. Update index.html as described in https://medium.com/flutter-community/caching-in-flutter-for-web-42b3ae0e348f and change the link to main.dart.js to main.dart.js?version=1. This allows to force clients to download a new webapp when you would have upgraded your codebase",
          "10. Update index.html, change description, meta data, color, etc",
        ]
    )).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, CREATE_FLUTTER_WEBPROJECT, "Create Flutter Web Project", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Tutorial: Android App *****************
  static String CREATE_WEB_APP = "create-web-app";

  // todo: this is wrong, this is android explain, not web explain
  Future<PageModel> _setupCreateFirebaseWebApp() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, CREATE_WEB_APP, "Create Web App",
        "Create Firebase WebApp", "Follow the below steps to create a Web App.",
        // Here we can reuse the android images
        [ "firebase-home", "create-webapp2", null ],
        [ null, null, null ],
        [
          "1. " + _gotoHomeFirebase + ". Click 'Add app' and select platform 'Web'",
          "2. Provide an App nickname and select Firebase Hosting. Select your project from the drop down box. Then click on Register app. Then click Next when asked to add the Firebase SDK. click next when asked to Install Firebase CLI. Click on 'Continue to the console' the the deploy to Firebase hosting.",
          "3. Follow these instructions to allow refresh of clients when updates are made to the app: https://stackoverflow.com/questions/46667316/firebase-hosting-force-browser-to-reset-cache-on-new-deploys"
        ])).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, CREATE_WEB_APP, "Create Web App", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Tutorial: Deploy web app *****************
  static String oAuthInstructions = """
  1. Goto https://console.developers.google.com/apis/credentials
  2. Select your project from the combo box next to 'Google APIs'
  3. Find the OAuth Client from OAuth 2.0 client IDs and press edit
  4. Add the URL http://localhost:7357
  5. Also add the URL of your domain, e.g. https://eliud.io
  """;

  static String hosting = """
As described at https://medium.com/flutter/must-try-use-firebase-to-host-your-flutter-app-on-the-web-852ee533a469
Basically:
- cd /src/eliud/flutter_app
- firebase logout
- firebase login
- firebase init
- select Hosting (space and enter)
- use existing project
- enter
- what do you want to use as your public directory? build/web
- configure as single-page app? y
- overwrite? n
- optionally: flutter pub get
- flutter build web
- firebase deploy
  """;

  static String domainName = """
- goto your firebase project 
- select hosting
- add custom domain
- follow instructions
  """;

  static String DEPLOY_WEB_APP = "deploy-web-app";

  Future<PageModel> _setupDeployWebApp() {
    return AbstractRepositorySingleton.singleton.tutorialRepository().add(newAppTools.constructTutorialModel(EliudApp.ELIUD_APP_ID, DEPLOY_WEB_APP, "Deploy Web App",
        "Deploy the WebApp", "Follow the below steps to deploy your Web App.",
        // images
        [ null, "deploy-webapp1", null, null, null ],
        // code
        [ oAuthInstructions, null, null, hosting, domainName ],
        // text
        [
          "1. Setup OAuth Client",
          "2. To run your web app from Android Studio, select Chrome as the Flutter Device Selection and click Run",
          "3. To run your web app from command line, goto the directory of your build cd C:\src\eliud\flutter_app\build\web and run flutter run -d web-server --web-hostname localhost --web-port 7357, then open http://localhost:7357/",
          "4. To deploy your web app to your hosting, follow these steps",
          "5. To make sure your domain opens your web app, follow these steps"

        ])).then((value) {
      return newAppTools.createTutorial(EliudApp.ELIUD_APP_ID, DEPLOY_WEB_APP, "Deploy Web App", drawer, appBar, homeMenu, pageBackground);
    });
  }

  // ************************ Setup *****************

  Future<void> run() {
    return _setupCreateFlutterProject()
        .then((_) => _setupCreateFlutterWebProject())
        .then((_) => _setupCreateGoogleAccount())
        .then((_) => _setupCreateFirebaseProject())
        .then((_) => _setupCreateFirebaseAndroidApp())
        .then((_) => _setupCreateFirebaseDatabase())
        .then((_) => _setupCreateFirebaseStorage())
        .then((_) => _setupCreateFirebaseWebApp())
        .then((_) => _setupFirebaseAuthentication()
        .then((_) => _setupDeployWebApp()));
  }
}
