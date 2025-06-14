import 'dart:ui';

import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String mobilenumber;
  final String emailid;

  const ReportPage({
    super.key,
    required this.firstname,
    required this.lastname,
    required this.emailid,
    required this.mobilenumber,
  });
  Widget _buildInfoTile(
    IconData icon,
    Color iconColor,
    String label,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Report Page'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInfoTile(
                    Icons.person,
                    Colors.blue,
                    'First Name',
                    firstname,
                  ),

                  _buildInfoTile(
                    Icons.person_outline,
                    Colors.green,
                    'Last Name',
                    lastname,
                  ),

                  _buildInfoTile(
                    Icons.phone,
                    Colors.orange,
                    'Mobile Number',
                    mobilenumber,
                  ),

                  _buildInfoTile(Icons.email, Colors.red, 'Email ID', emailid),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
