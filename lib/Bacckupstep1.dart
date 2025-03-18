import 'package:flutter/material.dart';

class StepOneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Step 1", style: TextStyle(color: Colors.black)),
        actions: [
          Row(
            children: [
              Icon(Icons.monetization_on, color: const Color.fromARGB(255, 255, 255, 255)),
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
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/toothbrush_case.png"),
            ),
            SizedBox(height: 10),
            Text("500 point", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(
              "Redeem your points for a Toothbrush Case.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "First Name", fillColor: const Color.fromARGB(255, 255, 255, 253), filled: true)),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Last Name", fillColor: const Color.fromARGB(255, 255, 255, 255), filled: true)),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Phone Number", fillColor: const Color.fromARGB(255, 255, 255, 255), filled: true)),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "E-Mail", fillColor: const Color.fromARGB(255, 255, 255, 255), filled: true)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Address", fillColor: Colors.yellow, filled: true),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StepTwoScreen()),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.send, color: Colors.black),
                  SizedBox(width: 5),
                  Text("Confirm Address", style: TextStyle(color: Colors.black)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StepTwoScreen extends StatelessWidget {
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
              child: Text("Review Address", textAlign: TextAlign.center),
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
import 'package:flutter/material.dart';
import 'step_two_screen.dart'; // Import StepTwoScreen

class StepOneScreen extends StatelessWidget {
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
        title: Text("Step 1", style: TextStyle(color: Colors.black)),
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
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/toothbrush_case.png"),
            ),
            SizedBox(height: 10),
            Text("500 point", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(
              "Redeem your points for a Toothbrush Case.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "First Name", fillColor: const Color.fromARGB(255, 251, 251, 251), filled: true)),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Last Name", fillColor: const Color.fromARGB(255, 255, 255, 255), filled: true)),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Phone Number", fillColor: const Color.fromARGB(255, 255, 255, 255), filled: true)),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "E-Mail", fillColor: const Color.fromARGB(255, 255, 255, 255), filled: true)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Address", fillColor: Colors.yellow, filled: true),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StepTwoScreen()),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.send, color: Colors.black),
                  SizedBox(width: 5),
                  Text("Confirm Address", style: TextStyle(color: Colors.black)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}