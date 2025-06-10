import 'package:flutter/material.dart';
import 'package:testapp/scheduled_appointment.dart';
import 'package:testapp/edit_manage_page.dart';
import 'package:testapp/addclinic_magane_page.dart';

class ManageClinicPage extends StatelessWidget {
  final String fee;
  final String doctorName;
  final String address;

  const ManageClinicPage({
    super.key,
    required this.fee,
    required this.doctorName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Manage Clinic",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(46, 51, 69, 1.0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          shadowColor: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Clinic Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Doctor name
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blueAccent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        doctorName,
                        style: const TextStyle(fontSize: 16),
                        softWrap: true, // Optional, true by default
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Fee
                Row(
                  children: [
                    const Icon(Icons.currency_rupee, color: Colors.green),
                    const SizedBox(width: 10),
                    Text(fee, style: const TextStyle(fontSize: 16)),
                  ],
                ),

                const SizedBox(height: 10),

                // Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, color: Colors.redAccent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),

                const Divider(height: 30),

                // Action Buttons
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context,
                        icon: Icons.edit,
                        color: Colors.blue,
                        tooltip: 'Edit',
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditClinicPage(),
                            ),
                          );

                          if (result != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Clinic details updated'),
                              ),
                            );
                            // If you want the updated data to reflect, you'd need to use StatefulWidget
                            // or pass a callback to refresh.
                          }
                        },
                      ),
                      _buildActionButton(
                        context,
                        icon: Icons.people,
                        color: Colors.deepPurple,
                        tooltip: 'Patients',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PatientCardsPage(),
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        context,
                        icon: Icons.delete,
                        color: Colors.red,
                        tooltip: 'Delete',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    24,
                                    24,
                                    24,
                                    16,
                                  ),

                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center, // 👈 Center horizontally

                                    children: const [
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        size: 50,
                                        color: Colors.red,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Delete Clinic',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Are you sure you want to',
                                        textAlign:
                                            TextAlign.center, // 👈 Center text
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'continue?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'This action cannot be undone. Are ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'you sure you want to continue?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actionsPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.black,

                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.red,

                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Clinic deleted',
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'Confirm',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddClinicManagePage()),
          );

          if (result != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('New clinic added')));
          }
        },
        backgroundColor: const Color.fromRGBO(46, 51, 69, 1.0),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Clinic', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
