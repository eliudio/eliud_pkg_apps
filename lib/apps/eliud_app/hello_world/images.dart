import 'package:eliud_pkg_apps/apps/tools/tools.dart';

import '../eliud_app.dart';

class HelloWorldImages {
  final Tools newAppTools;

  HelloWorldImages(this.newAppTools);

  Future<void> _setupCreateFlutterApp() {
    return newAppTools.getImgModel(name: "create-flutter-project1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925896_c7069ee2bb_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-flutter-project2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925906_981dbf7ee8_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-flutter-project3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925016_77e0dcf033_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-flutter-project4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217192_6d37b21a72_o_d.png")
    )));
  }

  Future<void> _setupCreateFlutterWebApp() {
    // We can reuse the flutter app images
    return newAppTools.getImgModel(name: "create-flutter-webproject3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49765975277_e0544a463f_o_d.png");
  }

  Future<void> _setupCreateGoogleAccount() {
    return newAppTools.getImgModel(name: "create-google-account1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217782_5bd60da759_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-google-account2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217357_209afaa5b9_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-google-account3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217327_5b46b0a5cd_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-google-account4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217787_9ae3cc01e2_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-google-account5", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925601_e01a090271_o_d.png")
    ))));
  }

  Future<void> _setupCreateFirebaseProject() {
    return newAppTools.getImgModel(name: "create-firebase-project1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386858_609bacc98e_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-firebase-project2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386883_364154038c_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-firebase-project3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386928_008fce3246_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-firebase-project4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386948_9eb01d00f7_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-firebase-project5", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925716_fbab51203a_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-firebase-project6", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683387078_cf90460876_o_d.png")
    )))));
  }

  Future<void> _setupCreateFirebaseAndroidApp() {
    return newAppTools.getImgModel(name: "firebase-home", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683387128_cf6389957d_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-android-app1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386243_3fd580af88_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-android-app2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386303_eb957a6226_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-android-app3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925141_16fce7796a_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-android-app4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49691454342_3820a3f9e6_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-android-app5", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683387198_ae88dab8e1_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-android-app6", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925966_dd4fc96d38_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-android-app7", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925056_1dc94186dd_o_d.png")
    )))))));
  }

  Future<void> _setupCreateFirebaseWebApp() {
    // we can re-use the firebase android app images
    return newAppTools.getImgModel(name: "create-webapp2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49887437322_240620005e_o_d.jpg");
  }

  Future<void> _setupCreateFirebaseDatabase() {
    return newAppTools.getImgModel(name: "create-database1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217382_70942fb8b5_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-database2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683925321_c7c82a4e66_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-database3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217477_b8e595da3a_o_d.png")
    ));
  }

  Future<void> _setupCreateFirebaseStorage() {
    return newAppTools.getImgModel(name: "create-storage1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386673_c306cfdc18_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-storage2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217557_0d2d18e499_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-storage3", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217632_568be79e9f_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-storage4", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386768_f7e9da2233_o_d.png")
    )));
  }

  Future<void> _setupFirebaseAuthentication() {
    return newAppTools.getImgModel(name: "create-authentication1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49683386733_b35c0cf1f7_o_d.png").
    then((_) => newAppTools.getImgModel(name: "create-authentication2", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49684217682_dc62c5306b_o_d.png")
    );
  }

  Future<void> _deployWebApp() {
    // We can reuse the flutter app images
    return newAppTools.getImgModel(name: "deploy-webapp1", appId: EliudApp.ELIUD_APP_ID, url: "https://live.staticflickr.com/65535/49768442121_b65e065137_o_d.png");
  }

  Future<void> run() {
    return _setupCreateFlutterApp().
    then((_) => _setupCreateFlutterWebApp()).
    then((_) => _setupCreateGoogleAccount()).
    then((_) => _setupCreateFirebaseProject()).
    then((_) =>_setupCreateFirebaseAndroidApp()).
    then((_) =>_setupCreateFirebaseWebApp()).
    then((_) =>_setupCreateFirebaseDatabase()).
    then((_) => _setupCreateFirebaseStorage()).
    then((_) => _deployWebApp()).
    then((_) =>_setupFirebaseAuthentication());
  }
}
