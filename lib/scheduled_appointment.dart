import 'package:flutter/material.dart';
import 'patient_details_page.dart';

class PatientCardsPage extends StatelessWidget {
  const PatientCardsPage({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointments',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(46, 51, 69, 1.0),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PatientDetailsPage()),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 14),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(
                          icon: Icons.person,
                          iconColor: Colors.blue,
                          label: 'Patient Name',
                          value: patient['name'],
                        ),
                        const SizedBox(height: 10),
                        _infoRow(
                          icon: Icons.transgender,
                          iconColor: Colors.purple,
                          label: 'Age / Gender',
                          value: '${patient['age']} / ${patient['gender']}',
                        ),
                        const SizedBox(height: 10),
                        _infoRow(
                          icon: Icons.calendar_today,
                          iconColor: Colors.indigo,
                          label: 'Appointment',
                          value:
                              '${patient['appointmentDate']} at ${patient['appointmentTime']}',
                        ),
                        const SizedBox(height: 10),
                        _infoRow(
                          icon: Icons.payment,
                          iconColor: Colors.teal,
                          label: 'Payment',
                          value: patient['paymentMethod'],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              patient['status'] == 'Booked'
                                  ? Colors.lightGreen[700]
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          patient['status'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
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
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
