import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groupool/Views/signin.dart';
import 'package:groupool/util/auth.dart';
import 'package:owesome_validator/owesome_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groupool/util/database.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GrouPool'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign-Up',
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    )),
                const Divider(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email ID',
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink)),
                      child: const Text('Create Account'),
                      onPressed: () async {
                        if (!OwesomeValidator.name(emailController.text,
                            '${OwesomeValidator.patternEmail}')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid Email')));
                        } else if (!OwesomeValidator.name(nameController.text,
                            '${OwesomeValidator.patternNameOnlyChar}')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid Name')));
                        } else if (!OwesomeValidator.phone(phoneController.text,
                            '${OwesomeValidator.patternPhone}')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid Number')));
                        } else if (!OwesomeValidator.password(
                            passwordController.text,
                            '${OwesomeValidator.passwordMinLen8withCamelAndSpecialChar}')) {
                          // Scaffold.of(context).showSnackBar)
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid Pwd')));
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Password & Confirm Password must match')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Good To Go')));
                          registerWithEmailPassword(
                                  emailController.text, passwordController.text)
                              .then((user) => {
                                    if (user != null)
                                      {print('${user.email} Registered!')}
                                  });
                          // try {
                          //   UserCredential userCredential =
                          //       await auth.createUserWithEmailAndPassword(
                          //           email: emailController.text,
                          //           password: passwordController.text);
                          // } on FirebaseAuthException catch (e) {
                          //   if (e.code == 'weak-password') {
                          //     print('The password provided is too weak.');
                          //   } else if (e.code == 'email-already-in-use') {
                          //     print(
                          //         'The account already exists for that email.');
                          //   }
                          // } catch (e) {
                          //   print(e);
                          // }
                          registerUser(nameController.text,emailController.text, phoneController.text).then((value) => {});
                        }
                      },
                    )),
                // ignore: avoid_unnecessary_containers
                Container(
                    child: Row(
                  children: <Widget>[
                    const Text("Already have account?"),
                    FlatButton(
                      textColor: Colors.blue,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          //MaterialPageRoute(builder: (context) => const SignInPage()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
