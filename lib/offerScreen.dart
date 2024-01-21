import 'package:flutter/material.dart';

class OfferDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> offerDetails;

  OfferDetailsScreen({required this.offerDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offerDetails['title']),
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
              'Earned: ${offerDetails['earned']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Total Leads: ${offerDetails['total_lead']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Description: ${offerDetails['shortDesc']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle button click, e.g., launch the offer link
                // For simplicity, just print a message
                print('Button clicked! Launching ${offerDetails['ctaAction']}');
              },
              child: Text(offerDetails['ctaShort']),
            ),
          ],
        ),
      ),
    );
  }
}
