import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../utils/utils.dart';

// use % instead os absolute values
// finzie icon is not visible
// not scrollable
class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthService authService = AuthService();

  void signupUser() {
    AuthService().signUpUser(
      context: context,
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
      phone: phoneController.text,
    );
  }

  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body: Container(
          width: 443,
          height: 877,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
               BoxShadow(
                color: Color(0x1e000000),
                blurRadius: 32,
                offset: Offset(0, 4),
              ),
            ],
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(left: 28, right: 29, top: 35, bottom: 138, ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:[
              Container(
                width: 386.30,
                height: 16.44,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Container(
                      width: 33.08,
                      height: 11,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff4f3932),
                      ),
                    ),
                    SizedBox(width: 275.25),
                    Container(
                      width: 77.97,
                      height: 12.96,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Container(
                            width: 19.88,
                            height: 12.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const FlutterLogo(size: 12.198575973510742),
                          ),
                          const SizedBox(width: 5.85),
                          Container(
                            width: 17.93,
                            height: 12.58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const FlutterLogo(size: 12.579667091369629),
                          ),
                          const SizedBox(width: 5.85),
                          Container(
                            width: 28.45,
                            height: 12.96,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Container(
                                  width: 25.73,
                                  height: 12.96,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Container(
                                        width: 25.73,
                                        height: 12.96,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2.67),
                                          border: Border.all(color: const Color(0xff4f3932), width: 1, ),
                                        ),
                                        padding: const EdgeInsets.all(2),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children:[
                                            Container(
                                              width: 21.05,
                                              height: 8.39,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(1.33),
                                                color: const Color(0xff4f3932),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 1.17),
                                Opacity(
                                  opacity: 0.40,
                                  child: Container(
                                    width: 1.55,
                                    height: 4.57,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xff4f3932),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.32),
              Container(
                width: 140,
                height: 104,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xff3aafa9),
                ),
              ),
              const SizedBox(height: 30.32),
              const SizedBox(
                width: 305,
                child: Text(
                  "Welcome to Finzie!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff474646),
                    fontSize: 28,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 30.32),
              Container(
                width: 364,
                height: 51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color(0xffdef2f1),
                ),
                padding: const EdgeInsets.only(left: 16, right: 249, top: 14, bottom: 5, ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    SizedBox(
                      width: 99,
                      height: 32,
                      child: Text(
                        "Name",
                        style: TextStyle(
                          color: Color(0x7f000000),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.32),
              Container(
                width: 364,
                height: 51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color(0xffdef2f1),
                ),
                padding: const EdgeInsets.only(left: 16, right: 198, top: 14, bottom: 5, ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    SizedBox(
                      width: 150,
                      height: 32,
                      child: Text(
                        "Phone Number",
                        style: TextStyle(
                          color: Color(0x7f000000),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.32),
              Container(
                width: 364,
                height: 51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color(0xffdef2f1),
                ),
                padding: const EdgeInsets.only(left: 24, right: 241, top: 14, bottom: 5, ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    SizedBox(
                      width: 99,
                      height: 32,
                      child: Text(
                        "Email",
                        style: TextStyle(
                          color: Color(0x7f000000),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.32),
              Container(
                width: 364,
                height: 51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color(0xffdef2f1),
                ),
                padding: const EdgeInsets.only(left: 11, right: 254, top: 14, bottom: 5, ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    SizedBox(
                      width: 99,
                      height: 32,
                      child: Text(
                        "Password",
                        style: TextStyle(
                          color: Color(0x7f000000),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.32),
              Container(
                width: 364,
                height: 51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color(0xffdef2f1),
                ),
                padding: const EdgeInsets.only(left: 16, right: 167, top: 14, bottom: 5, ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    SizedBox(
                      width: 181,
                      height: 32,
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                          color: Color(0x7f000000),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.32),
              Container(
                width: 238,
                height: 47,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff3aafa9),
                ),
                padding: const EdgeInsets.only(left: 25, right: 32, top: 9, bottom: 6, ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    SizedBox(
                      width: 181,
                      height: 32,
                      child: Text(
                        "Sign up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffdef2f1),
                          fontSize: 18,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
