import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String? selectedPlan = 'monthly';
  String? selectedAppointments = '300';

  final List<String> appointmentOptions = [
    '300',
    '600',
    '1000',
    '1500',
    '2500',
    '3000',
    '5000',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subscription",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(46, 51, 69, 1.0),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _benefitsCard(),
              const SizedBox(height: 16),
              _planSelectionCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _benefitsCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Unlock All benefits with Docsarthi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Features Included",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            _featureRow(Icons.flash_on, "Fast Onboarding", Colors.blueAccent),
            _featureRow(
              Icons.local_hospital,
              "Multi-Clinic Management",
              Colors.green,
            ),
            _featureRow(
              Icons.calendar_today,
              "Quick Appointments",
              Colors.deepPurple,
            ),
            _featureRow(
              Icons.notifications_active,
              "Multi-Channel Notifications",
              Colors.orange,
            ),
            _featureRow(
              Icons.payment,
              "Online Payment Integration",
              Colors.teal,
            ),
            _featureRow(Icons.bar_chart, "Advanced Reports", Colors.cyan),
            _featureRow(Icons.widgets, "Easy Widget Integration", Colors.pink),
            _featureRow(Icons.lock, "Secure Patient Data", Colors.redAccent),
          ],
        ),
      ),
    );
  }

  Widget _featureRow(IconData icon, String label, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  Widget _planSelectionCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pick your plan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("No. of appointments/month"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedAppointments,
              items:
                  appointmentOptions.map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
              onChanged:
                  (value) => setState(() => selectedAppointments = value),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _radioPlan(
              title: "Monthly (Valid for 31 days)",
              price: "₹1,299",
              discount: "35% discount",
              discountIcon: Icons.local_offer,
              dayCost: "₹42/day",
              value: 'monthly',
            ),
            const SizedBox(height: 12),
            _radioPlan(
              title: "Yearly (Valid for 365 days)",
              price: "₹12,999",
              discount: "43% discount",
              discountIcon: Icons.local_offer,
              dayCost: "₹36/day",
              subLabel: "₹1,083/month",
              value: 'yearly',
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  "Subscribe Now",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Prices are inclusive of GST (18%)"),
                Text("Cancel anytime, no questions asked"),
                SizedBox(height: 8),
                Text(
                  "Payment Partner",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "RAZORPAY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _radioPlan({
    required String title,
    required String price,
    required String discount,
    required IconData discountIcon,
    required String dayCost,
    String? subLabel,
    required String value,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,

      child: RadioListTile<String>(
        value: value,
        groupValue: selectedPlan,
        onChanged: (val) => setState(() => selectedPlan = val),
        contentPadding: const EdgeInsets.all(12),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subLabel != null) Text(subLabel),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  price,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Icon(discountIcon, color: Colors.green, size: 18),
                const SizedBox(width: 4),
                Text(discount, style: const TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 4),
            Text("Day cost: $dayCost"),
          ],
        ),
      ),
    );
  }
}
