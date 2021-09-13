import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/core/services/auth.dart';
import 'package:whatsapp_clone_flutter/core/services/locator.dart';
import 'package:whatsapp_clone_flutter/features/registerPage/registerpage.dart';

abstract class RegisterPageViewModel extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  var model = getIt<AuthService>();

  @override
  void initState() {
    super.initState();
  }
}
