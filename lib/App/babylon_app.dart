import 'package:babylon_login/Auth/Login%20cubit/login_auth_cubit.dart';
import 'package:babylon_login/Auth/SignUp%20cubit/sign_up_cubit.dart';
import 'package:babylon_login/Auth/Sign_Out_cubit/sign_out_cubit.dart';
import 'package:babylon_login/Views/SignUp/UI/sign_up_view.dart';
import 'package:babylon_login/Views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Babylon extends StatelessWidget {
  const Babylon({super.key});
   
  @override
  Widget build(BuildContext context) {
   final FirebaseAuth user = FirebaseAuth.instance;
    return MultiBlocProvider(
     providers: [
      BlocProvider(create: (_) => AuthCubit()),
      BlocProvider(create: (_) => SignUpCubit()),
      BlocProvider(create: (_) => SignOutCubit()),

     ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Babylon Auth Login',
        home: user.currentUser == null ? const SignUpView() :  HomeView(),
      ),
    );
  }
}
