class Btn {
  // Define constants for button types and their associated values
  static const String del = "D";          // Delete
  static const String clr = "C";          // Clear
  static const String per = "%";          // Percentage
  static const String multiply = "×";    // Multiplication
  static const String divide = "÷";      // Division
  static const String add = "+";          // Addition
  static const String subtract = "-";     // Subtraction
  static const String calculate = "=";    // Equals
  static const String dot = ".";          // Decimal point

  static const String n0 = "0";           // Digit 0
  static const String n1 = "1";           // Digit 1
  static const String n2 = "2";           // Digit 2
  static const String n3 = "3";           // Digit 3
  static const String n4 = "4";           // Digit 4
  static const String n5 = "5";           // Digit 5
  static const String n6 = "6";           // Digit 6
  static const String n7 = "7";           // Digit 7
  static const String n8 = "8";           // Digit 8
  static const String n9 = "9";           // Digit 9
  static const String n10 = "00";         // Double zero

  // Create a list that defines the order of button values
  static const List<String> buttonValues = [
    del,
    clr,
    per,
    multiply,
    n7,
    n8,
    n9,
    divide,
    n4,
    n5,
    n6,
    subtract,
    n1,
    n2,
    n3,
    add,
    n0,
    n10,
    dot,
    calculate,
  ];
}
