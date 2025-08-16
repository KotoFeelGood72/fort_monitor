import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class CustomFileUpload extends StatelessWidget {
  final String label;
  final String? fileName;
  final Function(PlatformFile)? onFileSelected;
  final Function()? onFileRemoved;
  final bool isRequired;
  final bool enabled;

  const CustomFileUpload({
    super.key,
    required this.label,
    this.fileName,
    this.onFileSelected,
    this.onFileRemoved,
    this.isRequired = false,
    this.enabled = true,
  });

  Future<void> _pickFile(BuildContext context) async {
    if (!enabled) return;

    try {
      // Попробуем несколько способов выбора файла
      FilePickerResult? result;

      try {
        // Сначала попробуем с типом any
        result = await FilePicker.platform.pickFiles(
          type: FileType.any,
          allowMultiple: false,
        );
      } catch (e) {
        print('First attempt failed: $e');
        // Если не получилось, попробуем без указания типа
        result = await FilePicker.platform.pickFiles(allowMultiple: false);
      }

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        print('File selected: ${file.name}, size: ${file.size} bytes');
        onFileSelected?.call(file);
      }
    } catch (e) {
      print('Error picking file: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при выборе файла: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null && fileName!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: hasFile ? null : () => _pickFile(context),
          child: Container(
            child: Row(
              spacing: 9,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  child: Image.asset(
                    'assets/images/uploadFile.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ),
                if (hasFile) ...[
                  Text(
                    fileName!,
                    style: AppFonts.jostMedium.copyWith(color: Colors.black87),
                  ),
                ] else ...[
                  Text(
                    'Прикрепить счета (в формате PDF)',
                    style: AppFonts.bodyLarge.copyWith(color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
