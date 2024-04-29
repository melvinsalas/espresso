import 'package:equatable/equatable.dart';

class Pricing extends Equatable {
  final int timestamp;
  final double price;

  DateTime get date => DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());

  const Pricing({
    required this.timestamp,
    required this.price,
  });

  @override
  List<Object> get props => [timestamp, price];

  factory Pricing.fromJson(List<dynamic> json) {
    return Pricing(
      timestamp: json[0] as int,
      price: (json[1] as num).toDouble(),
    );
  }
}
