import 'package:intl/intl.dart';

class Smoking {
  final int? id;
  final String dateTime;
  final double price;

  Smoking({
    this.id,
    required this.dateTime,
    required this.price,
  });

  factory Smoking.fromJson(Map<String, dynamic> json) {
    return Smoking(
      id: json['id'] as int?,
      dateTime: json['date'] as String,
      price: json['price'] as double,
    );
  }

  toJson() {
    return {
      'date': dateTime,
      'price': price,
    };
  }

  DateTime dateFormat() {
    return DateTime.parse(dateTime);
  }
}
