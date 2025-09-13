import 'package:babylon_login/Auth/SignUp%20cubit/sign_up_cubit.dart';
import 'package:babylon_login/Core/utils/custom_button.dart';
import 'package:babylon_login/Core/utils/custom_text_button.dart';
import 'package:babylon_login/Core/utils/show_msg.dart';
import 'package:babylon_login/Views/Login/UI/login_view.dart';
import 'package:babylon_login/Core/utils/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpAuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        }

        if (state is SignUpAuthFailure) {
          showMsg(context, state.errormessage);
        }
      },
      builder: (context, state) {
        SignUpCubit cubit = context.read<SignUpCubit>();
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: state is SignUpAuthLoading
                ? Center(child: CircularProgressIndicator())
                : Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Sign up to get started',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 50),
                        Text(' Name', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10),

                        // Name Field
                        CustomTextForm(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field Name is required';
                            }
                            return null;
                          },
                          controller: nameController,
                          hintText: 'Name',
                          keyboardType: TextInputType.name,
                          prefix: Icon(Icons.person),
                        ),

                        SizedBox(height: 20),
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
                        SizedBox(height: 20),

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
                            
                              cubit.signUpAuth(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                              );

                              formKey.currentState!.save();


                              emailController.clear();
                              passwordController.clear();
                              nameController.clear();
                            }
                          },
                          text: 'Create Account',
                        ),
                        SizedBox(height: 15),
                        CustomTextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginView();
                                },
                              ),
                            );
                          },
                          text: 'Already have an account? Login',
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
