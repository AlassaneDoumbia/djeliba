
import 'package:djeliba/ui/base.view.dart';
import 'package:djeliba/ui/view_models/login.view_model.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, loginVm, child) {
        return Scaffold(
          body: Form(
            // Attach form key for validations. I won't be adding validations.
            // key: loginVm.formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.phone,
                  onChanged: loginVm.onChangedPhoneNum,
                  decoration: const InputDecoration(hintText: "Phone"),
                ),
                const Divider(height: 2),
                TextFormField(
                  obscureText: true,
                  onChanged: loginVm.onChangedPassword,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => loginVm.onLogin(context),
                  child: loginVm.isLoading ? const CircularProgressIndicator() : const Text("Login"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}