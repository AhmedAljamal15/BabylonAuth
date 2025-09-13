import 'package:babylon_login/Auth/Login%20cubit/login_auth_cubit.dart';
import 'package:babylon_login/Core/utils/custom_button.dart';
import 'package:babylon_login/Core/utils/custom_text_button.dart';
import 'package:babylon_login/Core/utils/show_msg.dart';
import 'package:babylon_login/Core/utils/custom_text_form.dart';
import 'package:babylon_login/Views/SignUp/UI/sign_up_view.dart';
import 'package:babylon_login/Views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginAuthSuccess) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeView()) , (route) => false,);
        } else if (state is LoginAuthFailure) {
          showMsg(context, state.errormessage);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = context.read<AuthCubit>();
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: state is LoginAuthLoading
                ? Center(child: CircularProgressIndicator())
                : Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Login to get started',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 50),
                        Text('Email Address', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10),

                        // Email Field
                        CustomTextForm(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3 ||
                                !value.contains('@') ||
                                !value.contains('.')) {
                              return 'This field Email is required';
                            }
                            return null;
                          },
                          controller: emailController,
                          hintText: 'Enter your email address',
                          keyboardType: TextInputType.emailAddress,
                          prefix: Icon(Icons.email_rounded),
                        ),
                        SizedBox(height: 10),
                        CustomTextButton(
                          text: 'Forget Password?',
                          alignment: Alignment.centerRight,
                        ),
                        Text('Password', style: TextStyle(fontSize: 16)),

                        SizedBox(height: 10),
                        // Password Field
                        CustomTextForm(
                          obscureText: isObscure,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return 'This field Password is required';
                            }
                            return null;
                          },
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          hintText: 'Enter your password',
                          keyboardType: TextInputType.visiblePassword,
                          prefix: Icon(Icons.lock_rounded),
                        ),
                        SizedBox(height: 60),
                        CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.loginAuth(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              formKey.currentState!.save();

                              emailController.clear();
                              passwordController.clear();
                            }
                          },
                          text: 'Login',
                        ),
                        SizedBox(height: 15),
                        CustomTextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUpView();
                                },
                              ),
                            );
                          },
                          text: 'Create Account',
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
