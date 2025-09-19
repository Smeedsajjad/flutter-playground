import 'package:bankee_ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetDetailsScreen extends StatelessWidget {
  const BudgetDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> amount = [250, 172, 99];
    final List<String> labels = ["July", "this month", "June"];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Budget',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7164E3),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 220,
                decoration: const BoxDecoration(
                  color: Color(0xff7164E3),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(60),
                  ),
                ),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) => const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.25, 0.81, 1.0],
                  ).createShader(bounds),
                  blendMode: BlendMode.dstIn,
                  child: ListView.separated(
                    controller: ScrollController(
                      initialScrollOffset: (61.5 + 42.5) * 1,
                    ),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      left: 32,
                      right: 32,
                      bottom: 102,
                    ),
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(width: 42.5),
                    itemBuilder: (_, i) =>
                        _BudgetCard(amount: amount[i], label: labels[i]),
                  ),
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -100),
                child: Column(
                  children: const [
                    TrackCard(
                      title: 'Lunch & Dinner',
                      daily: 52,
                      spent: 450,
                      budget: 900,
                      onTrackText: 'Your food spending is still on track',
                      images: 'assets/images/samll_burger.png',
                    ),
                    TrackCard(
                      title: 'Car fuel',
                      daily: 20,
                      spent: 600,
                      budget: 900,
                      onTrackText: 'Your fuel spending is high',
                      images: 'assets/images/samll_medicine.png',
                    ),
                    TrackCard(
                      title: 'Medical Allowances',
                      daily: 30,
                      spent: 230,
                      budget: 900,
                      onTrackText: 'Your medical spending is on track',
                      images: 'assets/images/small_house.png',
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                      );
                    },

                    label: const Text(
                      "Go Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7164E3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  final double amount;
  final String label;

  const _BudgetCard({required this.amount, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\$$amount",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.title,
    required this.daily,
    required this.spent,
    required this.budget,
    required this.onTrackText,
    required this.images,
  });

  final String title;
  final int daily;
  final int spent;
  final int budget;
  final String onTrackText;
  final String images;

  @override
  Widget build(BuildContext context) {
    final double rawProgress = budget == 0 ? 0.0 : spent / budget;
    final double progress = rawProgress.clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(images),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(flex: 1),
              Text(
                '\$$daily/day',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Stack(
            alignment: Alignment.center,
            children: [
              LinearPercentIndicator(
                percent: progress,
                lineHeight: 40.0,
                backgroundColor: Colors.grey.shade200,
                progressColor: spent > 500
                    ? Color(0xFF9ea5bd)
                    : Color(0xFF7164E3),
                barRadius: const Radius.circular(50),
                animation: true,
                animationDuration: 500,
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$$spent',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '\$$budget',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(bottom: 2, top: 12),
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Color(0xff7164E3),
                  radius: 14,
                  child: Icon(
                    Icons.check,
                    size: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                onTrackText,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
