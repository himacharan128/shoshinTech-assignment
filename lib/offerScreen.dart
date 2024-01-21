import 'package:flutter/material.dart';

class OfferDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> offerDetails;

  OfferDetailsScreen({required this.offerDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offerDetails['title']),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              offerDetails['custom_data']['wall_url'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Description: ${offerDetails['shortDesc']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            const Text(
              'Steps (1/4)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            buildStep('Install the application', '20/-', true),
            buildStep('Complete 3 offers', '20/-', false),
            buildStep('Refer Workstation to friend', '20/-', false),
            buildStep('Withdraw first amount', '20/-', false),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.flash_on,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '${offerDetails['total_lead']} users have already participated',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('Button clicked! Launching ${offerDetails['ctaAction']}');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    offerDetails['ctaShort'],
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildStep(String title, String reward, bool completed) {
    final steps = offerDetails['custom_data']['steps'] as List<String>? ?? [];

    Color borderColor;
    IconData icon;
    Color iconColor;

    if (title == 'Install the application' && completed) {
      // First step (completed)
      borderColor = Colors.green;
      icon = Icons.check; // Green tick
      iconColor = Colors.green;
    } else if (title == 'Complete 3 offers') {
      // Second step (highlighted)
      borderColor = Colors.yellow.shade900;
      icon = Icons.timer; // Yellow timer
      iconColor = Colors.yellow.shade900;
    } else {
      // Third and fourth steps
      borderColor = Colors.grey;
      icon = Icons.circle; // Grey circle
      iconColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 4.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, decoration: completed ? TextDecoration.lineThrough : null),
          ),
          Text(
            '₹ $reward',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
