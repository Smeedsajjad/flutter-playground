import 'package:bankee_ui/screens/auth/account_created.dart';
import 'package:bankee_ui/screens/auth/opt.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ReciveCodeScreen extends StatelessWidget {
  const ReciveCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                "Verify Account!",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Enter 4-digit Code code we have sent to at",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                "+0 000 000 0000.",
                style: const TextStyle(
                  color: Color(0xFF7164E3),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: false,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  inactiveColor: Colors.black38,
                  selectedColor: const Color(0xFF7164E3),
                  activeColor: const Color(0xFF7164E3),
                ),
                onChanged: (value) {},
              ),

              const SizedBox(height: 20),
              Text(
                "Didn’t not received the code?",
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const OptScreen()),
                  );
                },
                child: const Text(
                  "Resend Code",
                  style: TextStyle(
                    color: Color(0xFF7164E3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountCreatedScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7164E3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text.rich(
                TextSpan(
                  text: "by clicking start, you agree to our ",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  children: const [
                    TextSpan(
                      text: "Privacy Policy ",
                      style: TextStyle(
                        color: Color(0xFF7164E3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: "our "),
                    TextSpan(
                      text: "Teams and Conditions",
                      style: TextStyle(
                        color: Color(0xFF7164E3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
