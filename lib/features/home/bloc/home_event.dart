import 'package:flutter/material.dart';
import 'package:prectical_task_flutter/core/common/models/user_model.dart';

@immutable
abstract class HomeEvent {}

class ErrorEvent extends HomeEvent {
  final String error;

  ErrorEvent(this.error);
}

class PageAppear extends HomeEvent {}

class DeleteUserEvent extends HomeEvent {
  final String id;
  DeleteUserEvent({this.id = ""});
}

class UpdateUserEvent extends HomeEvent {
  final UserModel userModel;
  UpdateUserEvent({required this.userModel});
}
