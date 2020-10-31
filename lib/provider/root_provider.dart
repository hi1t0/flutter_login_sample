import 'package:hooks_riverpod/all.dart';
import 'package:login_sample/entity/root.dart';
import 'package:state_notifier/state_notifier.dart';

final rootStateProvider = StateNotifierProvider((_) => RootStateProvider());

class RootStateProvider extends StateNotifier<RootState> {
  RootStateProvider() : super(const RootState());

  void setPage(currentUser) {
    if (currentUser == null) {
      state = state.copyWith(page: 'login');
    } else {
      state = state.copyWith(page: 'home');
    }
  }
}
