import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/signup_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpProvider? provider;

  @override
  void initState() {
    provider = Provider.of<SignUpProvider>(context, listen: false);
    provider!.usernameController = TextEditingController();
    provider!.emailController = TextEditingController();
    provider!.passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    provider!.usernameController!.dispose();
    provider!.emailController!.dispose();
    provider!.passwordController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple.withAlpha(100),
                ),
              ),
            ),
            Positioned(
              left: -40,
              top: 80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pinkAccent.withAlpha(100),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              right: -20,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purpleAccent.withAlpha(100),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withAlpha(240),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Readex",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 48),
                        ),
                        Text("Start Your Adventure!",
                            style: Theme.of(context).textTheme.bodySmall),
                        Consumer<SignUpProvider>(
                          builder: (context, state, _) {
                            return Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: state.formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    controller: state.usernameController,
                                    keyboardType: TextInputType.text,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.person_outline_rounded,
                                      ),
                                    ),
                                    validator: (value) =>
                                        state.validateUsername(value),
                                  ),
                                  TextFormField(
                                    controller: state.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.mail_outline_rounded,
                                      ),
                                    ),
                                    validator: (value) =>
                                        state.validateEmail(value),
                                  ),
                                  // TextFormField(
                                  //   controller: state.passwordController,
                                  //   keyboardType: TextInputType.text,
                                  //   obscureText: true,
                                  //   style:
                                  //       Theme.of(context).textTheme.bodyMedium,
                                  //   decoration: const InputDecoration(
                                  //     icon: Icon(
                                  //       Icons.lock_outline_rounded,
                                  //     ),
                                  //     errorMaxLines: 5,
                                  //   ),
                                  //   validator: (value) =>
                                  //       state.validatePassword(value),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            Provider.of<SignUpProvider>(context,
                                                    listen: false)
                                                .signUp(context);
                                          },
                                          child: const Text("Sign Up"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
