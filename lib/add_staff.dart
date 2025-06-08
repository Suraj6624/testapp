import 'package:flutter/material.dart';

class AddStaffPage extends StatefulWidget {
  const AddStaffPage({super.key});

  @override
  State<AddStaffPage> createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedClinic;
  String? _selectedStatus;

  final List<String> clinics = ['Clinic 1', 'Clinic 2', 'Clinic 3'];
  final List<String> statuses = ['Active', 'Inactive'];

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Staff"),
        backgroundColor: const Color.fromRGBO(46, 51, 69, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Staff Name",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration("Enter staff name"),
                    validator:
                        (value) =>
                            value == null || value.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Phone Number",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: _inputDecoration("Enter phone number"),
                    validator:
                        (value) =>
                            value == null || value.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Select Clinic",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedClinic,
                    items:
                        clinics
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => _selectedClinic = value),
                    decoration: _inputDecoration("Choose clinic"),
                    validator: (value) => value == null ? "Required" : null,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    items:
                        statuses
                            .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => _selectedStatus = value),
                    decoration: _inputDecoration("Choose status"),
                    validator: (value) => value == null ? "Required" : null,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context, {
                            'name': _nameController.text,
                            'phone': _phoneController.text,
                            'clinic': _selectedClinic!,
                            'status': _selectedStatus!,
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Add Staff",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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
