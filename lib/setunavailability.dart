import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetUnavailabilityPage extends StatefulWidget {
  const SetUnavailabilityPage({super.key});

  @override
  State<SetUnavailabilityPage> createState() => _SetUnavailabilityPageState();
}

class _SetUnavailabilityPageState extends State<SetUnavailabilityPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedClinic;
  DateTime? selectedDate;
  final TextEditingController _reasonController = TextEditingController();

  List<String> clinics = ['Clinic 1', 'Clinic 2', 'Clinic 3'];

  void _pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black54,
            colorScheme: const ColorScheme.light(primary: Colors.black54),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          "Set Unavailability",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,

        elevation: 2,
        backgroundColor: const Color.fromRGBO(46, 51, 69, 1.0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Select Clinic*"),
                  DropdownButtonFormField<String>(
                    value: selectedClinic,
                    hint: const Text("Choose a clinic"),
                    items:
                        clinics
                            .map(
                              (clinic) => DropdownMenuItem(
                                value: clinic,
                                child: Text(clinic),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => selectedClinic = value),
                    validator:
                        (value) =>
                            value == null ? 'Please select a clinic' : null,
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 24),

                  _label("Select Date*"),
                  InkWell(
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: _inputDecoration(
                        icon: const Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.black54,
                        ),
                      ),
                      child: Text(
                        selectedDate != null
                            ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                            : 'Tap to select date',
                        style: TextStyle(
                          color:
                              selectedDate != null
                                  ? Colors.black87
                                  : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  _label("Reason for Unavailability (Only visible to you)"),
                  TextFormField(
                    controller: _reasonController,
                    maxLines: 3,
                    decoration: _inputDecoration(hint: "Optional reason..."),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                          style: _buttonStyle(Colors.grey.shade700),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                selectedDate != null) {
                              Navigator.pop(context, {
                                'clinic': selectedClinic!,
                                'date': DateFormat(
                                  'dd-MM-yyyy',
                                ).format(selectedDate!),
                                'reason': _reasonController.text,
                              });
                            } else if (selectedDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select a date"),
                                ),
                              );
                            }
                          },
                          child: const Text("Set Unavailability"),
                          style: _buttonStyle(Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable label
  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    ),
  );

  // Reusable input decoration
  InputDecoration _inputDecoration({Widget? icon, String? hint}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: icon,
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black54),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    );
  }

  // Reusable button style
  // Reusable button style with softer look
  ButtonStyle _buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color.withOpacity(0.15), // softer color
      foregroundColor: Colors.black87,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 14),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.4)), // subtle border
      ),
    );
  }
}
