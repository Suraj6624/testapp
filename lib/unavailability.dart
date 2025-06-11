import 'package:flutter/material.dart';
import 'setunavailability.dart';

class UnavailabilityPage extends StatefulWidget {
  const UnavailabilityPage({super.key});

  @override
  State<UnavailabilityPage> createState() => _UnavailabilityPageState();
}

class _UnavailabilityPageState extends State<UnavailabilityPage> {
  List<Map<String, String>> unavailabilityList = [];

  void addUnavailability(Map<String, String> data) {
    setState(() {
      unavailabilityList.add(data);
    });
  }

  void deleteUnavailability(int index) {
    setState(() {
      unavailabilityList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,

        title: const Text(
          "Unavailability",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(46, 51, 69, 1.0),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            unavailabilityList.isEmpty
                ? const Center(
                  child: Text(
                    "No unavailability added yet.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                )
                : ListView.separated(
                  itemCount: unavailabilityList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = unavailabilityList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _infoRow(
                            icon: Icons.local_hospital,
                            label: "Clinic",
                            value: item['clinic'] ?? '',
                            iconColor: Colors.blueAccent,
                          ),
                          const SizedBox(height: 10),
                          _infoRow(
                            icon: Icons.calendar_today,
                            label: "Date",
                            value: item['date'] ?? '',
                            iconColor: Colors.green,
                          ),
                          const SizedBox(height: 10),
                          _infoRow(
                            icon: Icons.info_outline,
                            label: "Reason",
                            value: item['reason'] ?? '',
                            iconColor: Colors.orange,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton.icon(
                              onPressed: () => deleteUnavailability(index),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16, right: 16),
        child: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SetUnavailabilityPage()),
            );
            if (result != null && result is Map<String, String>) {
              addUnavailability(result);
            }
          },
          backgroundColor: Colors.white,
          elevation: 3,
          icon: const Icon(Icons.add, color: Colors.black87),
          label: const Text(
            "Add",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Beautified info row
  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
    Color iconColor = Colors.black, // <-- Add this line
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 15, color: Colors.black87),
              children: [
                TextSpan(
                  text: "$label: ",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
