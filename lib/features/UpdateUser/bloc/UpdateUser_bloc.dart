import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/common/models/user_model.dart';
import '../../../core/repositories/auth_repository.dart';
import 'UpdateUser_event.dart';
import 'UpdateUser_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  AuthRepository _authRepository;
  final UserModel userModel;
  UpdateUserBloc(BuildContext context, this.userModel)
    : _authRepository = AuthRepository(),
      super(UpdateUserState.initialState) {
    on<EditUserEvent>(_onEditUser);
    on<OnEmailChanged>(_onEmailChanged);
    on<OnNameChanged>(_onNameChanged);
    on<OnPhoneNumberChanged>(_onPhoneNumberChanged);
    on<PageAppear>(_pageAppear);
  }
  void _pageAppear(PageAppear event, Emitter<UpdateUserState> emit) {
    emit(
      state.copyWith(
        email: userModel.email,
        name: userModel.name,
        phone: userModel.phone,
      ),
    );
  }

  Future<void> _onEditUser(
    EditUserEvent event,
    Emitter<UpdateUserState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      UserModel user = UserModel(
        email: state.email,
        password: state.password,
        name: state.name,
        phone: state.phone,
        id: userModel.id,
      );
      final isLogin = await _authRepository.updateUser(user);
      if (isLogin) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, error: "Registration fail"));
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> _onNameChanged(
    OnNameChanged event,
    Emitter<UpdateUserState> emit,
  ) async {
    emit(state.copyWith(name: event.name));
  }

  Future<void> _onPhoneNumberChanged(
    OnPhoneNumberChanged event,
    Emitter<UpdateUserState> emit,
  ) async {
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onEmailChanged(
    OnEmailChanged event,
    Emitter<UpdateUserState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }
}
