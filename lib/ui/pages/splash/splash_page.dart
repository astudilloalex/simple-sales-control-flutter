import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_control/app/app_asset.dart';
import 'package:sales_control/ui/pages/splash/cubits/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SplashCubit>().routeName.then((value) {
      context.goNamed(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAsset.backgroundImage,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(1),
            colorBlendMode: BlendMode.hue,
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
