import 'package:flutter/material.dart';

@immutable
class LoginState {
  final String error;
  final bool isLoading;
  final bool isSuccess;
  final String email;
  final String password;
  const LoginState({
    required this.error,
    this.isLoading = false,
    this.isSuccess = false,
    this.email = "",
    this.password = "",
  });

  static LoginState get initialState => LoginState(error: '');

  LoginState clone({
    required String error,
    bool isLoading = false,
    bool isSuccess = false,
    String? email,
    String? password,
  }) {
    return LoginState(
      error: error,
      isLoading: isLoading,
      isSuccess: isSuccess,
      email: email ?? "",
      password: password ?? "",
    );
  }

  LoginState copyWith({
    String? error,
    bool? isLoading,
    bool? isSuccess,
    String? email,
    String? password,
  }) {
    return LoginState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
