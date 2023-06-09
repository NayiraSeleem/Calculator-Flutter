import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String text = '0';
  double numOne = 0;
  double numTwo = 0;

  String result = '0';
  String finalResult = '0';

  String opr = '';
  String preOpr = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('C', Color(0xffa5a5a5), 1),
                button('+/-', Color.fromRGBO(165, 165, 165, 1), 1),
                button('%', Color(0xffa5a5a5), 1),
                button('/', Color(0xffff9800), 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('7', Color(0xff323232), 1),
                button('8', Color(0xff323232), 1),
                button('9', Color(0xff323232), 1),
                button('X', Color(0xffff9800), 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('4', Color(0xff323232), 1),
                button('5', Color(0xff323232), 1),
                button('6', Color(0xff323232), 1),
                button('-', Color(0xffff9800), 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('3', Color(0xff323232), 1),
                button('2', Color(0xff323232), 1),
                button('1', Color(0xff323232), 1),
                button('+', Color(0xffff9800), 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('0', Color(0xff323232), 0),
                button('.', Color(0xff323232), 1),
                button('=', Color(0xffff9800), 1),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(String btnTxt, Color color, int num) {
    Container container;
    if (num == 0) {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            calculate(btnTxt);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(color),
              padding: MaterialStateProperty.all(
                  EdgeInsets.only(left: 81, top: 20, right: 81, bottom: 20)),
              shape: MaterialStateProperty.all(StadiumBorder())),
          child: Text(
            btnTxt,
            style: TextStyle(fontSize: 30),
          ),
        ),
      );
    } else {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            calculate(btnTxt);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(color),
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
              shape: MaterialStateProperty.all(CircleBorder())),
          child: Text(
            btnTxt,
            style: TextStyle(fontSize: 30),
          ),
        ),
      );
    }
    return container;
  }

  void calculate(txtBtn) {
    if (txtBtn == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && txtBtn == '=') {
      switch (preOpr) {
        case '+':
          finalResult = add();
          break;

        case '-':
          finalResult = sub();
          break;

        case 'X':
          finalResult = mul();
          break;

        case '/':
          finalResult = div();
          break;
      }
    } else if (txtBtn == '+' ||
        txtBtn == '-' ||
        txtBtn == 'X' ||
        txtBtn == '/' ||
        txtBtn == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
      switch (opr) {
        case '+':
          finalResult = add();
          break;

        case '-':
          finalResult = sub();
          break;

        case 'X':
          finalResult = mul();
          break;

        case '/':
          finalResult = div();
          break;
      }
      preOpr = opr;
      opr = txtBtn;
      result = '';
    } else if (txtBtn == '%') {
      result = (numOne / 100).toString();
      finalResult = result;
    } else if (txtBtn == '.') {
      if (!result.contains('.')) result += '.';
      finalResult = result;
    } else if (txtBtn == '+/-') {
      result.startsWith('-')
          ? result = result.substring(1)
          : result = '-' + result;
      finalResult = result;
    } else {
      if (result == '0')
        result = txtBtn;
      else
        result = result + txtBtn;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return result;
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return result;
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return result;
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return result;
  }

  String decimalRemove(String _result) {
    if (_result.contains('.')) {
      List<String> split = _result.split('.');
      if (!(int.parse(split[1]) > 0)) return split[0];
    }
    return _result;
  }
}
