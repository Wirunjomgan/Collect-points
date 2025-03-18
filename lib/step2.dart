import 'package:flutter/material.dart';
import 'services/reward_service.dart';
import 'services/point_service.dart';
import 'models/user_point.dart';
import 'package:provider/provider.dart';
import 'models/reward_order.dart';

class StepTwoScreen extends StatefulWidget {
  final RewardItem selectedReward;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String address;

  const StepTwoScreen({
    super.key,
    required this.selectedReward,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.address,
  });

  @override
  _StepTwoScreenState createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9E03),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Step 2 - Confirm Details",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Reward preview
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(widget.selectedReward.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.selectedReward.description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFECB3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "${widget.selectedReward.points} points",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // User information card
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recipient Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const Divider(height: 24),
                    _buildInfoRow("Name", "${widget.firstName} ${widget.lastName}"),
                    _buildInfoRow("Phone", widget.phoneNumber),
                    _buildInfoRow("Email", widget.email),
                    _buildInfoRow("Address", widget.address),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFFFF9E03)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isProcessing ? null : () => Navigator.pop(context),
                      child: const Text(
                        "Edit Details",
                        style: TextStyle(
                          color: Color(0xFFFF9E03),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9E03),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isProcessing ? null : _processOrder,
                      child: _isProcessing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Confirm Order",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _processOrder() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      // Get current user points
      final pointModel = Provider.of<UserPointModel>(context, listen: false);
      final currentPoints = pointModel.points;
      
      // Check if enough points
      if (currentPoints < widget.selectedReward.points) {
        _showError("Not enough points to redeem this reward.");
        print("Not enough points to redeem this reward.");
        return;
      }
      
      // Save reward to database
      final rewardService = RewardService();
      await rewardService.saveReward(
        RewardOrder(
          rewardId: DateTime.now().millisecondsSinceEpoch.toString(),
          name: widget.selectedReward.description,
          points: widget.selectedReward.points,
          imagePath: widget.selectedReward.imagePath,
          firstName: widget.firstName,
          lastName: widget.lastName,
          phoneNumber: widget.phoneNumber,
          email: widget.email,
          address: widget.address,
          status: "Pending",
          orderDate: DateTime.now().toString(),
        ),
      );
      
      // Deduct points
      final pointService = PointService();
      final newPoints = currentPoints - widget.selectedReward.points;
      await pointService.updatePoints(newPoints);
      
      // Update points in provider
      pointModel.setPoints(newPoints);
      
      // Show success and return to home
      _showSuccess();
    } catch (e) {
        print("Error details: $e"); // เพิ่มบรรทัดนี้เพื่อดูรายละเอียดข้อผิดพลาด
        _showError("Error processing your order. Please try again.");
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showSuccess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Order Successful"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              "Your order has been placed successfully!",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "${widget.selectedReward.points} points have been deducted from your account.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.popUntil(context, (route) => route.isFirst); // Return to home
            },
            child: const Text("Back to Home"),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
    setState(() {
      _isProcessing = false;
    });
  }
}