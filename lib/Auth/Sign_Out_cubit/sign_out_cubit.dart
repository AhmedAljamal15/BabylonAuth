import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit() : super(SignOutInitial());
  final FirebaseAuth user = FirebaseAuth.instance;

  Future<void> signOut() async {
    emit(SignOutLoading());
    try {
      await user.signOut();
      emit(SignOutSuccess());
    } on Exception catch (e) {
      emit(SignOutFailure(e.toString()));
    }
  }
}
