class RewardItem {
  final String imagePath;
  final String description;
  final int points;

  RewardItem({
    required this.imagePath,
    required this.description,
    required this.points,
  });
}

class RewardOrder {
  final String rewardId;
  final String name;
  final int points;
  final String imagePath;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String address;
  final String status;
  final String orderDate;


  RewardOrder({
    required this.rewardId,
    required this.name,
    required this.points,
    required this.imagePath,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.status,
    required this.orderDate,
  });

  factory RewardOrder.fromMap(Map<String, dynamic> map) {
    return RewardOrder(
      rewardId: map['rewardId'],
      name: map['name'],
      points: map['points'],
      imagePath: map['imagePath'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      address: map['address'],
      status: map['status'],
      orderDate: map['orderDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rewardId': rewardId,
      'name': name,
      'points': points,
      'imagePath': imagePath,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'status': status,
      'orderDate': orderDate,
    };
  }
}