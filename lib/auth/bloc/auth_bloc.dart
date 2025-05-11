import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user: userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: e.message ?? 'حدث خطأ أثناء تسجيل الدخول.'));
    } catch (e) {
      emit(AuthError(message: 'حدث خطأ غير متوقع.'));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user: userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: e.message ?? 'حدث خطأ أثناء إنشاء الحساب.'));
    } catch (e) {
      emit(AuthError(message: 'حدث خطأ غير متوقع.'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: 'حدث خطأ أثناء تسجيل الخروج.'));
    }
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
