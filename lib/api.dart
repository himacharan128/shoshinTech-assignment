import 'dart:convert';
import 'package:flutter/services.dart';

class ApiService {
  static Future<List<Map<String, dynamic>>> fetchOffers() async {
    final String jsonString = await rootBundle.loadString('assets/dummy_tasks.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final List<Map<String, dynamic>> offers = List<Map<String, dynamic>>.from(jsonList);
    return offers;
  }

  static Future<Map<String, dynamic>> fetchOfferDetails(String taskId) async {
    final String jsonString = await rootBundle.loadString('assets/dummy_tasks.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final offerDetails = jsonList.firstWhere((offer) => offer['taskId'] == taskId,
        orElse: () => throw Exception('Offer with taskId $taskId not found'));
    return offerDetails;
  }
  static Future<List<Map<String, dynamic>>> fetchTrendingOffers() async {
    final String jsonString = await rootBundle.loadString('assets/dummy_tasks.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final List<Map<String, dynamic>> trendingOffers =
        List<Map<String, dynamic>>.from(jsonList.where((offer) => offer['isTrending'] == true));
    return trendingOffers;
  }
}
