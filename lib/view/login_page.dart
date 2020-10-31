import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:login_sample/provider/login_provider.dart';
import 'package:login_sample/root.dart';
import 'package:login_sample/view/signup_page.dart';
import 'package:login_sample/widget/dialog.dart';

class LoginPage extends HookWidget {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final dialog = MyDialog();

  @override
  Widget build(BuildContext context) {
    final lsp = useProvider(loginStateProvider);
    final loginState = useProvider(loginStateProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(hintText: 'example@co.jp'),
                  controller: mailController,
                  onChanged: (text) {
                    lsp.setMailText(text);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(hintText: 'パスワード'),
                  obscureText: true,
                  controller: passwordController,
                  onChanged: (text) {
                    lsp.setPasswordText(text);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.blue[400],
                  child: Text('ログインする', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    try {
                      await lsp.login(loginState.email, loginState.password);
                      await dialog.show(context, 'ログインしました');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => RootPage()));
                    } catch (e) {
                      dialog.show(context, e.toString());
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.white,
                  child:
                      Text('新規登録', style: TextStyle(color: Colors.blue[400])),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
