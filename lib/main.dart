import 'package:babylon_login/App/babylon_app.dart';
import 'package:babylon_login/Core/Functions/my_observer.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  Bloc.observer = MyObserver();
  runApp(const Babylon());
}


