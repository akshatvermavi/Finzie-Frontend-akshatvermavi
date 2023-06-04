import 'package:finzie/services/auth_services.dart';
import 'package:finzie/utils/utils.dart';
import 'package:flutter/material.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  @override
  Widget build(BuildContext context) {
    final Object? rcvdData = ModalRoute.of(context)?.settings.arguments;
    final Map<String, String> temp = rcvdData as Map<String, String>;
    final otpController = TextEditingController();
    String? phone = temp['phone'];
    String? password = temp['password'];

    String phoneNumber = '';
    String otp = '';

    var code = "";
    return Scaffold(
    body: Container(
          width: 437,
          height: 877,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff474646),
          ),
          child: Stack(
            children:[
              const Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "You  have an account ? Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 130,
                top: 823,
                child: Text(
                  "You  have an account ? Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 437,
                    height: 799,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50), ),
                      color: Color(0xfffeffff),
                    ),
                    padding: const EdgeInsets.only(left: 5, right: 25, bottom: 107, ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Container(
                          width: 407,
                          height: 44,
                          child: Stack(
                            children:[
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 407,
                                    height: 30,
                                    padding: const EdgeInsets.only(right: 121, ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 324,
                                top: 16,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 20,
                                      height: 14,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const FlutterLogo(size: 14),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      width: 16,
                                      height: 14,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const FlutterLogo(size: 14),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      width: 25,
                                      height: 14,
                                      child: Stack(
                                        children:[
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                width: 23,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Stack(
                                                  children:[
                                                    Container(
                                                      width: 23,
                                                      height: 12,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: const Color(0x9917252a),
                                                      ),
                                                    ),
                                                    Positioned.fill(
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: Container(
                                                          width: 19,
                                                          height: 8,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(1),
                                                            color: const Color(0xff2b7a78),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                width: 1,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: const Color(0x9917252a),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 330,
                                top: 8,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[

                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 21,
                                top: 12,
                                child: Container(
                                  width: 54,
                                  height: 21,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.only(left: 11, right: 10, ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Container(
                                        width: 33,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const FlutterLogo(size: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        Opacity(
                          opacity: 0.65,
                          child: Container(
                            width: 30,
                            height: 31,
                            child: Stack(
                              children:[Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 23.60,
                                    height: 20.85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xff2b7a78), width: 1, ),
                                      color: const Color(0xff2b7a78),
                                    ),
                                  ),
                                ),
                              ),
                                Container(
                                  width: 30,
                                  height: 31,
                                ),],
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: 135,
                          height: 121,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xff3aafa9),
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "OTP Verification",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff474646),
                            fontSize: 22,
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "We Will send you a one time password on\n this  Mobile Number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "+91 - 12989200823",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 15,
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff3aafa9), width: 1, ),
                            color: const Color(0xffdef2f1),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff3aafa9), width: 1, ),
                            color: const Color(0xffdef2f1),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff3aafa9), width: 1, ),
                            color: const Color(0xffdef2f1),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff3aafa9), width: 1, ),
                            color: const Color(0xffdef2f1),
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "2",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "2",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "9",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "9",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: 259,
                          height: 39,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xff3aafa9), width: 0.50, ),
                            color: const Color(0xff3aafa9),
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "Submit",
                          style: TextStyle(
                            color: Color(0xfffeffff),
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Opacity(
                    opacity: 0.20,
                    child: Container(
                      width: 543,
                      height: 543,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff3aafa9),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Opacity(
                    opacity: 0.20,
                    child: Container(
                      width: 392,
                      height: 392,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff3aafa9),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
