import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shomoshotime/management.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  // Initialize Stripe with your publishable key
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';

  // Set URL scheme for iOS return URL
  Stripe.urlScheme = 'flutterstripe';

  // Apply Stripe settings WITHOUT merchant identifier for now
  await Stripe.instance.applySettings();

  runApp(Management());
}
