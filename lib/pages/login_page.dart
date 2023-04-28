import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/register_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snackBar.dart';
import '../widgets/custom_textField.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var titleFontStyle = GoogleFonts.cairo(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
              child: Column(
                children: [
                  Image.asset(
                    'asset/images/chat.png',
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    'Chatty',
                    style: titleFontStyle,
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      'Sign In',
                      style:
                          GoogleFonts.cairo(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFromField(
                    hintText: 'Email',
                    obscuring: false,
                    onChanged: (data) {
                      email = data;
                    },
                    hintTextColor: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFromField(
                    hintText: 'Password',
                    obscuring: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintTextColor: Colors.white,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan, elevation: 4),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await loginUser();
                            Navigator.pushNamed(
                              context,
                              ChatPage.id,
                              arguments: email,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(context,
                                  'No user found for that email.', Colors.red);
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(
                                  context,
                                  'Wrong password provided for that user.',
                                  Colors.red);
                            }
                          } catch (e) {
                            print(e);
                            showSnackBar(
                                context, "there was an error", Colors.red);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        } else {}
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.cairo(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: GoogleFonts.cairo(
                            fontSize: 15, color: Colors.white),
                      ),
                      GestureDetector(
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.cairo(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
