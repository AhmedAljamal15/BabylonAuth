
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth user = FirebaseAuth.instance;

  Future<void> loginAuth({
    required String email,
    required String password,
  }) async {
    emit(LoginAuthLoading());
    try {
      final UserCredential userCredential = await user
          .signInWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      if (userCredential.user != null) {
        emit(LoginAuthSuccess());
        return;
      }

      emit(LoginAuthFailure('Login failed. Please try again.'));
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginAuthFailure('No user found for that email.'));
        return;
      } else if (e.code == 'wrong-password') {
        emit(LoginAuthFailure('Wrong password provided for that user.'));
        return;
      } else if (e.code == 'invalid-email') {
        emit(LoginAuthFailure('The email address is not valid.'));
        return;
      } else if (e.code == 'user-disabled') {
        emit(
          LoginAuthFailure(
            'The user account has been disabled by an administrator.',
          ),
        );
        return;
      } else if (e.code == 'network-request-failed') {
        emit(
          LoginAuthFailure(
            'A network error occurred. Please check your connection.',
          ),
        );
        return;
      } else if (e.code == 'too-many-requests') {
        emit(LoginAuthFailure('Too many attempts. Please try again later.'));
        return;
      } else if (e.code == 'invalid-credential') {
        emit(
          LoginAuthFailure(
            'Invalid credentials. Please re-enter your email and password.',
          ),
        );
        return;
      } else {
        emit(LoginAuthFailure('Auth error: ${e.code}'));
        return;
      }
    } catch (e) {
      emit(LoginAuthFailure('An unexpected error occurred. Please try again.'));
      return;
    }
  }
}
