part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {}
final class AuthFailuer extends AuthState {
  final String errMessage;

  AuthFailuer({required this.errMessage});
}
