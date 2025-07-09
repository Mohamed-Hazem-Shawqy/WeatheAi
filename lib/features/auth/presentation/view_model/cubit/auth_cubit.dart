import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_ai/features/auth/data/repo/auth_repo_implementation.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthRepoImplementation authRepoImplementation = AuthRepoImplementation();

  Future<void> userSignUp(String email, String password) async {
    emit(AuthLoading());
    try {
      await authRepoImplementation.userSignUp(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailuer(errMessage: e.toString()));
    }
  }

  //user signin
  Future<void> userLogIN(String email, String password) async {
    emit(AuthLoading());
    try {
      await authRepoImplementation.userLogIn(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailuer(errMessage: e.toString()));
    }
  }

  //rest pass
  Future<void> restPassowrd(String email) async {
    emit(AuthLoading());
    try {
      await authRepoImplementation.resetPassowrd(email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailuer(errMessage: e.toString()));
    }
  }
}
