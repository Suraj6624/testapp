import 'package:flutter/material.dart';

import 'package:testapp/profile_docsarthi.dart';
import 'package:intl/intl.dart';
import 'package:testapp/appointment.dart';
import 'package:testapp/manage_clinic_page.dart';
import 'package:testapp/scheduled_appointment.dart';

class Docsarthi extends StatefulWidget {
  const Docsarthi({super.key});

  @override
  State<Docsarthi> createState() => _DocsarthiState();
}

class _DocsarthiState extends State<Docsarthi> {
  int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });

  //   if (index == 3) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ProfilePage(),
  //       ), // Your profile screen
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String dayName = DateFormat('EEEE').format(now); // e.g., Thursday
    final String updatedDate = DateFormat('d').format(now); // e.g., 23
    final String updatedMonth = DateFormat('MMMM').format(now); // e.g., May
    final String doctorName = 'Rajeev Ranjan Pandey';

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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white38,
        appBar: AppBar(
          backgroundColor: Colors.white12,
          centerTitle: true, // ✅ This centers the title
          automaticallyImplyLeading: false,
          title: Image.network('https://docsarthi.com/logow.webp', height: 35),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                // color: Colors.white, // White background
                shape: BoxShape.circle, // Circular shape
              ),
              child: SizedBox(
                width: 40, // Set width here
                height: 40, // Set height here
                child: PopupMenuButton<String>(
                  color: Colors.white,
                  icon: Icon(
                    Icons.more_vert, // Vertical 3 dots
                    color: Color.fromRGBO(233, 234, 237, 1),
                    size: 24,
                  ),
                  // Custom icon color
                  onSelected: (value) {
                    if (value == 'dashboard') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Dashboard page click')),
                      );
                    } else if (value == 'logout') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out')),
                      );
                      // Implement logout logic
                    }
                  },
                  itemBuilder:
                      (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'dashboard',
                          child: Text('Dashboard'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'logout',
                          child: Text('Logout'),
                        ),
                      ],
                ),
              ),
            ),

            const SizedBox(width: 10),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              // Section 1: Greeting and Date
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Color.fromRGBO(46, 51, 69, 1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$greeting, ',
                      style: TextStyle(color: Colors.white70),
                    ),

                    Text(
                      'Dr. $doctorName',
                      style: TextStyle(
                        color: Colors.white, // Special color
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // style: TextStyle(color: Colors.white, fontSize: 20),
                    Text(
                      '$dayName, $updatedDate $updatedMonth',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              // Section 2: Stats Grid
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        buildStatCard(
                          'Booked',
                          bookedCount,
                          Icons.person,
                          Colors.blue,
                        ),
                        buildStatCard(
                          'Cancelled',
                          cancelledCount,
                          Icons.person,
                          Colors.redAccent,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        buildStatCard(
                          'Attempted',
                          attemptedCount,
                          Icons.medical_services,
                          const Color.fromARGB(255, 115, 175, 224),
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

              // Section 3: Backend Data Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children:
                      backendDataList.map((item) {
                        return Card(
                          child: ListTile(
                            title: Text(item['title'] ?? 'No Title'),
                            subtitle: Text(item['subtitle'] ?? 'No Details'),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: const Color.fromRGBO(46, 51, 69, 1.0),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            // Handle page navigation
            if (index == 1) {
              // 👇 Navigate to Schedule Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookAppointmentForm()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            } else if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientCardsPage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ManageClinicPage(
                        fee: '500',
                        doctorName: 'Dr. John Doe',
                        address: 'ola road danapur',
                      ),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: 'Consult',
            ),

            // 👇 New schedule item inserted here
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Schedule',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Clinic',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),
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
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: iconColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
