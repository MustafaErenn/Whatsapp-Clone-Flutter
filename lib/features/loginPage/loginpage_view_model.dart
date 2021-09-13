import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/core/services/auth.dart';
import 'package:whatsapp_clone_flutter/core/services/locator.dart';
import 'loginpage.dart';

abstract class LoginPageViewModel extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var model = getIt<AuthService>();

  @override
  void initState() {
    super.initState();
  }
}
