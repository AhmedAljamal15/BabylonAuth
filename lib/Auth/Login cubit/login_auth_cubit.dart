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
      UserCredential userCredential = await user.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    
      await userCredential.user!.updateDisplayName(
        userCredential.user!.displayName!.trim(),
      );
      if (userCredential.user != null) {
        emit(LoginAuthSuccess());
      }
      emit(LoginAuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginAuthFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginAuthFailure('Wrong password provided for that user.'));
      } else if (e.code == 'invalid-email') {
        emit(LoginAuthFailure('The email address is not valid.'));
      } else if (e.code == 'user-disabled') {
        emit(
          LoginAuthFailure(
            'The user account has been disabled by an administrator.',
          ),
        );
      } else if (e.code == 'network-request-failed') {
        emit(
          LoginAuthFailure(
            'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
          ),
        );
      }

      emit(LoginAuthFailure(e.toString()));
    } catch (e) {
      emit(LoginAuthFailure('An error occurred while signing up. Please try again. ${e.toString()}'));
    }
  }
}
