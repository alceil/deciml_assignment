import 'package:bloc/bloc.dart';
import 'package:deciml_assignment/data/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository(),
        super(UnAuthenticated());
 var box = Hive.box('Currencies');
  Future<void> signIn({String? email, password}) async {
    emit(Loading());
    print(email);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password,
      )
        .then((value) {
        if (value.user != null) {
          emit(Authenticated());
        }
      });
    } on FirebaseAuthException catch (e) {
      print("exception2 $e");
    if (e.code == 'user-not-found') {
      emit(AuthError('No User Found'));
    } else if (e.code == 'wrong-password') {
      emit(AuthError('Wrong password.'));
    }
    emit(UnAuthenticated()); 
    }catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> signUp({String? email, password, name}) async {
    emit(Loading());
    try {
      await _authRepository.signUp(
          email: email!, password: password, name: name);
      // print(userCredentials)
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> googleSignIn() async {
    emit(Loading());
    try {
      await _authRepository.signInWithGoogle();
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> signOut() async {
    emit(Loading());
    await _authRepository.signOut();
    emit(UnAuthenticated());
  }
}
