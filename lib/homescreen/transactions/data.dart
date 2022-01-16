import 'package:flutter/material.dart';

class TransactionHistory {
  final String tx_hash;
  final String from_address;
  final String to_address;
  final int gas_offered;
  final int gas_spent;
  final int gas_price;
  final String block_signed_at;

  TransactionHistory(
      {required this.tx_hash,
      required this.from_address,
      required this.to_address,
      required this.gas_offered,
      required this.gas_spent,
      required this.gas_price,
      required this.block_signed_at});

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    return TransactionHistory(
        tx_hash: json['tx_hash'],
        from_address: json["from_address"],
        to_address: json["to_address"],
        gas_offered: json["gas_offered"],
        gas_spent: json["gas_spent"],
        gas_price: json["gas_price"],
        block_signed_at: json["block_signed_at"]);
  }
}
