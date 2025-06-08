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
        // iconTheme: const IconThemeData(
        //   color: Colors.white, // 👈 Back arrow color
        // ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 14),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          patient['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                patient['status'] == 'Booked'
                                    ? Colors.green[100]
                                    : Colors.red[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            patient['status'],
                            style: TextStyle(
                              color:
                                  patient['status'] == 'Booked'
                                      ? Colors.green[800]
                                      : Colors.red[800],
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Gender and Age
                    Row(
                      children: [
                        const Icon(Icons.person, size: 18, color: Colors.blue),
                        const SizedBox(width: 6),
                        Text("${patient['gender']} | Age: ${patient['age']}"),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Appointment date and time
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "${patient['appointmentDate']} at ${patient['appointmentTime']}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Payment method
                    Row(
                      children: [
                        const Icon(Icons.payment, size: 18, color: Colors.teal),
                        const SizedBox(width: 6),
                        Text("Payment: ${patient['paymentMethod']}"),
                      ],
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
}
