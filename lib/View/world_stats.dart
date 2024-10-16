import 'package:flutter/material.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});


  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
