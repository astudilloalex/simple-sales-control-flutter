import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sales_control/app/app_asset.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAsset.backgroundImage,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 0.0,
            bottom: 0.0,
            right: 0.0,
            left: 0.0,
            child: ColoredBox(color: Colors.black.withOpacity(0.7)),
          ),
          const Positioned(
            bottom: 10.0,
            right: 0.0,
            left: 0.0,
            child: SpinKitPulsingGrid(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
