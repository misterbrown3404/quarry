import 'package:Quarry/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'app.dart';


Future<void> main() async {
  // Todo: Add Widget Binding

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Todo: Init local storage


  // Todo: Init payment methods

  // Todo: Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Todo: Init Firebase
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  //Todo: Initialize Authentication

  // load all the material design / themes / localizations / bindings
  runApp(const App());
}