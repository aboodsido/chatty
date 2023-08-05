import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      //Perform Login logic using bloc
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          var auth = FirebaseAuth.instance;
          UserCredential user = await auth.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errorMessage: 'No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(
                errorMessage: 'Wrong password provided for that user.'));
          }
        } catch (e) {
          emit(LoginFailure(errorMessage: 'There something error'));
        }

        //Perform Register logic using bloc
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          var auth = FirebaseAuth.instance;
          UserCredential user = await auth.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(
                errorMessage: 'The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(
                errorMessage: 'The account already exists for that email.'));
          }
        } catch (e) {
          emit(RegisterFailure(errorMessage: 'errorMessage'));
        }
      }
    });
  }
}
