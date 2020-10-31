import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_sample/provider/login_provider.dart';
import 'package:login_sample/root.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final lsp = useProvider(loginStateProvider);
    final loginState = useProvider(loginStateProvider.state);

    useEffect(() {
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('TOP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  'home',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 28,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Text(
                    'ログアウト',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    await lsp.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => RootPage()));
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
