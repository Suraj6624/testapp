import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentLogPage extends StatefulWidget {
  const PaymentLogPage({Key? key}) : super(key: key);

  @override
  State<PaymentLogPage> createState() => _PaymentLogPageState();
}

class _PaymentLogPageState extends State<PaymentLogPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> paymentLogs = [
    {
      'patientId': 'P001',
      'name': 'John Doe',
      'amount': 500,
      'payment': 'UPI',
      'visitDate': '2025-06-04',
      'doctor': 'Dr. Smith',
      'reason': 'Fever & Cold',
      'patientType': 'New', // ✅ added
    },
    {
      'patientId': 'P002',
      'name': 'Jane Smith',
      'amount': 300,
      'payment': 'Payed at Clinic',
      'visitDate': '2025-06-03',
      'doctor': 'Dr. Alice',
      'reason': 'Regular Checkup',
      'patientType': 'old', // ✅ added
    },
  ];

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        _searchController.text = formattedDate;
        _searchQuery = formattedDate.toLowerCase();
      });
    }
  }

  List<Map<String, dynamic>> get filteredPayments {
    if (_searchQuery.isEmpty) return paymentLogs;
    return paymentLogs.where((payment) {
      return payment['visitDate'].toLowerCase().contains(_searchQuery) ||
          payment['patientId'].toLowerCase().contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(46, 51, 69, 1.0);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Payment Log', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() => _searchQuery = value.trim().toLowerCase());
              },
              decoration: InputDecoration(
                hintText: 'Search by date or patient ID',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  color: primaryColor,
                  onPressed: _pickDate,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                filteredPayments.isNotEmpty
                    ? ListView.builder(
                      itemCount: filteredPayments.length,
                      itemBuilder: (context, index) {
                        return _buildPaymentCard(
                          filteredPayments[index],
                          primaryColor,
                        );
                      },
                    )
                    : Center(
                      child: Text(
                        'No payment logs found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> log, Color primaryColor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.black26,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('👤 Patient ID:', log['patientId']),
            _buildInfoRow('📛 Name:', log['name']),
            _buildInfoRow('💳 Amount Paid:', '₹${log['amount']}'),
            _buildInfoRow('💰 Payment:', log['payment']),
            _buildInfoRow('📅 Visited Date:', log['visitDate']),
            _buildInfoRow('🩺 Doctor:', log['doctor']),
            _buildInfoRow('📌 Reason:', log['reason']),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    flex: 4,
                    child: Text(
                      '🔁 Patient Type:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5,
                        color: Color.fromRGBO(46, 51, 69, 1),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    flex: 6,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _buildPatientTypeBadge(log['patientType']),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.5,
                color: Color.fromRGBO(46, 51, 69, 1),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14.5, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientTypeBadge(String type) {
    final isNew = type.toLowerCase() == 'new';
    final badgeColor = isNew ? Colors.green.shade100 : Colors.blue.shade100;
    final textColor = isNew ? Colors.green.shade800 : Colors.blue.shade800;
    final label = isNew ? 'New' : 'Old';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13.5,
          color: textColor,
        ),
      ),
    );
  }
}
