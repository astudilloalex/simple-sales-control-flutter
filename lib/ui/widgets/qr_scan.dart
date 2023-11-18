import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScan extends StatelessWidget {
  const QRScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: MobileScanner(
          onDetect: (capture) {
            context.pop(capture.barcodes.firstOrNull?.rawValue);
          },
        ),
      ),
    );
  }
}
