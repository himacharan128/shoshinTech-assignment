import 'package:flutter/material.dart';
import 'api.dart';
import 'offerScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ApiService.fetchOffers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No offers available.'));
          } else {
            final offers = snapshot.data!;
            return ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return ListTile(
                  onTap: () async {
                    final details = await ApiService.fetchOfferDetails(offer['taskId']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OfferDetailsScreen(offerDetails: details),
                      ),
                    );
                  },
                  title: Text(offer['title']),
                  leading: Image.network(offer['thumbnail']),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Earned: ${offer['earned']}'),
                          Row(
                            children: [
                              Icon(Icons.flash_on),
                              Text(' ${offer['total_lead']}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
