import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support"),
        backgroundColor: const Color.fromRGBO(46, 51, 69, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSupportCard(
                title: "WhatsApp",
                icon: Icons.chat_bubble, // Alternative icon
                iconColor: Colors.green,
                content: "+91 7089322883",
                onTap: () {
                  // Optionally handle WhatsApp tap
                },
              ),
              const SizedBox(height: 16),
              _buildSupportCard(
                title: "Email",
                icon: Icons.email,
                iconColor: Colors.deepPurple,
                content: "support@docsarthi.com",
                onTap: () {
                  // Optionally handle email tap
                },
              ),
              const SizedBox(height: 16),
              _buildSupportCard(
                title: "Live Chat",
                icon: Icons.chat,
                iconColor: Colors.blue,
                content: "To start live chat click at the bottom right.",
                onTap: () {
                  // Optional tap for info
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger chat functionality
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Opening live chat...")));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.chat),
        tooltip: "Live Chat",
      ),
    );
  }

  Widget _buildSupportCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required String content,
    VoidCallback? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 33, 37, 41),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  Icon(icon, color: iconColor, size: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      content,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
