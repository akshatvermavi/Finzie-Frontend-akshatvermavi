import 'package:email_validator/email_validator.dart';
import 'package:finzie/services/auth_services.dart';
import 'package:finzie/utils/utils.dart';
import 'package:flutter/material.dart';

// add finzie icon
class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
    body: Container(
          width: 443,
          height: 877,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1e000000),
                blurRadius: 32,
                offset: Offset(0, 4),
              ),
            ],
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(left: 28, right: 29, top: 35, bottom: 415, ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(width: 275.25),
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
              const SizedBox(height: 44.39),
              Container(
                width: 140,
                height: 104,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xff3aafa9),
                ),
              ),
              const SizedBox(height: 44.39),
              const SizedBox(
                width: 305,
                child: Text(
                  "Reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff474646),
                    fontSize: 28,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 44.39),
              Container(
                width: 364,
                height: 51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color(0xffdef2f1),
                ),
                padding: const EdgeInsets.only(left: 16, right: 177, top: 14, bottom: 5, ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    SizedBox(
                      width: 171,
                      height: 32,
                      child: Text(
                        "Enter your email",
                        style: TextStyle(
                          color: Color(0x7f000000),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 44.39),
              Container(
                width: 259,
                height: 39,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xff3aafa9), width: 0.50, ),
                  color: const Color(0xff3aafa9),
                ),
                padding: const EdgeInsets.only(top: 5, bottom: 2, ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    SizedBox(
                      width: 259,
                      height: 32,
                      child: Text(
                        "Get password reset email\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
