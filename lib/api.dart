// api_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';

class ApiService {
  static Future<List<Map<String, dynamic>>> fetchOffers() async {
    // Load JSON data from assets
    final String jsonString = await rootBundle.loadString('assets/dummy_tasks.json');

    // Parse JSON
    final List<dynamic> jsonList = json.decode(jsonString);

    // Convert dynamic list to a list of Map<String, dynamic>
    final List<Map<String, dynamic>> offers = List<Map<String, dynamic>>.from(jsonList);

    return offers;
  }

  static Future<Map<String, dynamic>> fetchOfferDetails(String taskId) async {
    // Load JSON data from assets
    final String jsonString = await rootBundle.loadString('assets/dummy_tasks.json');

    // Parse JSON
    final List<dynamic> jsonList = json.decode(jsonString);

    // Find the offer with the matching taskId
    final offerDetails = jsonList.firstWhere((offer) => offer['taskId'] == taskId,
        orElse: () => throw Exception('Offer with taskId $taskId not found'));

    return offerDetails;
  }
}
