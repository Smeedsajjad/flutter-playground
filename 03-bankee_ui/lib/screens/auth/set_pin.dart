import 'package:bankee_ui/screens/money_summary_screen.dart';
import 'package:flutter/material.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({Key? key}) : super(key: key);

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  String pin = "";

  void _onKeyboardTap(String value) {
    if (pin.length < 4) {
      setState(() {
        pin += value;
      });
    }
  }

  void _onBackspace() {
    if (pin.isNotEmpty) {
      setState(() {
        pin = pin.substring(0, pin.length - 1);
      });
    }
  }

  void _savePin() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("PIN Saved: $pin")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const Text(
            "Set your PIN",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "You will use this to login next time",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              bool filled = index < pin.length;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  filled ? (index == pin.length - 1 ? pin[index] : "*") : "",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: filled && index == pin.length - 1
                        ? const Color(0xFF6C63FF)
                        : Colors.black87,
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 40),

          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 60),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index == 9) {
                  return const SizedBox.shrink();
                } else if (index == 11) {
                  return IconButton(
                    icon: const Icon(Icons.backspace, color: Colors.black54),
                    onPressed: _onBackspace,
                  );
                } else {
                  String number = (index == 10 ? 0 : index + 1).toString();
                  return InkWell(
                    onTap: () => _onKeyboardTap(number),
                    borderRadius: BorderRadius.circular(50),
                    child: Center(
                      child: Text(
                        number,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: pin.length == 4
                    ? () {
                        _savePin();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MoneySummaryScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7164E3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save PIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
