import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/features/loginPage/loginpage.dart';

import 'registerpage_view_model.dart';

class RegisterPageView extends RegisterPageViewModel {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatsapp Clone Sign up Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              TextField(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                ),
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 25),
                  border: OutlineInputBorder(),
                  hintText: 'John',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                ),
                controller: surnameController,
                decoration: InputDecoration(
                  labelText: 'Surname',
                  labelStyle: TextStyle(fontSize: 25),
                  border: OutlineInputBorder(),
                  hintText: 'Doe',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
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
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                ),
                controller: passwordController,
                decoration: InputDecoration(
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
                        .signUp(emailController.text, passwordController.text,
                            nameController.text, surnameController.text)
                        .then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Sign up',
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
                    "Have an account? ",
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
                          builder: (BuildContext context) => LoginPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          "\t Log in",
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
