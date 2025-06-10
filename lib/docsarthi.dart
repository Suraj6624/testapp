import 'package:flutter/material.dart';

import 'package:testapp/profile_docsarthi.dart';
import 'package:intl/intl.dart';
import 'package:testapp/appointment.dart';
import 'package:testapp/manage_clinic_page.dart';
import 'package:testapp/scheduled_appointment.dart';
import 'package:testapp/patient_details_page.dart';

import 'package:testapp/registration_page.dart';

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
    final List<Map<String, dynamic>> patients = [
      {
        "patientId": "P001",
        "name": "Rahul Verma",
        "gender": "Male",
        "age": 34,
        "paymentMethod": "Online",
        "appointmentDate": "26 May 2025",
        "appointmentTime": "10:30 AM",
        "status": "Booked",
      },
      {
        "patientId": "P002",
        "name": "Sneha Shah",
        "gender": "Female",
        "age": 29,
        "paymentMethod": "Cash",
        "appointmentDate": "27 May 2025",
        "appointmentTime": "11:15 AM",
        "status": "Booked",
      },
      {
        "patientId": "P003",
        "name": "Amit Kumar",
        "gender": "Male",
        "age": 45,
        "paymentMethod": "Online",
        "appointmentDate": "28 May 2025",
        "appointmentTime": "09:45 AM",
        "status": "Booked",
      },
    ];
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(46, 51, 69, 1),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(46, 51, 69, 1.0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.network(
              'https://docsarthi.com/logow.webp',
              height: 35,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: SizedBox(
                width: 40,
                height: 40,
                child: PopupMenuButton<String>(
                  color: Colors.white,
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white, // white icon
                    size: 24,
                  ),
                  onSelected: (value) {
                    if (value == 'registration') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    } else if (value == 'logout') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out')),
                      );
                    }
                  },
                  itemBuilder:
                      (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'registration',
                          child: Text('registration'),
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
                    SizedBox(height: 14),
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
                    // Section 3: Appointments with Cards
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Appointments',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          PatientCardsPage(), // Replace with your page
                                ),
                              );
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // const SizedBox(height: 10),

                    // Cards displaying patient data
                    ...patients.map(
                      (patient) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientDetailsPage(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Card(
                              elevation: 1.5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildInfoRow(
                                      icon: Icons.person,
                                      label: 'Name',
                                      value: patient['name'],
                                    ),
                                    const SizedBox(height: 6),
                                    buildInfoRow(
                                      icon: Icons.transgender,
                                      label: 'Gender / Age',
                                      value:
                                          '${patient['gender']} / ${patient['age']} yrs',
                                      iconColor: Colors.purple,
                                    ),
                                    const SizedBox(height: 6),
                                    buildInfoRow(
                                      icon: Icons.calendar_today,
                                      label: 'Appointment',
                                      value:
                                          '${patient['appointmentDate']}, ${patient['appointmentTime']}',
                                      iconColor: Colors.indigo,
                                    ),
                                    const SizedBox(height: 6),
                                    buildInfoRow(
                                      icon: Icons.payment,
                                      label: 'Payment Mode',
                                      value: patient['paymentMethod'],
                                      iconColor: Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Section 3: Backend Data Cards
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

  Widget buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color iconColor = Colors.blueGrey,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        label == 'Payment Mode'
            ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.lightGreen[700], // Light green background
                borderRadius: BorderRadius.circular(16), // Rounded corners
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white, // Text color
                ),
              ),
            )
            : Text(value, style: const TextStyle(fontSize: 14)),
      ],
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
        color: Colors.white,
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
