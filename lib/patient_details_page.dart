import 'dart:ui';
import 'package:flutter/material.dart';

class PatientDetailsPage extends StatelessWidget {
  const PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> patient = {
      "patientId": "P001",
      "name": "Rahul Verma",
      "gender": "Male",
      "age": 34,
      "paymentMethod": "Online",
      "appointmentDate": "26 May 2025",
      "appointmentTime": "10:30 AM",
      "status": "Booked",
      "mobile": "9876543210",
      "address": "123 MG Road, Delhi",
      "bookedIp": "192.168.1.10",
      "healthIssues": "Fever and cold",
      "paymentAmount": 500,
      "transactionId": "TXN123456789",
    };

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              title: const Text("Patient Details"),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(46, 51, 69, 1.0),
              elevation: 0,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        // color: Colors.white,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 244, 247, 247),
              Color.fromARGB(255, 254, 246, 246),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 90),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildCard(
                icon: Icons.info_outline,
                title: "Basic Info",
                children: [
                  _infoRow(
                    "Name",
                    patient['name'],
                    icon: Icons.person,
                    iconColor: Colors.blueAccent,
                  ),
                  _infoRow(
                    "Mobile Number",
                    patient['mobile'],
                    icon: Icons.phone,
                    iconColor: Colors.green,
                  ),
                  _infoRow(
                    "Gender / Age",
                    "${patient['gender']} / ${patient['age']}",
                    icon: Icons.wc,
                    iconColor: Colors.pinkAccent,
                  ),
                  _infoRow(
                    "Health Issues",
                    patient['healthIssues'],
                    icon: Icons.local_hospital,
                    iconColor: Colors.redAccent,
                  ),
                  _infoRow(
                    "Address",
                    patient['address'],
                    icon: Icons.location_on,
                    iconColor: Colors.orangeAccent,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildCard(
                icon: Icons.event_note,
                title: "Appointment Details",
                children: [
                  _infoRow(
                    "Appointment ID", // ✅ Changed from "Patient ID"
                    patient['patientId'],
                    icon: Icons.badge,
                    iconColor: Colors.indigo,
                  ),

                  _infoRow(
                    "Appointment Date",
                    patient['appointmentDate'],
                    icon: Icons.calendar_today,
                    iconColor: Colors.cyan,
                  ),
                  _infoRow(
                    "Appointment Time",
                    patient['appointmentTime'],
                    icon: Icons.access_time,
                    iconColor: Colors.lightBlue,
                  ),
                  _infoRow(
                    "Booked IP",
                    patient['bookedIp'],
                    icon: Icons.computer,
                    iconColor: Colors.brown,
                  ),
                  _infoRowWithStatus(
                    "Status",
                    patient['status'],
                  ), // Moved below Booked IP
                ],
              ),
              const SizedBox(height: 10),
              _buildCard(
                icon: Icons.payment,
                title: "Payment Details",
                children: [
                  _infoRow(
                    "Amount Paid",
                    "\u{20B9}${patient['paymentAmount']}", // ₹ symbol
                    icon: Icons.attach_money,
                    iconColor: Colors.teal,
                  ),
                  if (patient['paymentMethod'] == "Online")
                    _infoRow(
                      "Transaction ID",
                      patient['transactionId'],
                      icon: Icons.receipt_long,
                      iconColor: Colors.grey,
                    ),
                  _infoRow(
                    "Payment Method",
                    patient['paymentMethod'],
                    icon: Icons.payment,
                    iconColor: const Color.fromARGB(255, 136, 204, 237),
                  ),
                  _infoRowWithStatus(
                    "Payment Status",
                    "Successful", // ✅ Hardcoded payment status message
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    const cardTitleColor = Color.fromRGBO(46, 51, 69, 1.0);
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon(icon, color: Colors.teal, size: 20),
              Icon(icon, color: Colors.teal, size: 20), // 👈 updated color
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  // color: Colors.teal,
                  color: cardTitleColor, // 👈 updated color
                  // decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value, {
    IconData? icon,
    Color? iconColor,
  }) {
    const cardTitleColor = Color.fromRGBO(46, 51, 69, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: iconColor ?? cardTitleColor),
            const SizedBox(width: 6),
          ],
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRowWithStatus(String label, String status) {
    Color statusColor = Colors.grey;

    // ✅ Define color logic
    final statusLower = status.toLowerCase();
    if (statusLower == "booked" || statusLower == "successful") {
      statusColor = Colors.green;
    } else if (statusLower == "cancelled" || statusLower == "failed") {
      statusColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  border: Border.all(color: statusColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
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
