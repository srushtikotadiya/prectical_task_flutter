import 'package:flutter/material.dart';

@immutable
abstract class RegistrationEvent {}

class ErrorEvent extends RegistrationEvent {
  final String error;

  ErrorEvent(this.error);
}

class OnNameChanged extends RegistrationEvent {
  final String name;
  OnNameChanged(this.name);
}

class OnPhoneNumberChanged extends RegistrationEvent {
  final String phone;
  OnPhoneNumberChanged(this.phone);
}

class OnEmailChanged extends RegistrationEvent {
  final String email;
  OnEmailChanged(this.email);
}

class OnConfirmPasswordChanged extends RegistrationEvent {
  final String confirmPassword;
  OnConfirmPasswordChanged(this.confirmPassword);
}

class OnPasswordChanged extends RegistrationEvent {
  final String passowrd;
  OnPasswordChanged(this.passowrd);
}

class HandleRegistration extends RegistrationEvent {}
