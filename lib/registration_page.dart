import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:testapp/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedTitle;
  String? _selectedSpeciality;
  bool _agreedToTerms = false;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _experienceController = TextEditingController();
  final _emailController = TextEditingController();

  final List<String> _titles = ['Dr', 'Dt'];
  final List<String> _specialities = [
    'Cardiologist',
    'Dentist',
    'Physician',
    'Surgeon',
  ];

  InputDecoration _inputDecoration({Widget? prefixIcon, String? prefixText}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      prefixIcon: prefixIcon,
      prefixText: prefixText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 20, 79),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Image.network(
                  'https://docsarthi.com/images/logo.png',
                  height: 35,
                ),
              ),
              const SizedBox(height: 30),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Name'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          decoration: _inputDecoration(
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(left: 8, right: 4),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedTitle,
                                  hint: const Text('Dr'),
                                  items:
                                      _titles.map((title) {
                                        return DropdownMenuItem(
                                          value: title,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Text(title),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    setState(() => _selectedTitle = value);
                                  },
                                ),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if ((_selectedTitle == null ||
                                    _selectedTitle!.isEmpty) ||
                                value == null ||
                                value.isEmpty) {
                              return 'Title and name required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text('Phone Number'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: _inputDecoration(prefixText: '+91 '),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 10) {
                              return 'Enter a valid 10-digit mobile number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text('Speciality'),
                        const SizedBox(height: 8),

                        DropdownButtonFormField<String>(
                          value: _selectedSpeciality,
                          items:
                              _specialities.map((speciality) {
                                return DropdownMenuItem(
                                  value: speciality,
                                  child: Text(speciality),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() => _selectedSpeciality = value);
                          },
                          validator:
                              (value) =>
                                  value == null
                                      ? 'Please select a speciality'
                                      : null,
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 10),
                        const Text('Year of Experiences'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _experienceController,
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 10),
                        const Text('Email'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: _agreedToTerms,
                              onChanged: (value) {
                                setState(() => _agreedToTerms = value ?? false);
                              },
                              activeColor: const Color.fromARGB(
                                255,
                                49,
                                83,
                                187,
                              ),
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to terms
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    text: 'I agree to the ',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: 'Terms and Conditions',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            49,
                                            83,
                                            187,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                              if (_formKey.currentState!.validate() &&
                                  _agreedToTerms) {
                                // Handle registration logic
                              }
                            },
                            child: const Text(
                              'Get Started',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Have an account already? '),
                            GestureDetector(
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const BlurredSignInDialog(),
                                    ),
                                  ),
                              child: const Text(
                                'Sign In',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
