// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_course_preview/data/models/user.dart';
import 'package:riverpod_course_preview/presentation/shared/enum/ui_state.dart';
import 'package:riverpod_course_preview/presentation/shared/repository_provider.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final repositoryService = ref.read(repositoryProvider); 
  return LoginNotifier(const LoginState(), repositoryService);
});

class LoginState {
  final User? user;
  final UIState? uiState;

  const LoginState({this.user, this.uiState});

  LoginState copyWith({
    User? user,
    UIState? uiState,
  }) {
    return LoginState(
      user: user ?? this.user,
      uiState: uiState ?? this.uiState,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final RepositoryService repositoryService;
  LoginNotifier(super.state, this.repositoryService);

  Future<void> login(String username, String password) async {
    state = state.copyWith(uiState: UIState.loading);
    try {
      final user =
          await repositoryService.authRepository.login(username, password);
      state = state.copyWith(user: user);
    } catch (err) {
      rethrow;
    }finally {
       state = state.copyWith(uiState: UIState.data);
    }
  }
}
