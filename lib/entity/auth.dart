import 'package:flutter/foundation.dart'; // *.freezed.dartで必要なのでimportしておく
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    String password,
    String email,
  }) = _SignUpState;
}

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    String password,
    String email,
  }) = _LoginState;
}
