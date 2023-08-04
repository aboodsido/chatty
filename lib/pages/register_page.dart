import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/cubits/register_cubit/register_cubit.dart';
import 'package:flutter_chat/pages/chat_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../cubits/chat_cubit/chat_cubit.dart';
import '../helper/show_snackBar.dart';
import '../widgets/custom_textField.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';

  var titleFontStyle = GoogleFonts.cairo(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errorMessage!, Colors.red);
          isLoading = false;
        }
      },
      builder: (context, state) {
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
                      SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.cairo(
                              color: Colors.white, fontSize: 25),
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
                              BlocProvider.of<RegisterCubit>(context)
                                  .registerUser(
                                      email: email!, password: password!);
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
      },
    );
  }
}
