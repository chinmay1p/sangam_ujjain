import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'location_service.dart';
import '../models/user_model.dart';

class SMSService {
  // Send SOS SMS to family members
  static Future<void> sendSOSSMS({
    required User user,
    required List<User> familyMembers,
    String? customMessage,
  }) async {
    try {
      // Get current location
      final locationString = await LocationService.getLocationString();
      final googleMapsUrl = await LocationService.getGoogleMapsUrl();
      
      // Create SOS message
      final sosMessage = customMessage ?? 
          '🚨 SOS ALERT from ${user.name} (${user.id})\n\n'
          'Location: $locationString\n'
          'Google Maps: $googleMapsUrl\n\n'
          'This is an emergency. Please help immediately!\n\n'
          'Sent from S.A.N.G.A.M App';

      // Send SMS to each family member
      for (final familyMember in familyMembers) {
        await _sendSMS(
          phoneNumber: familyMember.mobile,
          message: sosMessage,
        );
      }
    } catch (e) {
      throw Exception('Failed to send SOS SMS: $e');
    }
  }

  // Send SMS using device's default SMS app
  static Future<void> _sendSMS({
    required String phoneNumber,
    required String message,
  }) async {
    try {
      // Clean phone number (remove spaces, dashes, etc.)
      final cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
      
      // Create SMS URL
      final smsUrl = 'sms:$cleanPhoneNumber?body=${Uri.encodeComponent(message)}';
      
      // Launch SMS app
      final uri = Uri.parse(smsUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw Exception('Could not launch SMS app');
      }
    } catch (e) {
      throw Exception('Failed to send SMS: $e');
    }
  }

  // Send SMS using Google Cloud SMS API (if you want to use server-side SMS)
  static Future<void> sendSMSViaGoogleCloud({
    required String phoneNumber,
    required String message,
  }) async {
    try {
      // This would require setting up Google Cloud SMS API
      // For now, we'll use the device SMS app
      await _sendSMS(phoneNumber: phoneNumber, message: message);
    } catch (e) {
      throw Exception('Failed to send SMS via Google Cloud: $e');
    }
  }

  // Send test SMS
  static Future<void> sendTestSMS({
    required String phoneNumber,
    required String message,
  }) async {
    try {
      await _sendSMS(phoneNumber: phoneNumber, message: message);
    } catch (e) {
      throw Exception('Failed to send test SMS: $e');
    }
  }

  // Validate phone number format
  static bool isValidPhoneNumber(String phoneNumber) {
    // Basic phone number validation
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    return cleanNumber.length >= 10 && cleanNumber.length <= 15;
  }

  // Format phone number for display
  static String formatPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    if (cleanNumber.startsWith('+')) {
      return cleanNumber;
    } else if (cleanNumber.length == 10) {
      return '+91$cleanNumber'; // Assuming Indian number
    } else {
      return cleanNumber;
    }
  }
}
