import 'package:flutter/material.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController feetController =
      TextEditingController(); // New controller for feet
  final TextEditingController inchesController =
      TextEditingController(); // New controller for inches
  String gender = 'Male';
  bool isMetric = true;

  void calculateBMI() {
    double height;
    double weight = double.parse(weightController.text);
    int age = int.parse(ageController.text);
    double bmi;

    if (isMetric) {
      height =
          double.parse(heightController.text) / 100; // Convert cm to meters
      bmi =
          weight / (height * height); // Metric: weight in kg, height in meters
    } else {
      int feet = int.parse(feetController.text);
      int inches = int.parse(inchesController.text);
      height = (feet * 12.0) + inches; // Convert feet and inches to inches
      bmi = (weight / (height * height)) *
          703; // US: weight in pounds, height in inches
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(bmi: bmi, age: age, gender: gender),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 245, 245),
      appBar: AppBar(
        centerTitle: true,
        title: Text("BMI Calculator"),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 255, 248, 248), fontSize: 28, fontWeight: FontWeight.w700),
        backgroundColor: const Color.fromARGB(255, 185, 1, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Metric Units"),
                Switch(
                  value: !isMetric,
                  onChanged: (value) {
                    setState(() {
                      isMetric = !value;
                      heightController.clear();
                      weightController.clear();
                      feetController.clear();
                      inchesController.clear();
                    });
                  },
                  activeColor: Colors.red, // Change active switch color
                ),
                Text("US Units"),
              ],
            ),
            SizedBox(height: 20),
            if (isMetric)
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: TextStyle(
                  color: Color.fromARGB(255, 88, 59, 59), // Label text color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 170, 0,
                          0)), // Border color when TextField is focused
                ),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: feetController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Height (feet)',
                        labelStyle: TextStyle(
                  color: Color.fromARGB(255, 88, 59, 59), // Label text color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 170, 0,
                          0)), // Border color when TextField is focused
                ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: inchesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Height (inches)',
                        labelStyle: TextStyle(
                  color: Color.fromARGB(255, 88, 59, 59), // Label text color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 170, 0,
                          0)), // Border color when TextField is focused
                ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: isMetric ? 'Weight (kg)' : 'Weight (pounds)',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 88, 59, 59), // Label text color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 170, 0,
                          0)), // Border color when TextField is focused
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 88, 59, 59), // Label text color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 170, 0,
                          0)), // Border color when TextField is focused
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: gender,
              borderRadius: BorderRadius.circular(20),
              onChanged: (String? newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 83, 51, 51))),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 207, 207), // Change this to your preferred color
              ),
              child: Text('Calculate BMI',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 170, 0, 0))),
            ),
              
            
          ],
        ),
      ),
    );
  }
}
