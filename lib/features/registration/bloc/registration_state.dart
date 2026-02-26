import 'package:flutter/material.dart';

@immutable
class RegistrationState {
  final String error;
  final bool isLoading;
  final bool isSuccess;
  final String email;
  final String password;
  final String name;
  final String confirmPassword;
  final String phone;
  const RegistrationState({
    required this.error,
    this.isLoading = false,
    this.isSuccess = false,
    this.email = "",
    this.password = "",
    this.name = "",
    this.confirmPassword = "",
    this.phone = "",
  });
  static RegistrationState get initialState => RegistrationState(error: '');

  RegistrationState clone({
    required String error,
    bool isLoading = false,
    bool isSuccess = false,
    String? email,
    String? password,
    String? name,
    String? confirmPassword,
    String? phone,
  }) {
    return RegistrationState(
      error: error,
      isLoading: isLoading,
      isSuccess: isSuccess,
      email: email ?? "",
      password: password ?? "",
      name: name ?? "",
      confirmPassword: confirmPassword ?? "",
      phone: phone ?? "",
    );
  }

  RegistrationState copyWith({
    String? error,
    bool? isLoading,
    bool? isSuccess,
    String? email,
    String? password,
    String? phone,
    String? confirmPassword,
    String? name,
  }) {
    return RegistrationState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phone: phone ?? this.phone,
    );
  }
}
