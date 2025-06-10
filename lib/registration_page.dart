import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';

// This is your StatefulWidget for the Register Screen
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // GlobalKey for the Form widget, essential for validation
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers for each input field to manage their text
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _specialityController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  // State variable for the "Agree to Terms" checkbox
  bool _agreeToTerms = false;

  @override
  void dispose() {
    // It's crucial to dispose of controllers when the widget is removed
    // from the widget tree to prevent memory leaks.
    _nameController.dispose();
    _phoneController.dispose();
    _specialityController.dispose();
    _experienceController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ----------------- App Bar -----------------
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for the app bar
        elevation: 0, // Removes the shadow under the app bar
        centerTitle: true, // Centers the title text
        title: const Text(
          "Register yourself",
          style: TextStyle(
            color: Colors.black, // Black color for the title text
            fontWeight: FontWeight.bold, // Make title bold
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ), // Black back arrow
          onPressed: () {
            // Action for back button:
            // This usually navigates back in the app's route stack.
            // Example: Navigator.pop(context);
            print('Back button pressed');
          },
        ),
      ),
      // ----------------- Body Content -----------------
      body: SingleChildScrollView(
        // Allows the content to scroll if it overflows
        padding: const EdgeInsets.all(
          20.0,
        ), // Padding around the entire form content
        child: Form(
          key: _formKey, // Assign the GlobalKey to the Form for validation
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns children to the left
            children: [
              // Initial descriptive text
              Text(
                "Let Docsarthi be your trusted partner in transforming healthcare management effortlessly.",
                style: TextStyle(
                  color: Colors.grey[700], // A "light black" (dark grey) color
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20), // Spacer
              // --- Your Name Input Field ---
              const Text(
                "Your Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Enter your full name", // Placeholder text
                  border:
                      OutlineInputBorder(), // Adds a border around the input
                  prefixText: 'Dr. ', // "Dr. " fixed text before input
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Your Name is required';
                  }
                  if (!value.startsWith('Dr.')) {
                    return 'Name must start with "Dr."';
                  }
                  // Basic validation: ensure something is entered after "Dr."
                  if (value.trim().length <= 3) {
                    // "Dr." is 3 characters
                    return 'Please enter your name after "Dr."';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 20),

              // --- Phone Number Input Field ---
              const Text(
                "Phone Number",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType:
                    TextInputType.phone, // Optimizes keyboard for phone input
                decoration: const InputDecoration(
                  hintText: "e.g., 9876543210",
                  border: OutlineInputBorder(),
                  prefixText: '+91 ', // Fixed "+91 " prefix
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  // Basic validation: 10 digits numeric only
                  if (value.length != 10 ||
                      !RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // --- Speciality Input Field ---
              const Text(
                "Speciality",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _specialityController,
                decoration: const InputDecoration(
                  hintText: "e.g., Cardiology, Dermatology",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Speciality is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // --- Years of Experience Input Field ---
              const Text(
                "Years of Experience",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _experienceController,
                keyboardType:
                    TextInputType.number, // Optimizes keyboard for numbers
                decoration: const InputDecoration(
                  hintText: "e.g., 5",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Years of experience is required';
                  }
                  // Validate if it's a valid non-negative integer
                  if (int.tryParse(value) == null || int.parse(value)! < 0) {
                    return 'Please enter a valid number of years';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // --- Email Input Field ---
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType:
                    TextInputType.emailAddress, // Optimizes keyboard for email
                decoration: const InputDecoration(
                  hintText: "you@example.com",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  // Basic regex for email validation
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // --- Terms and Conditions Checkbox (with clickable text) ---
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _agreeToTerms = newValue!;
                      });
                    },
                  ),
                  // Using Expanded with Text.rich to make part of the text clickable
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to the ',
                        style:
                            DefaultTextStyle.of(
                              context,
                            ).style, // Inherit default text style
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: const TextStyle(
                              color: Colors.blue, // Make it look like a link
                              decoration: TextDecoration.underline,
                            ),
                            // Recognizes tap on "Terms and Conditions"
                            // Use GestureDetector if you need more complex tap actions
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Terms and Conditions tapped!');
                                    // Here you would typically open a new screen
                                    // with the terms, or show a dialog.
                                    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen()));
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Increased spacing before the button
              // --- Get Started Button ---
              ElevatedButton(
                onPressed: () {
                  // Validate all fields when the button is pressed
                  if (_formKey.currentState!.validate()) {
                    if (_agreeToTerms) {
                      // If the form is valid AND terms are agreed:
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Registration...'),
                        ),
                      );
                      // Here you would typically collect the data from controllers
                      // and send it to your backend or perform further actions.
                      print('Form Valid and Terms Agreed!');
                      print('Name: ${_nameController.text}');
                      print('Phone: ${_phoneController.text}');
                      print('Speciality: ${_specialityController.text}');
                      print('Experience: ${_experienceController.text}');
                      print('Email: ${_emailController.text}');
                      print('Agreed to terms: $_agreeToTerms');

                      // Example: Navigate to another screen after successful registration
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    } else {
                      // If terms are not agreed
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please agree to the Terms and Conditions to proceed',
                          ),
                        ),
                      );
                    }
                  } else {
                    // If form validation fails (e.g., empty required fields)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please correct the errors in the form'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ), // Makes the button full width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // Optional: rounded corners
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18), // Larger text for the button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// You can run this in your main.dart like this:
/*
void main() {
  runApp(MaterialApp(
    home: RegisterScreen(),
    debugShowCheckedModeBanner: false, // Optional: remove debug banner
  ));
}
*/
