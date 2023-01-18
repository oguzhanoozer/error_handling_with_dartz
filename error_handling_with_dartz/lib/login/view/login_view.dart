import 'package:error_handling_with_dartz/login/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  LoginViewModel loginViewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Hello World'),
          ),
          ElevatedButton(
              onPressed: () async {
                //await loginViewModel.login();
                await loginViewModel.loginTwo();
              },
              child: Text("Login"))
        ],
      ),
    );
  }
}
