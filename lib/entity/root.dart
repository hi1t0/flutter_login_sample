import 'package:flutter/foundation.dart'; // *.freezed.dartで必要なのでimportしておく
import 'package:freezed_annotation/freezed_annotation.dart';

part 'root.freezed.dart';

@freezed
abstract class RootState with _$RootState {
  const factory RootState({
    @Default('login') String page,
  }) = _RootState;
}
