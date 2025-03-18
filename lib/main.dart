import 'package:flutter/material.dart';
import 'step1.dart'; // เพิ่ม import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<RewardItem> rewards = [
    RewardItem(500, "assets/toothbrush_case.png", "Toothbrush Case"),
    RewardItem(1000, "assets/duck_bag.png", "Duck Shoulder Bag"),
    RewardItem(3000, "assets/water_bottle.png", "Portable Water Bottle"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 246),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 158, 3),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "VAVA",
              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.monetization_on, color: const Color.fromARGB(255, 255, 238, 0)),
                SizedBox(width: 5),
                Text(
                  "2,034",
                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reward Membership",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  return RewardCard(reward: rewards[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Trolley"),
        ],
      ),
    );
  }
}

class RewardItem {
  final int points;
  final String imagePath;
  final String description;
  RewardItem(this.points, this.imagePath, this.description);
}

class RewardCard extends StatelessWidget {
  final RewardItem reward;
  RewardCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    return InkWell( // ใช้ InkWell เพื่อทำให้ Card กดได้
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StepOneScreen()),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(reward.imagePath),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${reward.points} point", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(reward.description, style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: const Color.fromARGB(255, 229, 138, 1)),
            ],
          ),
        ),
      ),
    );
  }
}