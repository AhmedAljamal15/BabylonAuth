import 'package:babylon_login/Auth/Sign_Out_cubit/sign_out_cubit.dart';
import 'package:babylon_login/Core/utils/custom_button.dart';
import 'package:babylon_login/Core/utils/show_msg.dart';
import 'package:babylon_login/Views/Login/UI/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        }

        if (state is SignOutFailure) {
          showMsg(context, state.errormessage);
        }
      },
      builder: (context, state) {
        final SignOutCubit cubit = context.read<SignOutCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Babylon Auth Login',
              style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            centerTitle: true,
          ),
          body: state is SignOutLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: user == null
                            ? const Text(
                                "No user logged in",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                "Hey, ${user?.displayName ?? ''}! You’re successfully logged in as ${user?.email ?? ''} \u{1FAE1}",
                                style: const TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(height: 50),
                      CustomButton(
                        text: 'Logout',
                        onPressed: () {
                          cubit.signOut();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginView(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
