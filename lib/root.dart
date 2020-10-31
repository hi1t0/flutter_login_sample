import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_sample/provider/login_provider.dart';
import 'package:login_sample/provider/root_provider.dart';
import 'package:login_sample/provider/signup_provider.dart';
import 'package:login_sample/view/home_page.dart';
import 'package:login_sample/view/login_page.dart';

class RootPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final lsp = useProvider(loginStateProvider);
    final ssp = useProvider(signUpStateProvider);
    final rsp = useProvider(rootStateProvider);
    final rootState = useProvider(rootStateProvider.state);

    // ログインしているならホーム画面へ
    useEffect(() {
      // lspからauthProviderを呼ぶためにreadを引数に初期化
      lsp.initState(context.read);
      ssp.initState(context.read);
      Future.microtask(() => rsp.setPage(lsp.getCurrentUser()));
      return () {};
    }, []);

    // Once complete, show your application
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: white,
      ),
      title: 'login_sample',
      home: rootState.page == 'login' ? LoginPage() : HomePage(),
    );
  }
}

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);
