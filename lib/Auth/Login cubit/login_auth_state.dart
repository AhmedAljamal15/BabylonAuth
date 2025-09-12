part of 'login_auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginAuthLoading extends AuthState {}

final class LoginAuthSuccess extends AuthState {}

final class LoginAuthFailure extends AuthState {
  final String errormessage;
  LoginAuthFailure( this.errormessage);
}

