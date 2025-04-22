import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class GameGifSplash extends StatefulWidget {
  @override
  _GameGifSplashState createState() => _GameGifSplashState();
}

class _GameGifSplashState extends State<GameGifSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation for content
    _fadeController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();

    // Navigate to main screen after splash
    Timer(Duration(seconds: 4), () {
      GoRouter.of(context).go('/mainScreen');
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game Title with glow
              Text(
                "Scrabble Bingo Gaana",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 12,
                      color: Colors.deepPurpleAccent,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // First GIF
              Image.asset(
                'assets/images/Animation - 1745237015864.gif',
                width: 260,
                height: 260,
                fit: BoxFit.contain,
              ),
              // SizedBox(height: 20),
              //
              // // Second GIF
              // Image.asset(
              //   'assets/images/Animation - 1745236375286.gif',
              //   width: 220,
              //   height: 220,
              //   fit: BoxFit.contain,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
