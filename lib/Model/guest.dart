class Guest {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final bool isConfirmed;
  double? weddingGiftAmount;

  Guest({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.isConfirmed,
    this.weddingGiftAmount,
  });

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      isConfirmed: json['isConfirmed'],
      weddingGiftAmount: json['weddingGiftAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'isConfirmed': isConfirmed,
      'weddingGiftAmount': weddingGiftAmount,
    };
  }

  // Funcție copyWith pentru actualizarea obiectului Guest
  Guest copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? isConfirmed,
    double? weddingGiftAmount,
  }) {
    return Guest(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      weddingGiftAmount: weddingGiftAmount ?? this.weddingGiftAmount,
    );
  }
}
