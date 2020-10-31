import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/all.dart';

final authProvider = Provider.autoDispose((ref) => AuthController(ref.read));

class AuthController {
  AuthController(this.read);
  final Reader read;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser = FirebaseAuth.instance.currentUser;

// 登録
  Future signUp(password, mail) async {
    if (password.isEmpty) {
      throw ('パスワードを入力して下さい');
    }

    if (mail.isEmpty) {
      throw ('メールアドレスを入力して下さい');
    }

    // todo:
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    ))
        .user;

    final email = user.email;
  }

// login
  Future login(mail, password) async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力して下さい');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力して下さい');
    }

    final result = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    final uid = result.user.uid;

    if (uid == null) throw ('メールアドレス又はパスワードが違います');
  }

  // signout
  Future signOut() async {
    await _auth.signOut();
  }
}
