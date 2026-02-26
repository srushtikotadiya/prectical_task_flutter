import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:prectical_task_flutter/core/repositories/auth_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../core/common/models/user_model.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  AuthRepository _authRepository;
  final uuid = Uuid();
  RegistrationBloc(BuildContext context)
    : _authRepository = AuthRepository(),
      super(RegistrationState.initialState) {
    on<HandleRegistration>(_onRegistration);
    on<OnEmailChanged>(_onEmailChanged);
    on<OnPasswordChanged>(_onPasswordChanged);
    on<OnNameChanged>(_onNameChanged);
    on<OnPhoneNumberChanged>(_onPhoneNumberChanged);
    on<OnConfirmPasswordChanged>(_onConfirmPasswordChanged);
  }
  Future<void> _onRegistration(
    HandleRegistration event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      String uniqueId = uuid.v4();

      print(uniqueId);
      emit(state.copyWith(isLoading: true));
      UserModel userModel = UserModel(
        email: state.email,
        password: state.password,
        name: state.name,
        phone: state.phone,
        id: uniqueId,
      );
      final isLogin = await _authRepository.createAccount(userModel);
      if (isLogin) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, error: "Registration fail"));
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> _onPasswordChanged(
    OnPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(password: event.passowrd));
  }

  Future<void> _onConfirmPasswordChanged(
    OnConfirmPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  Future<void> _onNameChanged(
    OnNameChanged event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(name: event.name));
  }

  Future<void> _onPhoneNumberChanged(
    OnPhoneNumberChanged event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onEmailChanged(
    OnEmailChanged event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }
}
