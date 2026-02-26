import 'package:flutter/material.dart';

@immutable
class UpdateUserState {
  final String error;
  final bool isLoading;
  final bool isSuccess;
  final String email;
  final String password;
  final String name;
  final String phone;
  const UpdateUserState({
    required this.error,
    this.isLoading = false,
    this.isSuccess = false,
    this.email = "",
    this.password = "",
    this.name = "",
    this.phone = "",
  });
  static UpdateUserState get initialState => UpdateUserState(error: '');

  UpdateUserState clone({
    required String error,
    bool isLoading = false,
    bool isSuccess = false,
    String? email,
    String? password,
    String? name,
    String? phone,
  }) {
    return UpdateUserState(
      error: error,
      isLoading: isLoading,
      isSuccess: isSuccess,
      email: email ?? "",
      password: password ?? "",
      name: name ?? "",
      phone: phone ?? "",
    );
  }

  UpdateUserState copyWith({
    String? error,
    bool? isLoading,
    bool? isSuccess,
    String? email,
    String? password,
    String? phone,
    String? name,
  }) {
    return UpdateUserState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
