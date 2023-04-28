import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/chat_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snackBar.dart';
import '../widgets/custom_textField.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var titleFontStyle = GoogleFonts.cairo(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  String? email;

  String? password;

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
                      'Sign Up',
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
                            await registerUser();
                            Navigator.pushNamed(
                              context,
                              ChatPage.id,
                              arguments: email,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(
                                  context,
                                  'The password provided is too weak.',
                                  Colors.red);
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(
                                  context,
                                  'The account already exists for that email.',
                                  Colors.red);
                            }
                          } catch (e) {
                            showSnackBar(
                                context, "there was an error", Colors.red);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Text(
                        'Sign Up',
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
                        "Already have an account ? ",
                        style: GoogleFonts.cairo(
                            fontSize: 15, color: Colors.white),
                      ),
                      GestureDetector(
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.cairo(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent),
                        ),
                        onTap: () {
                          Navigator.pop(context);
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

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
