import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_services.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String phone = "";
  void getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('phone');
    setState(() {
      phone = token as String;
    });
  }

  @override
  void initState() {
    getPhone();
  }

  DateTime _currentDate = DateTime.now();
  List<Transaction> transactions = [];

  void openTransactionPopup(int amount, String category, String date,
      String time, String _id) async {
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
              setState(() {
                transactions[index] = Transaction(_id,
                    title: "Debited",
                    amount: int.parse(debitController.text),
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
          title: Text('Edit Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Debit input field
              TextFormField(
                controller: debitController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Debit',
                ),
              ),

              // Credit input field
              TextFormField(
                controller: creditController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Credit',
                ),
              ),

              // Category input field
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
              ),

              // Date picker
              SizedBox(height: 16),
              // Text("Date: ${DateFormat.yMMMd().format(selectedDate)}"),
              ElevatedButton(
                child: Text('Select date'),
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            // Submit button
            ElevatedButton(
              child: Text('Submit'),
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

  void getCalendar(String date) async {
    var data =
        AuthService().getCalendar(phone: phone, date: date, context: context);
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
    print(_transactions);
    setState(() {
      transactions = _transactions;
    });
  }

  @override //I need to change from here
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

class Transaction {
  final String title;
  final int amount;
  final String date;
  final String category;
  final String _id;
  final String time;
  Transaction(this._id,
      {required this.title,
      required this.amount,
      required this.date,
      required this.category,
      required this.time});
}
