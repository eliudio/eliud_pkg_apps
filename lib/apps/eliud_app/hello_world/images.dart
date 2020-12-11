import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../eliud_app.dart';

class HelloWorldImages {
  final Tools newAppTools;

  HelloWorldImages(this.newAppTools);

  Future<void> _setupCreateFlutterApp() async {
    await newAppTools.getImgModel(name: "create-flutter-project1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925896_cf49a37918_c_d.jpg");
    await newAppTools.getImgModel(name: "create-flutter-project2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925906_b7f85d0ca8_c_d.jpg");
    await newAppTools.getImgModel(name: "create-flutter-project3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925016_2835f7ca42_c_d.jpg");
    await newAppTools.getImgModel(name: "create-flutter-project4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217192_c77b875cc5_c_d.jpg");
  }

  Future<void> _setupCreateFlutterWebApp() {
    // We can reuse the flutter app images
    return newAppTools.getImgModel(name: "create-flutter-webproject3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49765975277_557eb1549d_c_d.jpg");
  }

  Future<void> _setupCreateGoogleAccount() async {
    await newAppTools.getImgModel(name: "create-google-account1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217782_28c8228058_c_d.jpg");
    await newAppTools.getImgModel(name: "create-google-account2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217357_c6ebecaa6d_c_d.jpg");
    await newAppTools.getImgModel(name: "create-google-account3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217327_6abbe25ac1_c_d.jpg");
    await newAppTools.getImgModel(name: "create-google-account4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217787_401f2023e4_c_d.jpg");
    await newAppTools.getImgModel(name: "create-google-account5", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925601_cbeaf007ec_c_d.jpg");
  }

  Future<void> _setupCreateFirebaseProject() async {
    await newAppTools.getImgModel(name: "create-firebase-project1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386858_38f4c77f83_c_d.jpg");
    await newAppTools.getImgModel(name: "create-firebase-project2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386883_a096f8a024_c_d.jpg");
    await newAppTools.getImgModel(name: "create-firebase-project3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386928_dbac04e3fa_c_d.jpg");
    await newAppTools.getImgModel(name: "create-firebase-project4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386948_177371b518_c_d.jpg");
    await newAppTools.getImgModel(name: "create-firebase-project5", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925716_9d4280f3a0_c_d.jpg");
    await newAppTools.getImgModel(name: "create-firebase-project6", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683387078_d1c24eae7d_c_d.jpg");
  }

  Future<void> _setupCreateFirebaseAndroidApp() async {
    await newAppTools.getImgModel(name: "firebase-home", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49691101251_b2ee29601c_c_d.jpg");
    await newAppTools.getImgModel(name: "create-android-app1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386243_6d37b21a72_c_d.jpg");
    await newAppTools.getImgModel(name: "create-android-app2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386303_6aa6ffd500_c_d.jpg");
    await newAppTools.getImgModel(name: "create-android-app3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925141_5b2ea594b2_c_d.jpg");
    await newAppTools.getImgModel(name: "create-android-app4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49691454342_bbf5abbbbb_c_d.jpg");
    await newAppTools.getImgModel(name: "create-android-app5", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683387198_7ba8ce083f_c_d.jpg");
    await newAppTools.getImgModel(name: "create-android-app6", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925966_90745ed0d7_c_d.jpg");
    await newAppTools.getImgModel(name: "create-android-app7", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925056_ff683b78c8_c_d.jpg");
  }

  Future<void> _setupCreateFirebaseWebApp() async {
    // we can re-use the firebase android app images
    await newAppTools.getImgModel(name: "create-webapp2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49765116063_708e9c1881_c_d.jpg");
  }

  Future<void> _setupCreateFirebaseDatabase() async {
    await newAppTools.getImgModel(name: "create-database1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217382_6b1ce729ca_c_d.jpg");
    await newAppTools.getImgModel(name: "create-database2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925321_3e54136193_c_d.jpg");
    await newAppTools.getImgModel(name: "create-database3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217477_58cacdc850_c_d.jpg");
  }

  Future<void> _setupCreateFirebaseStorage() async {
    await newAppTools.getImgModel(name: "create-storage1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386673_f0c2742a07_c_d.jpg");
    await newAppTools.getImgModel(name: "create-storage2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217557_0d2d18e499_o_d.png");
    await newAppTools.getImgModel(name: "create-storage3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217632_52024e379a_c_d.jpg");
    await newAppTools.getImgModel(name: "create-storage4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386768_263913b61a_c_d.jpg");
  }

  Future<void> _setupFirebaseAuthentication() async {
    await newAppTools.getImgModel(name: "create-authentication1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386733_32254ea93e_c_d.jpg");
    await newAppTools.getImgModel(name: "create-authentication2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217682_e78a60dc50_c_d.jpg");
  }

  Future<void> _deployWebApp() async {
    // We can reuse the flutter app images
    await newAppTools.getImgModel(name: "deploy-webapp1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49768442121_da4a32e6a0_c_d.jpg");
  }

  Future<void> run() async {
    await _setupCreateFlutterApp();
    await _setupCreateFlutterWebApp();
    await _setupCreateGoogleAccount();
    await _setupCreateFirebaseProject();
    await _setupCreateFirebaseAndroidApp();
    await _setupCreateFirebaseWebApp();
    await _setupCreateFirebaseDatabase();
    await _setupCreateFirebaseStorage();
    await _deployWebApp();
    await _setupFirebaseAuthentication();
  }
}
