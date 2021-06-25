// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final options = [
    "AC",
    "%",
    "*",
    "/",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "=",
    "0",
    "."
  ];

  var operation = "";
  var result = 0.0;
  var a;
  var b;
  var currentOp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe3dfdc),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            isDisplay(
              operation: operation,
              key: null,
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: StaggeredGridView.countBuilder(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 4,
                      itemCount: 18,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          final op = options[index];
                          if (options[index] == '=') {
                            operation = separatesFunctionIntoSmallerFunctions(
                                operation, '*', '/');
                            operation = separatesFunctionIntoSmallerFunctions(
                                operation, '-', '+');
                          } else {
                            operation += options[index];
                          }

                          switch (op) {
                            case "AC":
                              {
                                a = null;
                                b = null;
                                result = 0.0;
                                operation = "";
                                break;
                              }
                            case "+":
                              {
                                currentOp = op;
                                break;
                              }
                            case "-":
                              {
                                currentOp = op;
                                break;
                              }
                            case "*":
                              {
                                currentOp = op;
                                break;
                              }
                            case "/":
                              {
                                currentOp = op;
                                break;
                              }
                            case "=":
                              {
                                break;
                              }
                          }

                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: index == 15
                                        ? Color(0xFFe29743)
                                        : Color(0xFFe3dfdc),
                                  ),
                                  child: Center(
                                    child: Text(
                                      options[index],
                                      style: TextStyle(
                                          color: Color(0xFFa45228),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 28),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      staggeredTileBuilder: (int index) {
                        if (index == 15) {
                          return StaggeredTile.count(1, 2);
                        } else if (index == 16) {
                          return StaggeredTile.count(2, 1);
                        } else {
                          return StaggeredTile.count(1, 1);
                        }
                      },
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

separatesFunctionIntoSmallerFunctions(text, op1, op2) {
  final onlyNumbers = RegExp('[0-9]');
  bool findOperator = false;
  bool keepLooking = true;

  while (keepLooking) {
    keepLooking = false;
    String operation = '';
    String operator = '';
    for (int i = 0; i < text.length; i++) {
      if ((text[i] == op1 || text[i] == op2) && !findOperator) {
        operation += text[i];
        keepLooking = true;
        findOperator = true;
        if (text[i] == op1) operator = op1;
        if (text[i] == op2) operator = op2;
      } else if (onlyNumbers.hasMatch(text[i])) {
        operation += text[i];
        if (findOperator &&
            ((i + 1 == text.length) || !onlyNumbers.hasMatch(text[i + 1]))) {
          text = text.replaceAll(
              operation, calculateString(operation, operator).toString());
          operation = '';
          findOperator = false;
          break;
        }
      } else {
        operation = "";
      }
    }
  }
  return text;
}

calculateString(text, op) {
  List<String> textArray = [];
  if (op == '*') {
    textArray = text.split(op);
    return int.parse(textArray[0]) * int.parse(textArray[1]);
  } else if (op == '/') {
    textArray = text.split(op);
    return int.parse(textArray[0]) / int.parse(textArray[1]);
  } else if (op == '+') {
    textArray = text.split(op);
    return int.parse(textArray[0]) + int.parse(textArray[1]);
  } else if (op == '-') {
    textArray = text.split(op);
    return int.parse(textArray[0]) - int.parse(textArray[1]);
  }
}
