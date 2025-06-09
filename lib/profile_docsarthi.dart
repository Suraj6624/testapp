import 'package:flutter/material.dart';
import 'package:testapp/dashboard.dart';
import 'package:testapp/scheduled_appointment.dart';
import 'package:testapp/manage_clinic_page.dart';
import 'package:testapp/payment.dart';
import 'package:testapp/subscription_page.dart';
import 'package:testapp/unavailability.dart';
import 'package:testapp/staffs.dart';
import 'package:testapp/support.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget iconLabelItem({
    required IconData icon,

    required String label,
    required VoidCallback onTap,
    Color iconColor = const Color.fromRGBO(46, 51, 69, 1.0),
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 24, color: iconColor),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(), // Push arrow to the far right
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const cardTitleColor = Color.fromRGBO(46, 51, 69, 1.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        backgroundColor: cardTitleColor,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          iconLabelItem(
            icon: Icons.home,
            iconColor: Colors.blue,
            label: 'Dashboard',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard_Page(),
                  ),
                ),
          ),
          iconLabelItem(
            icon: Icons.assignment,
            iconColor: Colors.teal,
            label: 'Appointments',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PatientCardsPage(),
                  ),
                ),
          ),
          iconLabelItem(
            icon: Icons.local_hospital,
            iconColor: Colors.purple,
            label: 'Manage Clinic',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ManageClinicPage(
                          fee: '₹500',
                          doctorName: 'Dr. Rahul Sharma',
                          address: '123 Medical Street, Delhi',
                        ),
                  ),
                ),
          ),
          iconLabelItem(
            icon: Icons.currency_rupee,
            iconColor: Colors.green,
            label: 'Payments',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Payment()),
                ),
          ),
          iconLabelItem(
            icon: Icons.insert_chart,
            iconColor: Colors.orange,
            label: 'Reports',
            onTap: () => showSnack(context, 'Reports clicked'),
            // icon label icon
          ),
          iconLabelItem(
            icon: Icons.not_interested,
            iconColor: Colors.red,
            label: 'Unavailability',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UnavailabilityPage(),
                  ),
                ),
          ),
          iconLabelItem(
            icon: Icons.subscriptions,
            iconColor: Colors.deepOrange,
            label: 'Subscriptions',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubscriptionPage(),
                  ),
                ),
          ),
          iconLabelItem(
            icon: Icons.group,
            iconColor: Colors.indigo,
            label: 'Staffs',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StaffPage()),
                ),
          ),
          iconLabelItem(
            icon: Icons.widgets,
            iconColor: Colors.pink,
            label: 'Widget',
            onTap: () => showSnack(context, 'Widget clicked'),
          ),
          iconLabelItem(
            icon: Icons.support_agent,
            iconColor: Colors.cyan,
            label: 'Supports',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SupportPage()),
                ),
          ),
          iconLabelItem(
            icon: Icons.vpn_key,
            iconColor: Colors.brown,
            label: 'API Key',
            onTap: () => showSnack(context, 'API Key clicked'),
          ),
          iconLabelItem(
            icon: Icons.settings,
            iconColor: Colors.grey,
            label: 'Settings',
            onTap: () => showSnack(context, 'Settings clicked'),
          ),
          const SizedBox(height: 10),
          // Bottom legal links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => showSnack(context, 'Privacy Policy clicked'),
                child: const Text(
                  'Privacy Policy',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () => showSnack(context, 'Terms clicked'),
                child: const Text(
                  'Terms of Service',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
