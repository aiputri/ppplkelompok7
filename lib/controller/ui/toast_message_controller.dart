import 'package:flutter/material.dart';
import 'package:sikilap/controller/my_controller.dart';

class ToastMessageController extends MyController {
  final TickerProvider ticker;
  late AnimationController animationController = AnimationController(vsync: ticker, duration: Duration(seconds: 20));

  ToastMessageController(this.ticker);
}
