import 'package:flutter/material.dart';
import 'add_staff.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  List<Map<String, String>> staffList = [];

  void _addStaff(Map<String, String> staff) {
    setState(() {
      staffList.add(staff);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Staff Details"),
        backgroundColor: const Color.fromRGBO(46, 51, 69, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...staffList.map((staff) => _buildStaffCard(staff)).toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(builder: (context) => const AddStaffPage()),
          );
          if (result != null) {
            _addStaff(result);
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        tooltip: "Add Staff",
      ),
    );
  }

  Widget _buildStaffCard(Map<String, String> staff) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20), // More space between cards
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ), // Better inner padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              staff['name'] ?? 'Staff Name',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 33, 37, 41),
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow("Phone Number", staff['phone']),
            _buildInfoRow("Clinic Assigned", staff['clinic']),
            _buildInfoRow("Status", staff['status']),
            const SizedBox(height: 20),
            Center(
              // Center aligned buttons
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _iconButton(
                    icon: Icons.login,
                    color: Colors.indigo,
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  _iconButton(
                    icon: Icons.edit,
                    color: Colors.orange,
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  _iconButton(
                    icon: Icons.delete,
                    color: Colors.redAccent,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    IconData iconData;
    Color iconColor;

    switch (label) {
      case "Phone Number":
        iconData = Icons.phone;
        iconColor = Colors.green;
        break;
      case "Clinic Assigned":
        iconData = Icons.local_hospital;
        iconColor = Colors.blue;
        break;
      case "Status":
        iconData = Icons.verified_user;
        iconColor = Colors.purple;
        break;
      default:
        iconData = Icons.person;
        iconColor = Colors.teal;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconData, size: 20, color: iconColor),
              const SizedBox(width: 6),
              Text(
                "$label:",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 60, 60, 60),
                ),
              ),
            ],
          ),
          Flexible(
            child: Text(
              value ?? '',
              style: const TextStyle(color: Colors.black87),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
