import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final FirebaseAuth user = FirebaseAuth.instance;

  Future<void> signUpAuth({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignUpAuthLoading());

    try {
      final credential = await user.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await credential.user!.updateDisplayName(name.trim());

      await credential.user!.reload();

      emit(SignUpAuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpAuthFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpAuthFailure('The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        emit(SignUpAuthFailure('The email address is not valid.'));
      } else {
        emit(SignUpAuthFailure('Auth error: ${e.code}'));
      }
    } catch (e) {
      emit(
        SignUpAuthFailure(
          'An error occurred while signing up. Please try again. ${e.toString()}',
        ),
      );
    }
  }
}
