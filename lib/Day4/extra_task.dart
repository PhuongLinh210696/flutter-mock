import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/Day4/home_page.dart';

class ExtraTask extends StatelessWidget {
  const ExtraTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('StatefulWidget with Stack Example'),
        ),
        body: Center(
          child: ToggleStackWidget(),
        ),
      ),
    );
  }
}

class ToggleStackWidget extends StatefulWidget {
  @override
  _ToggleStackWidgetState createState() => _ToggleStackWidgetState();
}

class _ToggleStackWidgetState extends State<ToggleStackWidget> {
  bool _showSigin = true;

  void _toggleStack() {
    setState(() {
      _showSigin = !_showSigin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Widget đầu tiên
        if (_showSigin)
          Container(
              width: 400,
              height: 400,
              color: Colors.grey,
              child: Column(
                children: [
                  _LoginForm(),
                  TextButton(
                      onPressed: _toggleStack,
                      child: Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )),
        // Widget thứ hai
        if (!_showSigin)
          Container(
              width: 400,
              height: 400,
              color: Colors.grey,
              child: Column(
                children: [
                  _SignUpForm(),
                  TextButton(onPressed: _toggleStack, child: Text('SignIn'))
                ],
              )),
      ],
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({super.key});
  @override
  State<StatefulWidget> createState() => _signUpForm();
}

class _signUpForm extends State<_SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Input user
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: userController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  }),
            ),
            //Input Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            //Input ConfirmPassword
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                obscureText: _passwordVisible,
                textInputAction: TextInputAction.done,
                controller: confirmPassword,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Confirm Password",
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
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
            ),
            //Input Email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child:
              Expanded(child: TextFormField(
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
                  }),)
               ,
            )
          ],
        ),
      ),
    ));
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
