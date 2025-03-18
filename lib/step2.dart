import 'package:flutter/material.dart';

class StepTwoScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String address;

  StepTwoScreen({
    Key? key, // เพิ่ม key parameter
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.address,
  }) : super(key: key); // ส่ง key ไปยัง super constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Step 2", style: TextStyle(color: Colors.black)),
        actions: [
          Row(
            children: [
              Icon(Icons.monetization_on, color: Colors.yellow[700]),
              SizedBox(width: 5),
              Text("2,034", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Review Address\n\n"
                "First Name: $firstName\n"
                "Last Name: $lastName\n"
                "Phone Number: $phoneNumber\n"
                "E-Mail: $email\n"
                "Address: $address",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () => Navigator.pop(context),
              child: Text("Edit Address", style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () {},
              child: Text("Complete", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}