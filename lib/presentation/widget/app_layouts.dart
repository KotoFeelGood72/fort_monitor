import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/widget/app_default_head.dart';
import 'package:fort_monitor/presentation/widget/app_single_head.dart';
import 'package:fort_monitor/presentation/widget/bottom_main_bar.dart';

class AppLayouts extends StatelessWidget {
  const AppLayouts({
    super.key,
    required this.body,
    this.headType = 'default',
    required this.title,
  });

  final Widget body;
  final String headType;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: headType == 'default'
          ? AppDefaultHead(title: title)
          : AppSingleHead(title: title),
      body: body,
      bottomNavigationBar: const BottomMainBar(),
    );
  }
}
