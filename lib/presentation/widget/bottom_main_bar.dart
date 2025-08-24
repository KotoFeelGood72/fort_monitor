import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fort_monitor/presentation/router/app_router.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/screens/developer/main_developer_screen.dart';

class BottomMainBar extends StatelessWidget {
  const BottomMainBar({super.key});

  void _openTelegramSupport(BuildContext context) async {
    const telegramUrl = 'https://t.me/fort_monitor_support';
    try {
      // Пытаемся открыть в Telegram приложении
      final uri = Uri.parse(telegramUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Если не удалось открыть в приложении, открываем в браузере
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка открытия ссылки: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bottomLightBg,
      padding: const EdgeInsets.only(top: 8.0),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _getCurrentIndex(context),
        backgroundColor: AppColors.bottomLightBg,
        onTap: (index) => _onItemTapped(context, index),
        selectedLabelStyle: AppFonts.jostRegular.copyWith(fontSize: 12),
        unselectedLabelStyle: AppFonts.jostRegular.copyWith(fontSize: 12),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        iconSize: 26,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/report.png', width: 26, height: 26),
                const SizedBox(height: 9),
              ],
            ),
            label: 'Отчеты',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/message.png', width: 26, height: 26),
                const SizedBox(height: 9),
              ],
            ),
            label: 'Техподдержка',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/settings.png', width: 26, height: 26),
                const SizedBox(height: 9),
              ],
            ),
            label: 'Разработчик',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/profile.png', width: 26, height: 26),
                const SizedBox(height: 9),
              ],
            ),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final route = context.router.current.name;
    switch (route) {
      case 'MainReportsScreenRoute':
        return 0;
      case 'MainSupportScreenRoute':
        return 1;
      case 'MainDeveloperScreenRoute':
        return 2;
      case 'MainProfileScreenRoute':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.router.push(const MainReportsScreenRoute());
        break;
      case 1:
        // Открываем Telegram для техподдержки
        _openTelegramSupport(context);
        break;
      case 2:
        // Открываем modal sheet о компании
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const AboutCompanyModal(),
        );
        break;
      case 3:
        context.router.push(const MainProfileScreenRoute());
        break;
    }
  }
}
