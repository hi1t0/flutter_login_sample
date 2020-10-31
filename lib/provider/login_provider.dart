import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:login_sample/client/auth.dart';
import 'package:login_sample/entity/auth.dart';
import 'package:state_notifier/state_notifier.dart';

final loginStateProvider = StateNotifierProvider((_) => LoginStateProvider());

class LoginStateProvider extends StateNotifier<LoginState> {
  LoginStateProvider() : super(LoginState());
  Reader read;

  void initState(reader) {
    read = reader;
  }

  User getCurrentUser() {
    return read(authProvider).currentUser;
  }

  Future login(mail, password) async {
    await read(authProvider).login(mail, password);
  }

  Future signOut() async {
    await read(authProvider).signOut();
  }

  setMailText(text) {
    state = state.copyWith(email: text);
  }

  setPasswordText(text) {
    state = state.copyWith(password: text);
  }
}
