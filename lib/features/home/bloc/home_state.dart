import 'package:flutter/material.dart';
import 'package:prectical_task_flutter/core/common/models/user_model.dart';

@immutable
class HomeState {
  final String error;
  final List<UserModel> users;
  final bool isLoading;
  final bool isUpdateSuccess;
  final bool isDeleteSuccess;
  final UserModel? userModel;
  const HomeState({
    required this.error,
    this.users = const [],
    this.isLoading = false,
    this.isDeleteSuccess = false,
    this.isUpdateSuccess = false,
    this.userModel,
  });

  static HomeState get initialState => HomeState(error: '');

  HomeState clone({required String error}) {
    return HomeState(error: error);
  }

  HomeState copyWith({
    String? error,
    bool? isLoading,
    List<UserModel>? users,
    bool? isDeleteSuccess,
    bool? isUpdateSuccess,
    UserModel? userModel,
  }) {
    return HomeState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isDeleteSuccess: isDeleteSuccess ?? this.isDeleteSuccess,
      isUpdateSuccess: isUpdateSuccess ?? this.isUpdateSuccess,
      users: users ?? this.users,
      userModel: userModel??this.userModel
    );
  }
}
