// ignore_for_file: library_private_types_in_public_api

import 'package:calculator/extensions/cut_dot_ext.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'my_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '0';

  // Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: const TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
            Expanded(
              flex: 7,
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50]!,
                        textColor: Colors.black,
                      );
                    }
      
                    // +/- button
                    else if (index == 1) {
                      return MyButton(
                        buttontapped: () {
                          if (double.parse(answer) > 0) {
                            setState(() {
                              answer = (double.parse(answer) / -1).toString().cutDot();
                            });
                          } else if (double.parse(answer) < 0) {
                            setState(() {
                              answer = (double.parse(answer) / -1).toString().cutDot();
                            });
                          }else if(userInput.isEmpty && answer == '0' || answer == '-0.0' || answer == '0.0'){
                            setState(() {
                              answer = (double.parse(answer) / -1).toString().cutDot();
                            });
                          } else if (double.parse(userInput) > 0 && answer== '0' && checkOperator(userInput)) {
                            setState(() {
                              answer = (double.parse(userInput) / -1).toString().cutDot();
                            });
                          }
                          else if (double.parse(userInput) < 0 && answer == '0' && checkOperator(userInput)) {
                            setState(() {
                              answer = (double.parse(userInput) / -1).toString().cutDot();
                            });
                          }
                         
                          
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50]!,
                        textColor: Colors.black,
                      );
                    }
                    // % Button
                    else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          if (!userInput.contains('%')) {
                            setState(() {
                              userInput += buttons[index];
                            });
                          }
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50]!,
                        textColor: Colors.black,
                      );
                    }
                    // Delete Button
                    else if (index == 3) {
                      return MyButton(
                        buttontapped: () {
                          if (userInput.isNotEmpty) {
                            setState(() {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            });
                          }
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50]!,
                        textColor: Colors.black,
                      );
                    }
                    // Equal_to Button
                    else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[700]!,
                        textColor: Colors.white,
                      );
                    }
                    //  other buttons
                    else {
                      return MyButton(
                        buttontapped: () {
                          if (checkOperator(buttons[index]) && buttons[index] != '.') {
                            setState(() {
                            userInput += buttons[index];
                          });
                          }
                          else if(userInput.isNotEmpty){ setState(() {
                            userInput += buttons[index];
                          });}
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  bool checkOperator(String txt){
    for (var i = 0; i < txt.length; i++) {
      if (txt[i]=='+' || txt[i]=='-' || txt[i]=='/' || txt[i]=='x') {
        return false;
      }
    }
    return true;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString().cutDot();
  }
}
