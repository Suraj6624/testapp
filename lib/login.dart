import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testapp/otp.dart'; // Ensure this is correct

class BlurredSignInDialog extends StatefulWidget {
  const BlurredSignInDialog({super.key});

  @override
  State<BlurredSignInDialog> createState() => _BlurredSignInDialogState();
}

class _BlurredSignInDialogState extends State<BlurredSignInDialog> {
  final TextEditingController phoneController = TextEditingController();
  bool _isPhoneInvalid = false;
  String? _phoneErrorText;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 20, 79),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ✅ Logo Image
                Image.network(
                  'https://docsarthi.com/images/logo.png',
                  height: 35,
                ),
                const SizedBox(height: 30),

                // ✅ Login Card
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Account Login',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Enter your Mobile No',
                          style: TextStyle(color: Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color:
                                    _isPhoneInvalid ? Colors.red : Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color:
                                    _isPhoneInvalid ? Colors.red : Colors.grey,
                              ),
                            ),
                            errorText: _phoneErrorText,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                49,
                                83,
                                187,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              final phone = phoneController.text.trim();
                              if (RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
                                setState(() {
                                  _isPhoneInvalid = false;
                                  _phoneErrorText = null;
                                });

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            BlurredOTPVerificationDialog(
                                              phoneNumber: phone,
                                            ),
                                  ),
                                );
                              } else {
                                setState(() {
                                  _isPhoneInvalid = true;
                                  _phoneErrorText =
                                      'Enter a valid 10-digit phone number';
                                });
                              }
                            },
                            child: const Text(
                              'Continue',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Create Account',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 49, 83, 187),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
