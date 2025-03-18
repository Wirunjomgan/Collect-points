import 'package:flutter/material.dart';
import 'services/reward_service.dart';
import 'models/reward_order.dart';
import 'package:intl/intl.dart';

class TrolleyScreen extends StatefulWidget {
  const TrolleyScreen({super.key});

  @override
  _TrolleyScreenState createState() => _TrolleyScreenState();
}

class _TrolleyScreenState extends State<TrolleyScreen> {
  final RewardService _rewardService = RewardService();
  List<RewardOrder> _rewards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRewards();
  }

  Future<void> _loadRewards() async {
    setState(() => _isLoading = true);
    
    try {
      final rewards = await _rewardService.getRewards();
      setState(() {
        _rewards = rewards;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading rewards: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F6),
      body: RefreshIndicator(
        onRefresh: _loadRewards,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _rewards.isEmpty
                ? _buildEmptyState()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your Rewards",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Track your rewards status here",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _rewards.length,
                            itemBuilder: (context, index) {
                              return _buildRewardOrderCard(_rewards[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_cart.png',
            width: 120,
            height: 120,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.shopping_cart_outlined,
              size: 120,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Your trolley is empty",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Redeem some rewards to see them here",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF999999),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9E03),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/'),
            child: const Text(
              "Browse Rewards",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardOrderCard(RewardOrder reward) {
    // Format the date
    DateTime orderDate = DateTime.parse(reward.orderDate);
    String formattedDate = DateFormat('MMM dd, yyyy').format(orderDate);
    
    // Determine status color
    Color statusColor;
    switch (reward.status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.blue;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Order #${reward.rewardId.substring(0, 8)}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          reward.status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    "${reward.points} pts",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            _buildShippingInfo(reward),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingInfo(RewardOrder reward) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Shipping Information",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Name: ${reward.firstName} ${reward.lastName}",
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Contact: ${reward.phoneNumber}",
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Email: ${reward.email}",
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Address: ${reward.address}",
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF9E03)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                _showDetailsDialog(reward);
              },
              child: const Text(
                "View Details",
                style: TextStyle(
                  color: Color(0xFFFF9E03),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showDetailsDialog(RewardOrder reward) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reward Details"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(reward.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reward.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
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
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                "Order Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text("Order ID: ${reward.rewardId}"),
              Text("Order Date: ${reward.orderDate}"),
              Text("Status: ${reward.status}"),
              const SizedBox(height: 16),
              const Text(
                "Recipient Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text("Name: ${reward.firstName} ${reward.lastName}"),
              Text("Phone: ${reward.phoneNumber}"),
              Text("Email: ${reward.email}"),
              Text("Address: ${reward.address}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}