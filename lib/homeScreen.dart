import 'package:flutter/material.dart';
import 'api.dart';
import 'offerScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Widget buildTrendingOffers(BuildContext context, List<Map<String, dynamic>> trendingOffers) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'Trending Offers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendingOffers.length,
              itemBuilder: (context, index) {
                final offer = trendingOffers[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(offer['thumbnail']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('Button clicked! Launching ${offer['ctaAction']}');
                          },
                          child: const Text('Get ₹240'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }



  Widget buildOfferCard(BuildContext context, Map<String, dynamic> offer) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: hexToColor(offer['custom_data']['dominant_color']), width: 4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () async {
          final details = await ApiService.fetchOfferDetails(offer['taskId']);
          var push = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferDetailsScreen(offerDetails: details),
            ),
          );
        },
        title: Text(offer['title']),
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.network(
            offer['thumbnail'],
            fit: BoxFit.cover,
          ),
        ),
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
                    Text(' ${offer['total_lead']}', style: TextStyle(color: Colors.yellow.shade900, fontWeight: FontWeight.w900)),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Text('get ₹240', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shoshin Tech Assignment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: Colors.blue),
                      SizedBox(width: 4),
                      Text(
                        '235',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ApiService.fetchOffers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No offers available.'));
          } else {
            final offers = snapshot.data!;
            final trendingOffers = offers.where((offer) => offer['isTrending'] == true).toList();

            return ListView(
              children: [
                buildTrendingOffers(context, trendingOffers),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.list, // Replace with the actual fire icon
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'More Offers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                ),
                const SizedBox(height: 8),
                ...offers.map((offer) => buildOfferCard(context, offer)),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Gift',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.blue,
      ),
    );
  }
}