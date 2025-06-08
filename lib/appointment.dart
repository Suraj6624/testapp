import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'api_servise.dart';

final List<String> _clinicOptions = ['Clinic A', 'Clinic B', 'Clinic C'];

class BookAppointmentForm extends StatefulWidget {
  @override
  BookAppointmentFormState createState() => BookAppointmentFormState();
}

class BookAppointmentFormState extends State<BookAppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  bool _submitted = false;
  DateTime? _selectedDate;

  String? _gender;
  String? _patientType;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _healthIssuesController = TextEditingController();
  final _clinicController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _clinicController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _healthIssuesController.dispose();

    super.dispose();
  }

  List<String> _dateOptions = [];
  String? _selectedDateStr;

  @override
  void initState() {
    super.initState();
    _generateDateOptions();
    if (_dateOptions.isNotEmpty) {
      _selectedDateStr = _dateOptions[0];
      _selectedDate = DateFormat(
        'd MMMM yyyy',
        'en_US',
      ).parse(_selectedDateStr!);
    }
  }

  void _generateDateOptions() {
    final now = DateTime.now();
    _dateOptions = List.generate(7, (index) {
      final date = now.add(Duration(days: index));
      return DateFormat('d MMMM yyyy', 'en_US').format(date); // Specify English
    });
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 3),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color.fromRGBO(46, 51, 69, 1.0)),
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  Widget _buildDateDropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointment Date',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 3),
          DropdownButtonFormField<String>(
            value:
                _selectedDateStr != null &&
                        _dateOptions.contains(_selectedDateStr)
                    ? _selectedDateStr
                    : null,
            hint: Text('Select Appointment Date'),
            items:
                _dateOptions.map((date) {
                  return DropdownMenuItem<String>(
                    value: date,
                    child: Text(date),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedDateStr = value;
                try {
                  _selectedDate = DateFormat(
                    'd MMMM yyyy',
                    'en_US',
                  ).parse(value!);
                } catch (e) {
                  print('Date parsing error: $e');
                  _selectedDate = null;
                }
              });
            },

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color.fromRGBO(46, 51, 69, 1.0)),
              ),
            ),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please select appointment date'
                        : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup({
    required String title,
    required List<String> options,
    required String? groupValue,
    required void Function(String?) onChanged,
    bool showError = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 0),
          Wrap(
            spacing: 5,
            children:
                options
                    .map(
                      (option) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: option,
                            groupValue: groupValue,
                            onChanged: onChanged,
                            activeColor: Color.fromRGBO(46, 51, 69, 1.0),
                          ),
                          Text(option),
                        ],
                      ),
                    )
                    .toList(),
          ),
          if (showError && groupValue == null)
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                'Please select ${title.toLowerCase()}',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    FocusScope.of(context).unfocus();
    if (_isSubmitting) return;

    setState(() {
      _submitted = true;
      _isSubmitting = true;
    });
    if (_formKey.currentState!.validate() &&
        _gender != null &&
        _patientType != null &&
        _selectedDate != null) {
      final formData = {
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'age': _ageController.text.trim(),
        'gender': _gender,
        'address': _addressController.text.trim(),
        'health_issues': _healthIssuesController.text.trim(),
        'patient_type': _patientType,
        'clinic': _clinicController.text.trim(),
        'appointment_date': "${_selectedDate!.toIso8601String()}",
      };

      try {
        await ApiService().submitAppointment(formData);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Form submitted successfully')));

        _formKey.currentState!.reset();
        setState(() {
          _gender = null;
          _patientType = null;
          _submitted = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submission failed. Please try again.')),
        );
      }
    }

    setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Appointment',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(46, 51, 69, 1.0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    label: 'Patient Name',
                    controller: _nameController,
                    validator:
                        (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Please enter patient name'
                                : null,
                  ),
                  _buildTextField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter phone number';
                      if (!RegExp(r'^\d{10}$').hasMatch(value))
                        return 'Phone number must be 10 digits';
                      return null;
                    },
                  ),
                  _buildTextField(
                    label: 'Patient Age (in years)',
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Please enter age'
                                : null,
                  ),
                  _buildRadioGroup(
                    title: 'Gender',
                    options: ['Male', 'Female', 'Other'],
                    groupValue: _gender,
                    onChanged: (value) => setState(() => _gender = value),
                    showError: _submitted,
                  ),
                  _buildTextField(
                    label: 'Address',
                    controller: _addressController,
                  ),
                  _buildTextField(
                    label: 'Describe Health Issues',
                    controller: _healthIssuesController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Clinic',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 3),
                        DropdownButtonFormField<String>(
                          value:
                              _clinicController.text.isNotEmpty
                                  ? _clinicController.text
                                  : null,
                          items:
                              _clinicOptions.map((clinic) {
                                return DropdownMenuItem<String>(
                                  value: clinic,
                                  child: Text(clinic),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _clinicController.text = value!;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(46, 51, 69, 1.0),
                              ),
                            ),
                          ),
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please select a clinic'
                                      : null,
                        ),
                      ],
                    ),
                  ),

                  _buildDateDropdownField(),

                  _buildRadioGroup(
                    title: 'Patient Type',
                    options: ['New', 'Old'],
                    groupValue: _patientType,
                    onChanged: (value) => setState(() => _patientType = value),
                    showError: _submitted,
                  ),

                  SizedBox(height: 6),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(46, 160, 67, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _isSubmitting ? 'Submitting...' : 'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
