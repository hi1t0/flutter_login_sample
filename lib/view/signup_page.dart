import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:login_sample/provider/signup_provider.dart';
import 'package:login_sample/root.dart';
import 'package:login_sample/widget/dialog.dart';

class SignUpPage extends HookWidget {
  final passwordController = TextEditingController();
  final mailController = TextEditingController();

  final dialog = MyDialog();

  @override
  Widget build(BuildContext context) {
    final ssp = useProvider(signUpStateProvider);
    final signUpState = useProvider(signUpStateProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: Text('サインアップ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '＊',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                Text('は必須'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.blue[400],
                    child: Text('登録', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      try {
                        await ssp.signUp(
                            signUpState.password, signUpState.email);
                        await dialog.show(context, '登録完了しました');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RootPage()));
                      } catch (e) {
                        dialog.show(context, e.toString());
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  ' ＊ ',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 5,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'メールアドレスを入力してください'),
                    controller: mailController,
                    onChanged: (text) {
                      ssp.setMailText(text);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  ' ＊ ',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 5,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'パスワードを入力してください'),
                    obscureText: true,
                    controller: passwordController,
                    onChanged: (text) {
                      ssp.setPasswordText(text);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
