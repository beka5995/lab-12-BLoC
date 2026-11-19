import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    // 1. Эмитим состояние загрузки
    emit(const AuthLoading());

    await Future.delayed(const Duration(milliseconds: 1200)); // Симуляция сетевого запроса

    // 2. Валидация учетных данных
    if (email.trim() == 'bekzat@narxoz.kz' && password == '123456') {
      emit(const AuthSuccess(
        username: 'Bekzat Senior',
        email: 'bekzat@narxoz.kz',
      ));
    } else {
      emit(const AuthError('Invalid credentials! Hint: bekzat@narxoz.kz / 123456'));
    }
  }

  void logout() {
    emit(const AuthInitial());
  }
}
