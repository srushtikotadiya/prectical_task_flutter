import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:prectical_task_flutter/core/repositories/auth_repository.dart';
import 'package:prectical_task_flutter/core/utilities/helper/injactable.dart';

import '../../../core/common/models/user_model.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository _authRepository;
  LoginBloc(BuildContext context)
    : _authRepository = getIt<AuthRepository>(),
      super(LoginState.initialState) {
    on<HandleLogin>(_onlogin);
    on<OnEmailChanged>(_onEmailChanged);
    on<OnPasswordChanged>(_onPasswordChanged);
  }
  Future<void> _onlogin(HandleLogin event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      UserModel userModel = UserModel(
        email: state.email,
        password: state.password,
      );
      final isLogin = await _authRepository.login(userModel);
      if (isLogin) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, error: "Login fail"));
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> _onPasswordChanged(
    OnPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(password: event.passowrd));
  }

  Future<void> _onEmailChanged(
    OnEmailChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  // @override
  // Stream<LoginState> mapEventToState(loginEvent event) async* {
  //   switch (event.runtimeType) {
  //     case ErrorEvent:
  //       final error = (event as ErrorEvent).error;
  //       yield state.clone(error: "");
  //       yield state.clone(error: error);
  //       break;
  //   }
  // }

  // @override
  // void onError(Object error, StackTrace stacktrace) {
  //   _addErr(error);
  //   super.onError(error, stacktrace);
  // }

  // @override
  // Future<void> close() async {
  //   await super.close();
  // }

  // void _addErr(e) {
  //   if (e is StateError) return;
  //   try {
  //     add(ErrorEvent((e is String) ? e : (e.message ?? "Something went wrong. Please try again!")));
  //   } catch (e) {
  //     add(ErrorEvent("Something went wrong. Please try again!"));
  //   }
  // }
}
