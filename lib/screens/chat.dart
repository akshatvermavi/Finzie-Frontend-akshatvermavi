import 'package:finzie/services/auth_services.dart';
import 'package:finzie/utils/utils.dart';
import 'package:flutter/material.dart';

class Data {
  static var salary = 5000.0;
  static var save = 2000.0;
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final Object? rcvdData = ModalRoute.of(context)?.settings.arguments;
    final Map<String, String> temp = rcvdData as Map<String, String>;

    final salaryCon = TextEditingController();
    final saveCon = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
    body: Container(
          width: 437,
          height: 877,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xff2b7a78), width: 1.50, ),
            color: Colors.white,
          ),
          child: Stack(
            children:[
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
              const Positioned(
                left: 71,
                top: 29,
                child: SizedBox(
                  width: 66,
                  height: 26,
                  child: Text(
                    "finzie",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 80,
                top: 46,
                child: SizedBox(
                  width: 133,
                  height: 26,
                  child: Text(
                    "active now",
                    style: TextStyle(
                      color: Color(0xff7c8894),
                      fontSize: 10,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 71,
                top: 56,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff4e9269),
                  ),
                ),
              ),
              const Positioned(
                left: 23,
                top: 147,
                child: SizedBox(
                  width: 368,
                  height: 51,
                  child: Text(
                    "let’s track your spendings now",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 238,
                child: Container(
                  width: 348,
                  height: 55,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Container(
                        width: 348,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xff3aafa9),
                        ),
                        padding: const EdgeInsets.only(left: 12, ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            SizedBox(
                              width: 336,
                              height: 51,
                              child: Text(
                                "what’s your monthly salary/pocket money?",
                                style: TextStyle(
                                  color: Color(0xff17252a),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 433,
                child: Container(
                  width: 348,
                  height: 55,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Container(
                        width: 348,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xff3aafa9),
                        ),
                        padding: const EdgeInsets.only(left: 12, ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            SizedBox(
                              width: 336,
                              height: 51,
                              child: Text(
                                "how much do you want to save?",
                                style: TextStyle(
                                  color: Color(0xff17252a),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 190,
                top: 337,
                child: Container(
                  width: 215,
                  height: 51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color(0xffdef2f1),
                  ),
                ),
              ),
              Positioned(
                left: 190,
                top: 533,
                child: Container(
                  width: 215,
                  height: 51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color(0xffdef2f1),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 639,
                child: Container(
                  width: 348,
                  height: 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xff3aafa9),
                  ),
                ),
              ),
              const Positioned(
                left: 45,
                top: 649,
                child: SizedBox(
                  width: 327,
                  height: 102,
                  child: Text(
                    "Please allow us to track your expenses by reading the instructions in your text messages :)\n",
                    style: TextStyle(
                      color: Color(0xff17252a),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5.28,
                top: 667.54,
                child: Container(
                  width: 19,
                  height: 17.62,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff3aafa9),
                  ),
                ),
              ),
              Positioned(
                left: 98,
                top: 796,
                child: Container(
                  width: 218,
                  height: 51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff3aafa9),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      SizedBox(
                        width: 218,
                        height: 51,
                        child: Text(
                          "continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffdef2f1),
                            fontSize: 24,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
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
              Positioned(
                left: 16,
                top: 25,
                child: Container(
                  width: 46,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff3aafa9),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
