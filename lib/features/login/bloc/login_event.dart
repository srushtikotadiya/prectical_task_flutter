import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent {}

class ErrorEvent extends LoginEvent {
  final String error;

  ErrorEvent(this.error);
}

class HandleLogin extends LoginEvent {}

class OnPasswordChanged extends LoginEvent {
  final String passowrd;
  OnPasswordChanged(this.passowrd);
}

class OnEmailChanged extends LoginEvent {
  final String email;
  OnEmailChanged(this.email);
}
