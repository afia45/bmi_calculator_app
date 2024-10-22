import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
//import 'package:fluttericon/font_awesome_icons.dart';

class ResultScreen extends StatefulWidget {
  final double bmi;
  final int age;
  final String gender;

  ResultScreen({required this.bmi, required this.age, required this.gender});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String bmiCategory;
  late Color bmiColor;

  @override
  void initState() {
    super.initState();
    // Initialize category and color when the screen is first built
    _updateBMICategoryAndColor();
  }

  void _updateBMICategoryAndColor() {
    bmiCategory = getBMICategory();
    bmiColor = getBMIColor();
  }

  String getBMICategory() {
    if (widget.age < 18) {
      return "BMI is not intended for children and teenagers.";
    } else if (widget.gender == "Male") {
      if (widget.bmi < 18.5) return "Underweight";
      if (widget.bmi < 24.9) return "Normal";
      if (widget.bmi < 29.9) return "Overweight";
      return "Obese";
    } else if (widget.gender == "Female") {
      if (widget.bmi < 18.5) return "Underweight";
      if (widget.bmi < 24.5) return "Normal";
      if (widget.bmi < 29.5) return "Overweight";
      return "Obese";
    } else {
      return "Invalid Gender";
    }
  }

  Color getBMIColor() {
    if (widget.bmi < 18.5) {
      return Colors.blue; // Underweight
    } else if (widget.bmi < 24.9) {
      return Colors.green; // Normal
    } else if (widget.bmi < 29.9) {
      return Colors.orange; // Overweight
    } else {
      return Colors.red; // Obese
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthFactor = (widget.bmi / 40)
        .clamp(0.0, 1.0); // Scale BMI in relation to the max of 40
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 245),
      appBar: AppBar(centerTitle:true, title: Text("BMI Result"),
      titleTextStyle: TextStyle(color: Color.fromARGB(255, 255, 245, 245), fontSize: 28, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 185, 1, 1),
        ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/heart.png', // Path to the asset image
              width: 60, // Set width and height according to your needs
              height: 60,
            ),
            SizedBox(height: 10),
            Text(
              'Your BMI is:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              widget.bmi.toStringAsFixed(1),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            
            Text(
              bmiCategory,
              style: TextStyle(
                fontSize: 32,
                color: bmiColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('15', style: TextStyle(fontSize: 16)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * (18.5 / 40)),
                    child: Text('18.5', style: TextStyle(fontSize: 16)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * (24.9 / 40)),
                    child: Text('25', style: TextStyle(fontSize: 16)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * (29.9 / 40)),
                    child: Text('30', style: TextStyle(fontSize: 16)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 0), // Right aligned for the last label
                    child: Text('40', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                // BMI Bar Background
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                  ),
                ),
                // Segment 1: Underweight
                Positioned(
                  left: 0,
                  child: Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width *
                        (18.5 / 40), // up to BMI 18.5
                    decoration: BoxDecoration(
                      color: Colors.blue, // Underweight color
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(10)),
                    ),
                  ),
                ),

                // Segment 2: Normal weight
                Positioned(
                  left: MediaQuery.of(context).size.width * (18.5 / 40),
                  child: Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width *
                        ((24.9 - 18.5) / 40),
                    color: Colors.green, // Normal color
                  ),
                ),

                // Segment 3: Overweight
                Positioned(
                  left: MediaQuery.of(context).size.width * (24.9 / 40),
                  child: Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width *
                        ((29.9 - 24.9) / 40),
                    color: Colors.orange, // Overweight color
                  ),
                ),

                // Segment 4: Obese
                Positioned(
                  left: MediaQuery.of(context).size.width * (29.9 / 40),
                  child: Container(
                    height: 25,
                    //width: MediaQuery.of(context).size.width *
                    //((37.5 - 29.9) / 40) - 1, // Slight adjustment to avoid overflow
                    decoration: BoxDecoration(
                      color: Colors.red, // Obese color
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),

                // BMI Indicator
                Positioned(
                  left: MediaQuery.of(context).size.width * widthFactor -
                      15, // Adjust position
                  child: Column(
                    children: [
                      Transform.rotate(
                        angle: 180 * (3.14159 / 180), // Rotate 180 degrees
                        child: Icon(
                          RpgAwesome.water_drop,
                          color: Colors.black,
                          size: 35,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.bmi.toStringAsFixed(1),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 56, 0, 0), width: 2), // Add a black border
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LabelWithColor(
                              label: 'Underweight', color: Colors.blue),
                          LabelWithColor(label: 'Normal', color: Colors.green),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LabelWithColor(
                              label: 'Overweight', color: Colors.orange),
                          LabelWithColor(label: 'Obese', color: Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelWithColor extends StatelessWidget {
  final String label;
  final Color color;

  LabelWithColor({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle, // This makes the square a circle
          ),
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
