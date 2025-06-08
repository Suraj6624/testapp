import 'package:flutter/material.dart';
import 'package:testapp/appointment.dart';
import 'package:intl/intl.dart';

class Dashboard_Page extends StatelessWidget {
  const Dashboard_Page({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String dayName = DateFormat('EEEE').format(now);
    final String updatedDate = DateFormat('d').format(now);
    final String updatedMonth = DateFormat('MMMM').format(now);
    final String doctorName = 'John Doe';

    final hour = now.hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    final int bookedCount = 10;
    final int cancelledCount = 2;
    final int attemptedCount = 5;
    final int onlinePaymentCount = 8;

    final List<Map<String, String>> backendDataList = [
      {"title": "Follow-up #1", "subtitle": "Today at 10 AM"},
      {"title": "New Patient", "subtitle": "Tomorrow at 3 PM"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search name or phone',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section 1: Greeting
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                color: Color(0xFF2E3345),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dr. $doctorName',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$dayName, $updatedDate $updatedMonth',
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Section 2: Stats Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      buildStatCard(
                        'Booked',
                        bookedCount,
                        Icons.event_available,
                        Colors.blue,
                      ),
                      buildStatCard(
                        'Cancelled',
                        cancelledCount,
                        Icons.cancel,
                        Colors.redAccent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      buildStatCard(
                        'Attempted',
                        attemptedCount,
                        Icons.check_circle,
                        Colors.orange,
                      ),
                      buildStatCard(
                        'Online Payment',
                        onlinePaymentCount,
                        Icons.currency_rupee,
                        Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Section 3: Appointments
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upcoming Appointments',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  ...backendDataList.map((item) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const Icon(
                          Icons.calendar_today,
                          color: Colors.blueAccent,
                        ),
                        title: Text(item['title'] ?? 'No Title'),
                        subtitle: Text(item['subtitle'] ?? 'No Details'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookAppointmentForm()),
          );
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.blue),
      ),
    );
  }

  Widget buildStatCard(
    String label,
    int count,
    IconData icon,
    Color iconColor,
  ) {
    return Expanded(
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 20, color: iconColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
