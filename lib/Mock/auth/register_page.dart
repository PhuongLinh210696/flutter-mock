import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Mock/components/button_login.dart';
import 'package:myapp/Mock/components/textfield.dart';
import 'package:myapp/Mock/services/auth_service.dart';

class RegisterMyNote extends StatefulWidget {
  final Function()? onTap;
  const RegisterMyNote({super.key, required this.onTap});

  @override
  State<RegisterMyNote> createState() => _RegisterMyNoteState();
}

class _RegisterMyNoteState extends State<RegisterMyNote> {
  final emailController = TextEditingController();
  final passworController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    // Hiển thị dialog loading
    showDialog(
      context: context,
      barrierDismissible: false, // Không cho phép đóng dialog khi nhấn ra ngoài
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passworController.text == confirmPasswordController.text) {
        // Thực hiện đăng ky
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passworController.text);
        // Đóng dialog loading khi đăng nhập thành công
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
        }
        errorMessage('Password don\'t match');
      }
    } on FirebaseAuthException catch (err) {
      // Đóng dialog loading khi có lỗi xảy ra
      if (mounted) {
        Navigator.pop(context);
      }
      // Hiển thị thông báo lỗi
      errorMessage(err.code);
    }
  }

  // Thông báo sai email
  void errorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(message),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(height: 100),
              //logo
              const Text(
                'Create Account',
                style: TextStyle(
                    color: Color.fromRGBO(59, 72, 176, 1),
                    fontSize: 40,
                    fontWeight: FontWeight.w900),
              ),

              const SizedBox(height: 10),

              //Welcome
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  'Create an account so you can discovery',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              //username textfield
              MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false),

              const SizedBox(
                height: 20,
              ),
              //password textfield
              MyTextfield(
                controller: passworController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(
                height: 20,
              ),
              //password textfield
              MyTextfield(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 40),

              //sign in button
              ButtonLogin(
                onTap: signUp,
                stringButton: 'Sign Up',
              ),

              const SizedBox(
                height: 30,
              ),
              //register
              GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Already have an account',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),

              const SizedBox(
                height: 50,
              ),

              const Text(
                'Or continute with',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 8,
              ),
              //google sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => AuthService().signInWithGoogle(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                      child: Image.asset(
                        'assets/images/logo/google_logo.png',
                        height: 20,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
        )));
  }
}
