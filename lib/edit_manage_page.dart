import 'package:flutter/material.dart';

class EditClinicPage extends StatefulWidget {
  const EditClinicPage({super.key});

  @override
  State<EditClinicPage> createState() => _EditClinicPageState();
}

class _EditClinicPageState extends State<EditClinicPage> {
  final _formKey = GlobalKey<FormState>();
  String? _canCancelAppointment = 'Yes';
  String? _state;
  String? _district;
  String? _paymentMethod = 'Online';
  String? _useDigitalPrescription = 'No';
  String? _useSignature = 'No';

  final List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  final List<String> districts = ['District 1', 'District 2', 'District 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Clinic'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(46, 51, 69, 1.0),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Clinic Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField('Clinic Name'),
              _buildTextField(
                'Clinic Email',
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                'Clinic WhatsApp Number',
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                'Calling Number',
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                'Consultation Fee',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                'Handling Fee',
                keyboardType: TextInputType.number,
              ),
              _buildDropdown(
                'Can patient cancel appointment?',
                ['Yes', 'No'],
                _canCancelAppointment,
                (value) => setState(() => _canCancelAppointment = value),
              ),
              _buildTextField(
                'Per Patient Time (in minutes)',
                keyboardType: TextInputType.number,
              ),
              _buildDropdown(
                'Select State',
                states,
                _state,
                (value) => setState(() => _state = value),
              ),
              _buildDropdown(
                'Select District',
                districts,
                _district,
                (value) => setState(() => _district = value),
              ),
              _buildTextField('Clinic Address', maxLines: 1),
              _buildTextField('Clinic Map Link'),

              const SizedBox(height: 10),
              const Text("Payment Method"),
              _buildRadioGroup(
                'Payment Method',
                ['Online', 'Pay at Clinic', 'Both'],
                _paymentMethod,
                (value) => setState(() => _paymentMethod = value),
              ),

              const SizedBox(height: 10),
              const Text(
                "Your Timing in Clinic",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              for (var day in [
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
              ])
                _buildDayTiming(day),

              const SizedBox(height: 10),
              const Text("Do you want to use digital prescription?"),
              _buildRadioGroup(
                'Digital Prescription',
                ['Yes', 'No'],
                _useDigitalPrescription,
                (value) => setState(() => _useDigitalPrescription = value),
              ),
              if (_useDigitalPrescription == 'Yes')
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Upload Prescription Format'),
                ),

              const SizedBox(height: 10),
              const Text("Do you want to put signature on prescription?"),
              _buildRadioGroup(
                'Use Signature',
                ['Yes', 'No'],
                _useSignature,
                (value) => setState(() => _useSignature = value),
              ),
              if (_useSignature == 'Yes')
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Upload Signature'),
                ),

              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(46, 51, 69, 1.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text("Are you sure?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Clinic updated successfully',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            ),
                      );
                    }
                  },
                  child: const Text(
                    'Update Clinic',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator:
                (value) =>
                    value == null || value.isEmpty ? 'Required field' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // 👈 Rounded corners
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ✅ No const here
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ✅ No const here
                borderSide: BorderSide(color: Colors.teal),
              ),

              contentPadding: EdgeInsets.symmetric(
                vertical: 14, // ⬅️ adjust this value for height
                horizontal: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selected,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: selected,

            items:
                items
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
            onChanged: onChanged,
            validator:
                (value) =>
                    value == null || value.isEmpty ? 'Required field' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // 👈 Rounded corners
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ✅ No const here
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ✅ No const here
                borderSide: BorderSide(color: Colors.teal),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 14, // ⬅️ adjust this value for height
                horizontal: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup(
    String groupName,
    List<String> options,
    String? selected,
    Function(String?) onChanged,
  ) {
    return Column(
      children:
          options
              .map(
                (option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selected,
                  onChanged: onChanged,
                ),
              )
              .toList(),
    );
  }

  Widget _buildDayTiming(String day) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(child: _buildTextField('Opening Time')),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField('Closing Time')),
            ],
          ),
        ],
      ),
    );
  }
}
