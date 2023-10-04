import "package:calculator/colors.dart";
import "package:flutter/material.dart";
import "package:math_expressions/math_expressions.dart";

void main() {
  runApp(const MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("X", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? "" : input,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              CustomButton(
                text: "AC",
                backgroundColor: operatorColor,
                textColor: blueColor,
                onPressed: () => onButtonClick("AC"),
              ),
              CustomButton(
                text: "C",
                backgroundColor: operatorColor,
                textColor: blueColor,
                onPressed: () => onButtonClick("C"),
              ),
              CustomButton(
                text: "",
                backgroundColor: Colors.black,
                textColor: Colors.black,
                onPressed: () => onButtonClick(""),
              ),
              CustomButton(
                text: "/",
                backgroundColor: operatorColor,
                textColor: blueColor,
                onPressed: () => onButtonClick("/"),
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                text: "7",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("7"),
              ),
              CustomButton(
                text: "8",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("8"),
              ),
              CustomButton(
                text: "9",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("9"),
              ),
              CustomButton(
                text: "X",
                backgroundColor: operatorColor,
                textColor: blueColor,
                onPressed: () => onButtonClick("X"),
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                text: "4",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("4"),
              ),
              CustomButton(
                text: "5",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("5"),
              ),
              CustomButton(
                text: "6",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("6"),
              ),
              CustomButton(
                text: "-",
                backgroundColor: operatorColor,
                textColor: blueColor,
                onPressed: () => onButtonClick("-"),
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                text: "1",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("1"),
              ),
              CustomButton(
                text: "2",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("2"),
              ),
              CustomButton(
                text: "3",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("3"),
              ),
              CustomButton(
                text: "+",
                backgroundColor: operatorColor,
                textColor: blueColor,
                onPressed: () => onButtonClick("+"),
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                text: "%",
                backgroundColor: operatorColor,
                textColor: blueColor,
                onPressed: () => onButtonClick("%"),
              ),
              CustomButton(
                text: "0",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("0"),
              ),
              CustomButton(
                text: ".",
                backgroundColor: buttonColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("."),
              ),
              CustomButton(
                text: "=",
                backgroundColor: blueColor,
                textColor: Colors.white,
                onPressed: () => onButtonClick("="),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const CustomButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(22),
            backgroundColor: backgroundColor,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
