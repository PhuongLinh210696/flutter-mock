import 'package:flutter/material.dart';
import 'package:myapp/Day4/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: buildHomePageLogin(),
    );
  }

  Widget buildHomePageLogin() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Form'),
      ),
      body: const _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  static const String email = "phuonglinh210696@gmail.com";
  static const String password = "123";

  @override
  State<StatefulWidget> createState() => _loginFormState();
}

class _loginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Input email
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    }),
              ),
              //Input password
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  obscureText: _passwordVisible,
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Submit'),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (emailController.text == _LoginForm.email &&
          passwordController.text == _LoginForm.password) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    email: emailController.text,
                  )),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Credentials')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill input')),
      );
    }
  }
}
