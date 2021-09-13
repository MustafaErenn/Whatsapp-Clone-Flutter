import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/features/homePage/home_page.dart';
import 'package:whatsapp_clone_flutter/features/registerPage/registerpage.dart';
import 'loginpage_view_model.dart';

class LoginPageView extends LoginPageViewModel {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatsapp Clone Log in Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              TextField(
                controller: emailController,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'E-Mail',
                  labelStyle: TextStyle(fontSize: 25),
                  border: OutlineInputBorder(),
                  hintText: 'example@gmail.com',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 25),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 150,
                child: OutlinedButton(
                  onPressed: () {
                    model
                        .signIn(emailController.text, passwordController.text)
                        .then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              WhatsappCloneHomePage(),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w200),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          "\tSign up",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
