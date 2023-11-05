import 'package:calculator/button_values.dart'; // Import the button values from an external file.
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key}); // Constructor for CalculatorScreen.

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState(); // Create a state for the CalculatorScreen.
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Define state variables to store the numbers and operands.
  String number1 = ""; // First Number . or 0-9
  String number2 = ""; // Second Number . or 0-9
  String operand = ""; // +-*/

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Output Display
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "$number1 $operand $number2".isEmpty ? "0" : "$number1 $operand $number2",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            // Buttons
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                        width: screenSize.width / 4,
                        height: screenSize.width / 5,
                        child: buildButtton(value)),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  // Build Button
  Widget buildButtton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
              child: Text(value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ))),
        ),
      ),
    );
  }

  // Handle button tap events
 void onBtnTap(String value) {
  if (value == Btn.del) {
    delete(); // Call the delete function if the "D" button is tapped.
    return;
  }

   if (value == Btn.clr) {
      number1 = "";
      number2 = "";
      operand = "";
      setState(() {});
      return;
    }

  if (value == Btn.per) {
    convertToPercentage(); // Call the convertToPercentage function if the "%" button is tapped.
    return;
  }

  if (value == Btn.calculate) {
    calculate(); // Call the calculate function if the "=" button is tapped.
    return;
  }

  appendValue(value); // Call the appendValue function for other button taps.
}

// Calculate the result
void calculate() {
  if (number1.isEmpty || operand.isEmpty || number2.isEmpty) {
    return; // Return if the input is not complete.
  }
  if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
    final num1 = double.parse(number1);
    final num2 = double.parse(number2);
    switch (operand) {
      case Btn.add:
        number1 = "${num1 + num2}"; // Perform addition.
        break;
      case Btn.subtract:
        number1 = "${num1 - num2}"; // Perform subtraction.
        break;
      case Btn.multiply:
        number1 = "${num1 * num2}"; // Perform multiplication.
        break;
      case Btn.divide:
        number1 = "${num1 / num2}"; // Perform division.
        break;
    }

    setState(() {
      number1 = number1.endsWith(".0")
          ? number1.substring(0, number1.length - 2)
          : number1; // Remove trailing ".0" if present.
      number2 = "";
      operand = "";
    });
  }
}

// Convert to percentage
void convertToPercentage() {
  if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
    calculate(); // Calculate the result if there is an equation to be solved.
  }

  if (operand.isNotEmpty) {
    return; // Cannot convert to percentage when there is an operand.
  }

  final number = double.parse(number1);
  setState(() {
    number1 = "${number / 100}"; // Convert the number to a percentage.
    operand = "";
    number2 = "";
  });
}

// Delete characters
void delete() {
  if (number2.isNotEmpty) {
    number2 = number2.substring(0, number2.length - 1); // Delete the last character in the second number.
  } else if (operand.isNotEmpty) {
    operand = ""; // Clear the operand.
  } else if (number1.isNotEmpty) {
    number1 = number1.substring(0, number1.length - 1); // Delete the last character in the first number.
  }
  setState(() {}); // Update the UI to reflect the changes.
}

// Append value to numbers
void appendValue(String value) {
  if (value != Btn.dot && int.tryParse(value) == null) {
    if (operand.isNotEmpty && number2.isNotEmpty) {
      calculate(); // Calculate the equation before assigning a new value.
    }
    operand = value;
  } else if (number1.isEmpty || operand.isEmpty) {
    if (value == Btn.dot && number1.contains(Btn.dot)) {
      return; // Avoid multiple decimal points in the first number.
    }
    if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
      value = "0."; // Handle adding a decimal point to an empty or zero number.
    }
    number1 += value;
  } else if (number2.isEmpty || operand.isNotEmpty) {
    if (value == Btn.dot && number2.contains(Btn.dot)) {
      return; // Avoid multiple decimal points in the second number.
    }
    if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
      value = "0."; // Handle adding a decimal point to an empty or zero number.
    }
    number2 += value;
  }
  setState(() {}); // Update the UI to reflect the changes.
}

  // Determine the button color based on its type
  Color getBtnColor(value) {
    if ([Btn.del, Btn.clr].contains(value)) {
      return Colors.blueGrey;
    } else if ([
      Btn.per,
      Btn.multiply,
      Btn.divide,
      Btn.add,
      Btn.subtract,
      Btn.calculate
    ].contains(value)) {
      return Colors.orange;
    } else {
      return Colors.grey;
    }
  }
}
