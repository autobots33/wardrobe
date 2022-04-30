import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';


@immutable //  Annotation telling that this class or any subclasses  of this class are going to be immutable meaning that their internals are never going to be changed upon initialization
class AuthUser{
  final bool isEmailVerified;
  const AuthUser(this.isEmailVerified);
  factory AuthUser.fromFirebase(User user)=>AuthUser(user.emailVerified);
}
