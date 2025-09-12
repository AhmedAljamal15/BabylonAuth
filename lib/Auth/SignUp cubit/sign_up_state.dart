part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpAuthLoading extends SignUpState {}

final class SignUpAuthSuccess extends SignUpState {}

final class SignUpAuthFailure extends SignUpState {
  final String errormessage;
  SignUpAuthFailure(this.errormessage);
}


