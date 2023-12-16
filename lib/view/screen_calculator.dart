import 'package:calculator/utils/responsive_units.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class ScreenCalculator extends StatefulWidget {
  const ScreenCalculator({super.key});

  @override
  State<ScreenCalculator> createState() => _ScreenCalculatorState();
}

class _ScreenCalculatorState extends State<ScreenCalculator> {
  final List<String> btnList = [
    'AC',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '00',
    '.',
    '='
  ];
  String input = '';
  String output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth(0.02),
            vertical: context.screenWidth(0.04),
          ),
          child: Column(
            children: [
              // display details section
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: context.screenHeight(0.04),
                  horizontal: context.screenWidth(0.04),
                ),
                width: context.screenWidth(1),
                height: context.screenHeight(0.25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // output screen
                    Text(
                      output == '' ? '0' : output,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: context.screenHeight(0.08),
                        height: 0,
                      ),
                    ),
                    // input scree
                    Text(
                      input == '' ? '0' : input,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: context.screenHeight(0.04),
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              // space
              SizedBox(
                height: context.screenHeight(0.03),
              ),
              //button section
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: context.screenWidth(0.02),
                    mainAxisSpacing: context.screenWidth(0.02),
                  ),
                  itemCount: btnList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CalculatorButton(
                      btnText: btnList[index],
                      onTap: () => butonPressed(btnList[index]),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  butonPressed(String value) {
    setState(() {
      if (value == 'DEL') {
        // removing last element
        input = input.substring(0, input.length - 1);
      } else if (value == 'AC') {
        // clearing all element
        input = '';
        output = '';
      } else if (value == '=') {
        // evaluation
        try {
          Parser pr = Parser();
          Expression exp = pr.parse(input);

          ContextModel cm = ContextModel();
          output = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          input = e.toString();
        }
        input = '';
      } else {
        // adding values
        input += value;
      }
    });
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.btnText,
    required this.onTap,
  });

  final String btnText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // change background color
          color: (btnText == '='
              ? Colors.blue
              : btnText == 'DEL' || btnText == 'AC'
                  ? Colors.red
                  : Colors.white),
          borderRadius: BorderRadius.circular(
            context.screenWidth(0.05),
          ),
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: context.screenHeight(0.04),
              // change text color
              color: (btnText == '=' || btnText == 'DEL' || btnText == 'AC'
                  ? Colors.white
                  : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
