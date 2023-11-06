// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/shared_widgets/button.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:chat_app/shared_widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool passobsure = true, isLoading = false;
  String? email, pass;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff2B475E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 70,
                    ),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 150,
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chat",
                      style: TextStyle(color: Color(0xfffeb200), fontSize: 50),
                    ),
                    Text(
                      " App",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 25, top: 80),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Color(0xffC7EDE6), fontSize: 30),
                  ),
                ),
                CustomTextFormField(
                  validate: (data) {
                    if (data!.isEmpty) {
                      return "field is required";
                    }
                  },
                  onchange: (data) {
                    email = data;
                  },
                  obscure: false,
                  hint: "Enter your E-mail",
                  label: const SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "  E-mail",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                CustomTextFormField(
                  validate: (data) {
                    if (data!.isEmpty) {
                      return "field is required";
                    }
                  },
                  onchange: (data) {
                    pass = data;
                  },
                  hint: "Enter your Password",
                  label: const SizedBox(
                    width: 135,
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "  Password",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  obscure: passobsure,
                  suffix: InkWell(
                    highlightColor: const Color(0xffF8F8F8),
                    splashColor: const Color(0xffF8F8F8),
                    child: Icon(
                      passobsure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        passobsure = !passobsure;
                      });
                    },
                  ),
                ),
                CustomButton(
                    text: "Login",
                    ontap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await loginUser();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ChatPage(email: email!,);
                              },
                            ),
                          );
                        } catch (e) {
                          showSnackBar(context, "check email or password and try again");
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        " Register",
                        style:
                            TextStyle(color: Color(0xffC7EDE6), fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: pass!);
  }
}
