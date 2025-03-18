import 'package:flutter/material.dart';
import 'step1.dart';
import 'trolley_screen.dart';
import 'services/point_service.dart';
import 'models/user_point.dart';
import 'package:provider/provider.dart';
import 'models/reward_order.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pointService = PointService();
  await pointService.initDatabase();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserPointModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Load user points when app starts
    Future.delayed(Duration.zero, () async {
      final pointService = PointService();
      final points = await pointService.getUserPoints();
      if (points != null) {
        Provider.of<UserPointModel>(context, listen: false).setPoints(points);
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF9E03),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF9E03),
          primary: const Color(0xFFFF9E03),
          secondary: const Color(0xFFFFEE00),
        ),
        fontFamily: 'Roboto',
        cardTheme: CardTheme(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
final List<RewardItem> rewards = [
  RewardItem(
    imagePath: "assets/toothbrush_case.png",
    description: "Toothbrush Case",
    points: 500,
  ),
  RewardItem(
    imagePath: "assets/duck_bag.png",
    description: "Duck Shoulder Bag",
    points: 1000,
  ),
  RewardItem(
    imagePath: "assets/water_bottle.png",
    description: "Portable Water Bottle",
    points: 3000,
  ),
];


  @override
  Widget build(BuildContext context) {
    // Get actual screens based on selected index
    final List<Widget> screens = [
      _buildRewardsScreen(),
      TrolleyScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9E03),
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "VAVA",
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Consumer<UserPointModel>(
              builder: (context, pointModel, child) {
                return Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Color(0xFFFFEE00)),
                    const SizedBox(width: 5),
                    Text(
                      "${pointModel.points}",
                      style: const TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                );
              }
            ),
          ],
        ),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Trolley"),
        ],
      ),
    );
  }

  Widget _buildRewardsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Reward Membership",
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Redeem your points for exclusive rewards",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 16),
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
    );
  }
}



class RewardCard extends StatelessWidget {
  final RewardItem reward;
  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StepOneScreen(
                selectedReward: reward,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFF3E0),
                  image: DecorationImage(
                    image: AssetImage(reward.imagePath),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reward.description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, 
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFECB3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "${reward.points} points",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios, 
                color: Color(0xFFE58A01),
              ),
            ],
          ),
        ),
      ),
    );
  }
}