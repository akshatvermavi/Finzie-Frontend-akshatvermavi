// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart' as telephony;

import 'package:finzie/screens/calendar.dart';
import 'package:finzie/screens/edit_profile_screen.dart';
import 'package:finzie/screens/edit_salary.dart';
import 'package:finzie/services/auth_services.dart';

import '../providers/user_provider.dart';
import '../utils/constants.dart';

//below we are importing some packages for color
import 'package:flutter/material.dart';
import 'package:finzie/screens/home_screen.dart';
Color myColor = const Color(0xff2b7a78);
//Border.all(color: myColor)

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<List<Transaction>> getPrevTransactions(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('phone');
      // ignore: use_build_context_synchronously
      var data = AuthService()
          .getPrevTransactions(phone: token as String, context: context);
      var list = await data as List<dynamic>;
      List<Transaction> _transactions = [];
      for (var item in list) {
        var map = item as Map<String, dynamic>;
        if ((map['debit']) != "0" && map['debit'] != "0.0") {
          _transactions.add(
            Transaction(map['_id'].toString(),
                title: "Debited",
                amount: -int.parse(map['debit']),
                date: (map['date']).toString(),
                category: map['category'].toString(),
                time: map['time'].toString()),
          );
        } else {
          // print(map['date'].toString());
          _transactions.add(Transaction(map['_id'].toString(),
              title: "Credited",
              amount: int.parse(map['credit']),
              date: (map['date']).toString(),
              category: map['category'].toString(),
              time: map['time'].toString()));
        }
      }
      return _transactions;
    } catch (e) {}
    return [];
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  String debit = "0";
  String credit = "0";
  String last = "0";
  double limit = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _message = "";

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  String _expenseOption = "Today's Expenses";
  static const List<String> _expensesOptions = [
    "Today's Expenses",
    "This Week's Expenses",
    "This Month's Expenses",
  ];

  List<Transaction> transactions = [];

  double _expensesValue = 0;

  List<String> bankNames = [
    'hdfc',
    'sbi',
    'icici',
    'kotak',
    'jupiter',
    'paytm',
    'federal',
    'axis',
    'pbbl',
    'cbi',
    'boi',
    'bob',
    'pnb',
    'yes',
  ];

  var color;

  //get color => null;

  int getTransaction(String message) {
    try {
      String tempMessage = message;
      message = message.toLowerCase();
      print(tempMessage);
      String amount = "";
      int value = 2147483647;

      // Rs INR ₹ debited
      if ((message.contains("rs") ||
              message.contains("inr") ||
              tempMessage.contains('₹')) &&
          (message.contains("debit") ||
              message.contains("debited") ||
              message.contains("paid") ||
              message.contains("spent") ||
              message.contains("sent") ||
              message.contains("deducted") ||
              message.contains("withdrawn") ||
              message.contains("removed") ||
              message.contains("subtracted") ||
              message.contains("reduced") ||
              message.contains("decreased") ||
              message.contains("minus") ||
              message.contains("retracted"))) {
        print('debit');
        if (message.contains("rs")) {
          for (int i = 0; i < message.length; i++) {
            if (message[i] == 'r' && message[i + 1] == 's') {
              while (!(message.codeUnitAt(i) >= 48 &&
                  message.codeUnitAt(i) <= 57)) {
                i++;
              }
              while ((message.codeUnitAt(i) >= 48 &&
                      message.codeUnitAt(i) <= 57) ||
                  message[i] == ',') {
                if (message[i] != ',') amount += message[i];
                i++;
              }
              break;
            }
          }
        } else if (message.contains("inr")) {
          for (int i = 0; i < message.length; i++) {
            if (message[i] == 'i' &&
                message[i + 1] == 'n' &&
                message[i + 2] == 'r') {
              while (!(message.codeUnitAt(i) >= 48 &&
                  message.codeUnitAt(i) <= 57)) {
                i++;
              }
              while ((message.codeUnitAt(i) >= 48 &&
                      message.codeUnitAt(i) <= 57) ||
                  message[i] == ',') {
                if (message[i] != ',') amount += message[i];
                i++;
              }
              break;
            }
          }
        } else if (message.contains('₹')) {
          for (int i = 0; i < message.length; i++) {
            if (message[i] == '₹') {
              while (!(message.codeUnitAt(i) >= 48 &&
                  message.codeUnitAt(i) <= 57)) {
                i++;
              }
              while ((message.codeUnitAt(i) >= 48 &&
                      message.codeUnitAt(i) <= 57) ||
                  message[i] == ',') {
                if (message[i] != ',') amount += message[i];
                i++;
              }
              break;
            }
          }
        }
        value = -int.parse(amount);
      } else if ((message.contains("rs") ||
              message.contains("inr") ||
              tempMessage.contains('₹')) &&
          (message.contains("credited") ||
              message.contains("deposited") ||
              message.contains("deposit") ||
              message.contains("acknowledged") ||
              message.contains("accredited") ||
              message.contains("confirmed") ||
              message.contains("increased") ||
              message.contains("added"))) {
        print("credit");
        if (message.contains("rs")) {
          for (int i = 0; i < message.length; i++) {
            if (message[i] == 'r' && message[i + 1] == 's') {
              while (!(message.codeUnitAt(i) >= 48 &&
                  message.codeUnitAt(i) <= 57)) {
                i++;
              }
              while ((message.codeUnitAt(i) >= 48 &&
                      message.codeUnitAt(i) <= 57) ||
                  message[i] == ',') {
                if (message[i] != ',') amount += message[i];
                i++;
              }
              break;
            }
          }
        } else if (message.contains("inr")) {
          for (int i = 0; i < message.length; i++) {
            if (message[i] == 'i' &&
                message[i + 1] == 'n' &&
                message[i + 2] == 'r') {
              while (!(message.codeUnitAt(i) >= 48 &&
                  message.codeUnitAt(i) <= 57)) {
                i++;
              }
              while ((message.codeUnitAt(i) >= 48 &&
                      message.codeUnitAt(i) <= 57) ||
                  message[i] == ',') {
                if (message[i] != ',') amount += message[i];
                i++;
              }
              break;
            }
          }
        } else if (message.contains('₹')) {
          for (int i = 0; i < message.length; i++) {
            if (message[i] == '₹') {
              while (!(message.codeUnitAt(i) >= 48 &&
                  message.codeUnitAt(i) <= 57)) {
                i++;
              }
              while ((message.codeUnitAt(i) >= 48 &&
                      message.codeUnitAt(i) <= 57) ||
                  message[i] == ',') {
                if (message[i] != ',') amount += message[i];
                i++;
              }
              break;
            }
          }
        }
        value = int.parse(amount);
      }
      return value;
    } catch (e) {
      print(e.toString());
      return 2147483647;
    }
  }

  String sms = "";
  String phone = "";
  telephony.Telephony telephon = telephony.Telephony.instance;

  void readAllSms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('phone');
    if (token == null) return; // null check added
    final response =
        await http.get(Uri.parse('${Constants.uri}/api/user?phone=$token'));

    // print(jsonDecode(response.body)['data']['last']);
    String mes = "";

    final SmsQuery query = SmsQuery();
    List<SmsMessage> messages = await query.querySms(
      kinds: [SmsQueryKind.inbox],
    );

    if (messages.isEmpty) {
      return;
    }

    if (messages.length > 1) {
      messages.sort((a, b) => (a.date?.millisecondsSinceEpoch ?? 0)
          .compareTo(b.date?.millisecondsSinceEpoch ?? 0));
    }
    List<TransactionBackend> backends = [];

    for (SmsMessage message in messages) {
      if (message.date!.millisecondsSinceEpoch >
          int.parse(jsonDecode(response.body)['data']['last'] ?? '0') + 10000) {
        // null check added
        print(int.parse(jsonDecode(response.body)['data']['last'] ??
            '0')); // null check added
        print(
            'From ${message.address} at ${message.date?.millisecondsSinceEpoch}: ${message.body}');

        int value = getTransaction(message.body.toString());
        if (value != 2147483647) {
          TransactionBackend backend = TransactionBackend(
              debit: debit,
              credit: credit,
              category: "category",
              timestamp: "timestamp",
              phone: phone);
          if (mes == "") mes = message.body as String;
          if (value > 0) {
            backend = TransactionBackend(
                debit: "0",
                credit: value.toString(),
                category: "NA",
                timestamp:
                    (message.date?.millisecondsSinceEpoch ?? 0).toString(),
                phone: phone);
            setState(() {
              // credit = (int.parse(credit) + value).toString();
              String tempLast = getTransaction(mes.toString()).toString();
              if (tempLast != "2147483647") {
                last = tempLast;
              }
            });
          } else if (value < 0) {
            backend = TransactionBackend(
                debit: (-value).toString(),
                credit: "0",
                category: "NA",
                timestamp:
                    (message.date?.millisecondsSinceEpoch ?? 0).toString(),
                phone: phone);
            setState(() {
              // debit = (int.parse(debit) - value).toString();
              String tempLast = getTransaction(mes.toString()).toString();
              if (tempLast != "2147483647") {
                last = tempLast;
              }
            });
          }
          backends.add(backend);
        }
      }
    }
    if (backends.length != 0) {
      // ignore: use_build_context_synchronously
      AuthService().postManyTransactions(context: context, backends: backends);
      getPrevHelper();
    }
  }

  void initHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('phone');
    final response =
        await http.get(Uri.parse('${Constants.uri}/api/home?phone=$token'));
    // print(response.body);
    setState(() {
      debit = jsonDecode(response.body)['debit'].toString();
      credit = jsonDecode(response.body)['credit'].toString();
      last = jsonDecode(response.body)['last'].toString();
      if (_expenseOption.contains("Today"))
        _expensesValue = double.parse(debit);
      // print(debit + ' ' + credit + ' ' + last);
    });
  }

  void getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('phone');
    setState(() {
      phone = token as String;
    });
  }

  void getSalaryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('phone');
    // ignore: use_build_context_synchronously
    var data =
        // ignore: use_build_context_synchronously
        AuthService().getSalaryData(phone: token as String, context: context);
    double lim = await data;
    // print(debit);
    setState(() {
      limit = lim;
    });
  }

  void func(var temp) async {
    print('huheue');
    Transaction gg = await temp;
    var _transactions = transactions.reversed.toList();
    _transactions.add(gg);
    setState(() {
      _transactions = _transactions.reversed.toList();
      if (_transactions.length > 10) {
        _transactions = _transactions.sublist(0, 10);
      }
      transactions = _transactions;
    });
  }

  @override
  void initState() {
    getPhone();
    telephon.listenIncomingSms(
      onNewMessage: (telephony.SmsMessage message) {
        print(message.address); //+977981******67, sender nubmer
        print(message.body); //sms text
        print(message.date); //1659690242000, timestamp
        // print("huehueheuheuheuhe");
        int value = 0;
        try {
          print(value);
          value = getTransaction(message.body.toString());
        } catch (e) {
          print(e.toString());
        }
        var temp;
        if (value != 2147483647) {
          var transaction = Transaction('',
              amount: 0, category: '', date: '', time: '', title: '');
          if (value > 0) {
            temp = AuthService().postTransaction(
                context: context,
                phone: phone,
                debit: "0",
                credit: value.toString(),
                timestamp: message.date.toString(),
                category: "NA");
            setState(() {
              credit = (int.parse(credit) + value).toString();
            });
          } else if (value < 0) {
            temp = AuthService().postTransaction(
                context: context,
                phone: phone,
                debit: (-value).toString(),
                credit: "0",
                timestamp: message.date.toString(),
                category: "NA");
            setState(() {
              debit = (int.parse(debit) - value).toString();
            });
          }
          print(temp);
          func(temp);
        }
        setState(() {
          sms = message.body.toString();
          String tempLast = value.toString();
          if (tempLast != "2147483647") {
            last = tempLast;
          }
        });
      },
      listenInBackground: false,
    );

    readAllSms();
    initHome();
    getSalaryData();
    setState(() {
      _expensesValue = double.parse(debit);
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void getWeekExpense() async {
    var week = AuthService().getWeekExpense(phone: phone, context: context);
    String value = await week;
    setState(() {
      _expensesValue = double.parse(value);
    });
  }

  void getMonthExpense() async {
    var week = AuthService().getMonthExpense(phone: phone, context: context);
    String value = await week;
    setState(() {
      _expensesValue = double.parse(value);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      //do your stuff
      getSalaryData();
      getPrevHelper();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('phone');
      final response =
          await http.get(Uri.parse('${Constants.uri}/api/user?phone=$token'));

      // print(jsonDecode(response.body)['data']['last']);
      String mes = "";
      final SmsQuery query = SmsQuery();
      List<SmsMessage> messages = await query.querySms(
        kinds: [SmsQueryKind.inbox],
      );
      messages.sort((a, b) => (a.date?.millisecondsSinceEpoch ?? 0)
          .compareTo(b.date?.millisecondsSinceEpoch ?? 0));

      List<TransactionBackend> backends = [];

      for (SmsMessage message in messages) {
        if ((message.date?.millisecondsSinceEpoch ?? 0) >
            (int.tryParse(jsonDecode(response.body)['data']['last'] ?? '0') ??
                    0) +
                10000) {
          print(int.tryParse(jsonDecode(response.body)['data']['last'] ?? '') ??
              0);
          print(
              'From ${message.address} at ${(message.date?.millisecondsSinceEpoch ?? 0)}: ${message.body}');

          int value = getTransaction(message.body.toString());
          print(value);
          if (value != 2147483647) {
            TransactionBackend backend = TransactionBackend(
                debit: debit,
                credit: credit,
                category: "category",
                timestamp: "timestamp",
                phone: phone);
            if (mes == "") mes = message.body as String;
            if (value > 0) {
              backend = TransactionBackend(
                  debit: "0",
                  credit: value.toString(),
                  category: "NA",
                  timestamp:
                      (message.date?.millisecondsSinceEpoch ?? 0).toString(),
                  phone: phone);
              setState(() {
                String tempLast = getTransaction(mes.toString()).toString();
                if (tempLast != "2147483647") {
                  last = tempLast;
                }
              });
            } else if (value < 0) {
              backend = TransactionBackend(
                  debit: (-value).toString(),
                  credit: "0",
                  category: "NA",
                  timestamp:
                      (message.date?.millisecondsSinceEpoch ?? 0).toString(),
                  phone: phone);
              setState(() {
                String tempLast = getTransaction(mes.toString()).toString();
                if (tempLast != "2147483647") {
                  last = tempLast;
                }
              });
            }
            backends.add(backend);
          }
        }
      }
      if (backends.length != 0) {
        // ignore: use_build_context_synchronously
        AuthService()
            .postManyTransactions(context: context, backends: backends);
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    // debitController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void openTransactionPopup(
      int amount, String category, String date, String time, String _id) async {
    List<String> dateParts = date.split('/');
    int month = int.parse(dateParts[0]);
    int day = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    bool flag = true;
    var selectedDate = DateTime(
      year,
      month,
      day,
    );
    int hour = int.parse(time) ~/ 3600;
    int minute = (int.parse(time) % 3600) ~/ 60;
    DateTime timeIn = DateTime(year, month, day, hour, minute);
    var tt = context;
    final result = await showDialog(
      context: context,
      builder: (context) {
        // Create a new transaction object to store the user's input
        Transaction transaction = Transaction(_id,
            amount: amount,
            date: date,
            title: 'debited',
            category: category,
            time: time);

        // Create controllers for the text input fields
        final debitController = TextEditingController();
        final creditController = TextEditingController();
        final categoryController = TextEditingController();
        print(amount);
        if (amount > 0) {
          creditController.text = amount.toString();
          debitController.text = "0";
        } else {
          debitController.text = (-amount).toString();
          creditController.text = "0";
        }

        categoryController.text = category;

        // Define a function to handle the submit button
        void handleSubmit() {
          if (flag) {
            AuthService().editTransaction(_id,
                context: tt,
                debit: debitController.text,
                credit: creditController.text,
                timestamp: timeIn.millisecondsSinceEpoch.toString(),
                category: categoryController.text,
                phone: phone);
            int index =
                transactions.indexWhere((element) => element._id == _id);
            print(index);
            if (debitController.text != "0") {
              print(debitController.text);
              setState(() {
                transactions[index] = Transaction(_id,
                    title: "Debited",
                    amount: -int.parse(debitController.text),
                    date: "${timeIn.month}/${timeIn.day}/${timeIn.year}",
                    category: categoryController.text,
                    time: (timeIn.hour * 3600 + timeIn.minute * 60).toString());
              });
            } else {
              setState(() {
                transactions[index] = Transaction(_id,
                    title: "Credited",
                    amount: int.parse(creditController.text),
                    date: "${timeIn.month}/${timeIn.day}/${timeIn.year}",
                    category: categoryController.text,
                    time: (timeIn.hour * 3600 + timeIn.minute * 60).toString());
              });
            }
          }
          Navigator.of(context).pop(transaction);
        }

        // Define a function to handle the date picker
        void handleDatePick(DateTime date) {
          setState(() {
            flag = true;
            selectedDate = date;
          });
        }

        // Return the popup view
        return AlertDialog(
          title: const Text('Edit Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Debit input field
              TextFormField(
                controller: debitController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Debit',
                ),
              ),

              // Credit input field
              TextFormField(
                controller: creditController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Credit',
                ),
              ),

              // Category input field
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
              ),

              // Date picker
              const SizedBox(height: 16),
              // Text("Date: ${DateFormat.yMMMd().format(selectedDate)}"),
              ElevatedButton(
                child: const Text('Select date'),
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      final DateTime selectedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      timeIn = selectedDateTime;
                      handleDatePick(selectedDateTime);
                    }
                  }
                },
              ),
            ],
          ),
          actions: [
            // Cancel button
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            // Submit button
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: handleSubmit,
            ),
          ],
        );
      },
    );

    // If the user submitted a transaction, add it to the list
    if (result != null) {
      setState(() {
        // transactions.add(result);
      });
    }
  }

  void openMenu(BuildContext context) async {
    final result = await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(0, kToolbarHeight, 0, 0),
      items: [
        PopupMenuItem(
          child: const Text('Edit Profile'),
          onTap: () {
            // Handle Edit Profile action here.
          },
        ),
        PopupMenuItem(
          child: const Text('Edit Salary'),
          onTap: () {
            // Handle Edit Salary action here.
          },
        ),
        PopupMenuItem(
          child: const Text('Calendar'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Material(child: CalendarScreen())),
            );
          },
        ),
        PopupMenuItem(
          child: const Text('Logout'),
          onTap: () {
            // Handle Logout action here.
          },
        ),
      ],
    );
  }

  void prin() {
    for (int i = 0; i < transactions.length; i++) {
      print(transactions[i].title + ' ' + transactions[i].amount.toString());
    }
  }

  void getPrevHelper() async {
    List<Transaction> _transactions =
        await const HomeScreen().getPrevTransactions(context);
    print('${_transactions[0].title} ${_transactions[0].amount}');
    setState(() {
      transactions = _transactions;
    });
  }

  var flag = false;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user;
    final dataMap = <String, double>{
      "Today's Expenses": double.parse(debit),
      "Today's Limit": limit,
    };
    initHome();
    if (transactions.length == 0) {
      getPrevHelper();
    }
    num fem; // fem local variable is created
    return Scaffold(
      //here we need to implement
    body: Container(
          width: 412,
          height: 877,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xff2b7a78), width: 1.50, ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(bottom: 31, ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Transform.rotate(
                angle: -1.57,
                child: Container(
                  width: 341,
                  height: 363,
                  padding: const EdgeInsets.only(left: 64, top: 98, ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:[
                      Transform.rotate(
                        angle: -1.57,
                        child: Container(
                          width: 162.22,
                          height: 120.50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 1, ),
                            color: const Color(0xff2b7a78),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2630.30),
                      Transform.rotate(
                        angle: -1.57,
                        child: Container(
                          width: 220.14,
                          height: 225.89,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 1, ),
                            color: const Color(0xff3aafa9),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2630.30),
                      Container(
                        width: double.infinity,
                        height: 341,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 508.10),
              Container(
                width: double.infinity,
                height: 476,
                color: const Color(0x35a6bbf2),
                child: Stack(
                  children:[
                    Positioned(
                      left: 78,
                      top: 124,
                      child: Container(
                        width: 340,
                        height: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0x7f000000), width: 1, ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: const Color(0xffdef2f1),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 333,
                      top: 144,
                      child: SizedBox(
                        width: 71,
                        child: Text(
                          "Rs 158",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 59,
                      top: 33,
                      child: Container(
                        width: 37,
                        height: 33,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const FlutterLogo(size: 33),
                      ),
                    ),
                    Positioned(
                      left: 370,
                      top: 26,
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
              ),
              const SizedBox(height: 508.10),
              Container(
                width: 412,
                height: 19,
                padding: const EdgeInsets.only(left: 16, right: 206, top: 2, ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    SizedBox(
                      width: 189.99,
                      child: Text(
                        "Previous Transactions",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 508.10),
              const SizedBox(
                width: 290,
                height: 51,
                child: Text(
                  "Today’s expense: Rs 233",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 508.10),
              Container(
                width: 393.87,
                height: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                      BoxShadow(
                      color: Color(0x0f000000),
                      blurRadius: 48,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: const Color(0xffdef2f1),
                ),
                child: Stack(
                  children:[
                    const Positioned(
                      left: 333,
                      top: 18,
                      child: SizedBox(
                        width: 53.06,
                        child: Text(
                          "Rs 18",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 71,
                      top: 42,
                      child: SizedBox(
                        width: 130,
                        child: Text(
                          "28 Sept 2022",
                          style: TextStyle(
                            color: Color(0xff7c8894),
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 70,
                      top: 21,
                      child: SizedBox(
                        width: 205,
                        child: Text(
                          "UPI tranfer through SBI",
                          style: TextStyle(
                            color: Color(0xff17252a),
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 369,
                      top: 42,
                      child: Container(
                        width: 19,
                        height: 17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const FlutterLogo(size: 17),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 508.10),
              const SizedBox(
                width: 290,
                height: 51,
                child: Text(
                  "Today’s expense: Rs 233",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 508.10),
              Container(
                width: 393.87,
                height: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0f000000),
                      blurRadius: 48,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: const Color(0xffdef2f1),
                ),
                child: Stack(
                  children:[
                    const Positioned(
                      left: 333,
                      top: 18,
                      child: SizedBox(
                        width: 53.06,
                        child: Text(
                          "Rs 18",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 71,
                      top: 42,
                      child: SizedBox(
                        width: 130,
                        child: Text(
                          "28 Sept 2022",
                          style: TextStyle(
                            color: Color(0xff7c8894),
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 70,
                      top: 21,
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          "UPI tranfer through SBI",
                          style: TextStyle(
                            color: Color(0xff17252a),
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 369,
                      top: 42,
                      child: Container(
                        width: 19,
                        height: 17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const FlutterLogo(size: 17),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 508.10),
              const SizedBox(
                width: 290,
                height: 51,
                child: Text(
                  "Today’s expense: Rs 233",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 508.10),
              Container(
                width: 393.87,
                height: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0f000000),
                      blurRadius: 48,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: const Color(0xffdef2f1),
                ),
                child: Stack(
                  children:[
                    const Positioned(
                      left: 333,
                      top: 18,
                      child: SizedBox(
                        width: 53.06,
                        child: Text(
                          "Rs 18",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 71,
                      top: 42,
                      child: SizedBox(
                        width: 104,
                        child: Text(
                          "28 Sept 2022",
                          style: TextStyle(
                            color: Color(0xff7c8894),
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 70,
                      top: 21,
                      child: SizedBox(
                        width: 210,
                        child: Text(
                          "UPI tranfer through SBI",
                          style: TextStyle(
                            color: Color(0xff17252a),
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 369,
                      top: 42,
                      child: Container(
                        width: 19,
                        height: 17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const FlutterLogo(size: 17),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 508.10),
              const SizedBox(
                width: 290,
                height: 51,
                child: Text(
                  "Today’s expense: Rs 233",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 508.10),
              Container(
                width: 393.87,
                height: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0f000000),
                      blurRadius: 48,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: const Color(0xffdef2f1),
                ),
                child: Stack(
                  children:[
                    const Positioned(
                      left: 333,
                      top: 18,
                      child: SizedBox(
                        width: 53.06,
                        child: Text(
                          "Rs 18",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff2b7a78),
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 71,
                      top: 42,
                      child: SizedBox(
                        width: 104,
                        child: Text(
                          "28 Sept 2022",
                          style: TextStyle(
                            color: Color(0xff7c8894),
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 70,
                      top: 21,
                      child: SizedBox(
                        width: 187,
                        child: Text(
                          "UPI tranfer through SBI",
                          style: TextStyle(
                            color: Color(0xff17252a),
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 369,
                      top: 42,
                      child: Container(
                        width: 19,
                        height: 17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const FlutterLogo(size: 17),
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

class Transaction {
  String title;
  int amount;
  String date;
  String category;
  String _id;
  String time;
  Transaction(this._id,
      {required this.title,
      required this.amount,
      required this.date,
      required this.category,
      required this.time});

  set id(String id) {
    _id = id;
  }
}

class TransactionBackend {
  final String debit;
  final String credit;
  final String category;
  final String timestamp;
  final String phone;
  TransactionBackend({
    required this.debit,
    required this.credit,
    required this.category,
    required this.timestamp,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'debit': debit,
      'credit': credit,
      'category': category,
      'timestamp': timestamp,
      'phone': phone,
    };
  }

  factory TransactionBackend.fromMap(Map<String, dynamic> map) {
    return TransactionBackend(
      debit: map['debit'] as String,
      credit: map['credit'] as String,
      category: map['category'] as String,
      timestamp: map['timestamp'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionBackend.fromJson(String source) =>
      TransactionBackend.fromMap(json.decode(source) as Map<String, dynamic>);
}
