import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

var equation = [];
var result = 0.0;
var solution = "";

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  solution,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: Colors.grey, thickness: 2),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  ...getTextCustomRow(
                    "AC",
                    Colors.blueGrey,
                    Colors.lightBlueAccent,
                  ),
                  ...getTextCustomRow(
                    "x",
                    Colors.blueGrey,
                    Colors.lightBlueAccent,
                  ),
                  ...getTextCustomRow(
                    "+/-",
                    Colors.blueGrey,
                    Colors.lightBlueAccent,
                  ),
                  ...getTextCustomRow(
                    "/",
                    Colors.blueGrey,
                    Colors.lightBlueAccent,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ...getTextNumberRow(1, Colors.grey),
                  ...getTextCustomRow(
                    "X",
                    Colors.blueGrey,
                    Colors.lightBlueAccent,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ...getTextNumberRow(4, Colors.grey),
                  ...getTextCustomRow(
                    "-",
                    Colors.blueGrey,
                    Colors.lightBlueAccent,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ...getTextNumberRow(7, Colors.grey),
                  ...getTextCustomRow(
                    "+",
                    Colors.blueGrey,
                    Colors.lightBlueAccent,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ...getTextCustomRow("%", Colors.grey, Colors.white),
                  ...getTextCustomRow("0", Colors.grey, Colors.white),
                  ...getTextCustomRow(".", Colors.grey, Colors.white),
                  ...getTextCustomRow("=", Colors.lightBlue, Colors.black)
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getTextNumberRow(iVal, buttonColor) {
    List<Widget> childs = [];
    for (var i = iVal; i < iVal + 3; i++) {
      if (!i.isNegative) {
        childs.add(Center(
          child: Row(children: [
            ElevatedButton(
              onPressed: (() => {
                    setState(() {
                      solution = solution + i.toString();
                    }),
                    print(solution),
                    solveEquations(),
                  }),
              style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  minimumSize: const Size(70, 50)),
              child: Text(
                "$i",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 25)
          ]),
        ));
      }
    }

    return childs;
  }

  List<Widget> getTextCustomRow(buttonVal, buttonBGcolor, buttonFGcolor) {
    List<Widget> childs = [];
    for (var i = 0; i < 1; i++) {
      childs.add(
        Row(
          children: [
            ElevatedButton(
              onPressed: (() => {
                    if (buttonVal == "AC")
                      {
                        setState(() {
                          solution = "";
                        })
                      }
                    else if (buttonVal == "=")
                      {
                        setState(() {
                          solution = result.toString();
                        })
                      }
                    else if (buttonVal == "X")
                      {
                        setState(() {
                          solution = solution + '*';
                        })
                      }
                    else if (buttonVal == "x")
                      {
                        setState(() {
                          solution = solution.substring(0, solution.length - 1);
                        })
                      }
                    else
                      {
                        setState(() {
                          solution = solution + buttonVal;
                        }),
                        print(solution),
                        solveEquations(),
                      }
                  }),
              style: ElevatedButton.styleFrom(
                  primary: buttonBGcolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  minimumSize: const Size(70, 50)),
              child: Text(
                "$buttonVal",
                style: TextStyle(
                  color: buttonFGcolor,
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 25)
          ],
        ),
      );
    }

    return childs;
  }

  solveEquations() async {
    ContextModel cm = ContextModel();
    print("solution = $solution");
    Expression exp = Parser().parse(solution);
    result = exp.evaluate(EvaluationType.REAL, cm);
    return result;
  }
}
