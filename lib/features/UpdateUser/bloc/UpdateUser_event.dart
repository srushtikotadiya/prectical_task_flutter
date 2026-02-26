import 'package:flutter/material.dart';

import '../../../core/common/models/user_model.dart';

@immutable
abstract class UpdateUserEvent {}

class ErrorEvent extends UpdateUserEvent {
  final String error;

  ErrorEvent(this.error);
}

class PageAppear extends UpdateUserEvent {
  final UserModel userModel;
  PageAppear(this.userModel);
}

class EditUserEvent extends UpdateUserEvent {}

class OnNameChanged extends UpdateUserEvent {
  final String name;
  OnNameChanged(this.name);
}

class OnPhoneNumberChanged extends UpdateUserEvent {
  final String phone;
  OnPhoneNumberChanged(this.phone);
}

class OnEmailChanged extends UpdateUserEvent {
  final String email;
  OnEmailChanged(this.email);
}
