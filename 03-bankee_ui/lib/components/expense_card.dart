import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExpenseCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String amount;
  final double percent;

  const ExpenseCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.amount,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 6.0,
            percent: percent,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.grey.shade200,
            progressColor: const Color(0xFF7164E3),
            center: Image.asset(imagePath, width: 30, height: 30),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "on track",
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }
}
