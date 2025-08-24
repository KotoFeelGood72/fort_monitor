import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/app_layouts.dart';
import 'package:fort_monitor/presentation/widget/default_button.dart';

@RoutePage()
class MainDeveloperScreen extends StatelessWidget {
  const MainDeveloperScreen({super.key});

  void _showAboutCompanyModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AboutCompanyModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayouts(
      headType: 'default',
      title: 'Разработчик',
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline, size: 64, color: AppColors.grey),
              const SizedBox(height: 16),
              Text(
                'Информация о разработчике',
                style: AppFonts.heading2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Нажмите кнопку ниже, чтобы узнать больше о компании',
                style: AppFonts.bodyMedium.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              DefaultButton(
                text: 'О компании',
                onPressed: () => _showAboutCompanyModal(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutCompanyModal extends StatelessWidget {
  const AboutCompanyModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF333333), // Темно-серый фон
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                // Верхняя белая линия внутри modal sheet
                Container(
                  width: 100,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(top: 12),
                ),

                // Светло-серый прямоугольник (placeholder для изображения)
                Container(
                  width: double.infinity,
                  height: 217,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0), // Светло-серый
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: Color(0xFF999999),
                    ),
                  ),
                ),

                // Основной контент
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Заголовок
                      const Text(
                        'О КОМПАНИИ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),

                      // Разделительная линия
                      Container(
                        width: 80,
                        height: 3,
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 12, bottom: 32),
                      ),

                      // Текст о компании
                      const Text(
                        'Fort Telecom — один из сильнейших разработчиков электроники, решений в области М2М-технологий, систем безопасности и программного обеспечения в России. Ведущий разработчик и поставщик оборудования ЭРА-ГЛОНАСС для более чем 60 автопроизводителей по всему миру.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Fort Telecom выпускает линейку терминалов FORT и развивает собственную систему мониторинга транспорта Fort Monitor. Компания производит уникальное оборудование для построения необслуживаемых сетей IP-видеонаблюдения под маркой TFortis, разрабатывает и производит первые в России устройства V2X под маркой TEDIX и DSRC-устройства для платных дорог.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Решения Fort Telecom применяются в России, СНГ, Европе, Турции, странах Персидского залива и ряде других регионов.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
