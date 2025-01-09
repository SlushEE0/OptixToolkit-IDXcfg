import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OptixToolkit/ui/ForgetPassword.dart';
import 'package:OptixToolkit/ui/CreateAccount.dart';
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/services/firebase.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Color background = const Color(0xff26292c);
  final Color blue = const Color(0xff159deb);
  final Color white = const Color(0xffffffff);
  final Color gray = const Color(0xff3A3D41);
  final Color subtleGray = const Color(0xffcccccc);
  final Color divider = const Color(0xff3a3d41);
  bool _showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Center(
          child: Text(
            "LOGIN",
            style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Container(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email.';
                        }
                        return null;
                      },
                      controller: emailController,
                      style: GoogleFonts.rubik(color: Colors.white),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: gray,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        hintStyle: GoogleFonts.rubik(color: subtleGray),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: !_showPassword,
                      style: GoogleFonts.rubik(color: Colors.white),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.security),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: _showPassword ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() => _showPassword = !_showPassword);
                          },
                        ),
                        fillColor: gray,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        hintStyle: GoogleFonts.rubik(color: subtleGray),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 300,
                    child: Divider(
                      color: divider,
                      height: 20,
                      thickness: 2,
                      endIndent: 0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ButtonTheme(
                    minWidth: 300,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          Auth.signIn(
                            emailController.text,
                            passwordController.text,
                            context,
                          );
                        }
                      },
                      child: Text(
                        'LOG IN',
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Forgot Password?',
                      style: GoogleFonts.rubik(color: blue, fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigationService.goTo(
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  ForgetPassword(),
                            ),
                          );
                        },
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'New to Toolkit? ',
                      style: GoogleFonts.rubik(color: subtleGray, fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'Create account.',
                          style: GoogleFonts.rubik(
                            color: blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavigationService.goTo(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          CreateAccount(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}