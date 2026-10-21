// lib/screens/splash_screen.dart
// Initial splash screen with animated loading indicator and branding

import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    _progressTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (mounted) {
        setState(() {
          _progress += 0.02;
          if (_progress >= 1.0) {
            _progress = 1.0;
            _progressTimer?.cancel();
            _navigateToOnboarding();
          }
        });
      }
    });
  }

  void _navigateToOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E2A5E), // Deep Indigo / Navy
              Color(0xFF131A3A),
              Color(0xFF0F172A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40),

              // Center Logo & App Title
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo container with graduation cap & 'C' emblem
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF00ADB5).withOpacity(0.4),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00ADB5).withOpacity(0.25),
                          blurRadius: 24,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Base 'C' letterform
                          Text(
                            'C',
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF00ADB5),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(1, 2),
                                ),
                              ],
                            ),
                          ),
                          // Graduation cap icon on top
                          Positioned(
                            top: 10,
                            right: 12,
                            child: Transform.rotate(
                              angle: -0.15,
                              child: const Icon(
                                Icons.school,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // App Title
                  const Text(
                    'CampusConnect',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Connect  •  Learn  •  Grow',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.7),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),

              // Bottom Section: College Info & Loading Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  children: [
                    const Text(
                      'Riverside College',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Knowledge Builds Better Futures',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.55),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Teal Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 6,
                        child: LinearProgressIndicator(
                          value: _progress,
                          backgroundColor: Colors.white.withOpacity(0.12),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF00ADB5), // Vibrant Teal
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'Loading your campus...',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.5),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
