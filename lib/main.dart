import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_sample/root.dart';
import 'package:login_sample/view/error.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [Logger()],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, snapshot) {
        // 取得が完了していないときに表示するWidget
        if (snapshot.connectionState != ConnectionState.done) {
          // インジケーターを回しておきます
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return MaterialApp(
            title: 'login_sample',
            home: ErrorPage(),
          );
        }

        // データが取得できなかったときに表示するWidget
        if (!snapshot.hasData) {
          return Text('データが見つかりません');
        }

        // Once complete, show your application
        return MaterialApp(
          title: 'login_sample',
          home: RootPage(),
        );
      },
    );
  }
}

// logger for riverpod
class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object newValue) {
    print('''{
            "provider": "${provider.name ?? provider.runtimeType}",
            "newValue": "$newValue"
          }''');
  }
}
