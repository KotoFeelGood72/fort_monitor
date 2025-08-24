import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/riverpod/supabase_auth_notifier.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/app_layouts.dart';
import 'package:fort_monitor/presentation/widget/default_button.dart';
import 'package:fort_monitor/presentation/widget/icons.dart' as custom_icons;
import 'package:fort_monitor/presentation/widget/inputs/custom_inputs.dart';

@RoutePage()
class MainProfileScreen extends ConsumerStatefulWidget {
  const MainProfileScreen({super.key});

  @override
  ConsumerState<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends ConsumerState<MainProfileScreen> {
  bool _isLoading = false;
  String? _activeField;

  // Контроллеры для полей
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    try {
      _fullNameController.dispose();
      _emailController.dispose();
      _companyController.dispose();
      _positionController.dispose();
      _phoneController.dispose();
      _passwordController.dispose();
    } catch (e) {
      debugPrint('Ошибка при dispose контроллеров: $e');
    }
    super.dispose();
  }

  void _loadUserData() {
    try {
      final user = ref.read(supabaseAuthNotifierProvider).value;
      if (user != null) {
        _emailController.text = user.email ?? '';
        final userData = user.userMetadata;
        _fullNameController.text = userData?['full_name'] ?? '';
        _companyController.text = userData?['company'] ?? '';
        _positionController.text = userData?['position'] ?? '';
        _phoneController.text = userData?['phone'] ?? '';
        _passwordController.text = '*********'; // Скрытый пароль
      }
    } catch (e) {
      debugPrint('Ошибка загрузки данных пользователя: $e');
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final notifier = ref.read(supabaseAuthNotifierProvider.notifier);
      await notifier.updateProfile(
        fullName: _fullNameController.text,
        company: _companyController.text,
        position: _positionController.text,
        phone: _phoneController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Профиль успешно обновлен'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка обновления профиля: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSignOutModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SignOutModal(),
    );
  }

  Future<void> _signOut() async {
    try {
      final notifier = ref.read(supabaseAuthNotifierProvider.notifier);
      await notifier.signOut();
      if (mounted) {
        context.router.replaceNamed('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка выхода: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showDeleteAccountModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DeleteAccountModal(),
    );
  }

  Future<void> _deleteAccount() async {
    try {
      final notifier = ref.read(supabaseAuthNotifierProvider.notifier);
      await notifier.deleteAccount();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Аккаунт удален'),
            backgroundColor: Colors.green,
          ),
        );
        context.router.replaceNamed('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка удаления аккаунта: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required String fieldName,
    bool enabled = true,
    bool showEditButton = true,
  }) {
    final isFieldActive = _activeField == fieldName;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              label,
              style: AppFonts.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              CustomInput(
                controller: controller,
                type: InputType.text,
                hintText: '',
                fontSize: 16,
                textAlign: TextAlign.center,
                enabled: enabled && isFieldActive,
              ),
              if (showEditButton)
                Positioned(
                  right: 12,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: enabled
                        ? () {
                            if (mounted) {
                              setState(() {
                                if (isFieldActive) {
                                  _activeField = null; // Деактивируем поле
                                } else {
                                  _activeField =
                                      fieldName; // Активируем текущее поле
                                }
                              });
                            }
                          }
                        : null,
                    icon: Container(
                      width: 24,
                      height: 24,
                      child: custom_icons.Icons(
                        iconName: isFieldActive ? 'close' : 'edit',
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(supabaseAuthNotifierProvider);

    // Оптимизация: избегаем лишних перестроений
    if (authState.isLoading) {
      return AppLayouts(
        headType: 'default',
        title: 'Профиль',
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return authState.when(
      data: (user) {
        if (user == null) {
          return AppLayouts(
            headType: 'default',
            title: 'Профиль',
            body: const Center(child: Text('Пользователь не авторизован')),
          );
        }

        return AppLayouts(
          headType: 'default',
          title: 'Профиль',
          body: Container(
            color: AppColors.bg,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Поля профиля
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ФИО
                        _buildProfileField(
                          label: 'ФИО',
                          controller: _fullNameController,
                          fieldName: 'fullName',
                        ),

                        // Email
                        _buildProfileField(
                          label: 'E-mail',
                          controller: _emailController,
                          fieldName: 'email',
                          enabled: false, // Email нельзя изменить
                        ),

                        // Компания
                        _buildProfileField(
                          label: 'Компания',
                          controller: _companyController,
                          fieldName: 'company',
                        ),

                        // Должность
                        _buildProfileField(
                          label: 'Должность',
                          controller: _positionController,
                          fieldName: 'position',
                        ),

                        // Телефон
                        _buildProfileField(
                          label: 'Телефон',
                          controller: _phoneController,
                          fieldName: 'phone',
                        ),

                        // Пароль
                        _buildProfileField(
                          label: 'Пароль',
                          controller: _passwordController,
                          fieldName: 'password',
                          enabled: false, // Пароль нельзя изменить здесь
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Кнопки действий
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Кнопка Сохранить
                        DefaultButton(
                          text: 'Сохранить',
                          onPressed: _isLoading ? () {} : _saveProfile,
                          backgroundColor: Color(0xFF4D4D4D),
                          textColor: Colors.white,
                          borderRadius: 20,
                        ),
                        const SizedBox(height: 68),
                        DefaultButton(
                          text: 'Выйти из профиля',
                          onPressed: _isLoading ? () {} : _showSignOutModal,
                          backgroundColor: Color(0xFF4D4D4D),
                          textColor: Colors.white,
                          borderRadius: 20,
                        ),
                        const SizedBox(height: 21),
                        DefaultButton(
                          text: 'Удалить профиль',
                          onPressed: _isLoading
                              ? () {}
                              : _showDeleteAccountModal,
                          backgroundColor: Color(0xFF4D4D4D),
                          textColor: Colors.white,
                          borderRadius: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => AppLayouts(
        headType: 'default',
        title: 'Профиль',
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => AppLayouts(
        headType: 'default',
        title: 'Профиль',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Ошибка загрузки профиля', style: AppFonts.heading3),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: AppFonts.bodyMedium.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignOutModal extends StatelessWidget {
  const SignOutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF333333),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Верхняя белая линия
          Container(
            width: 100,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(top: 12),
          ),

          // Основной контент
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.logout, size: 64, color: Colors.orange),
                const SizedBox(height: 24),
                const Text(
                  'ВЫХОД ИЗ АККАУНТА',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  width: 60,
                  height: 2,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 24),
                ),
                const Text(
                  'Вы уверены, что хотите выйти из аккаунта?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        text: 'Отмена',
                        onPressed: () => Navigator.of(context).pop(),
                        backgroundColor: Colors.grey[200],
                        textColor: Colors.grey[700],
                        borderRadius: 10,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DefaultButton(
                        text: 'Выйти',
                        onPressed: () {
                          Navigator.of(context).pop();
                          final parentState = context
                              .findAncestorStateOfType<
                                _MainProfileScreenState
                              >();
                          if (parentState != null) {
                            parentState._signOut();
                          }
                        },
                        backgroundColor: Colors.orange,
                        textColor: Colors.white,
                        borderRadius: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteAccountModal extends StatelessWidget {
  const DeleteAccountModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF333333),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Верхняя белая линия
          Container(
            width: 100,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(top: 12),
          ),

          // Основной контент
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 24),
                const Text(
                  'УДАЛЕНИЕ АККАУНТА',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  width: 60,
                  height: 2,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 24),
                ),
                const Text(
                  'Вы уверены, что хотите удалить аккаунт?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Это действие нельзя отменить.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        text: 'Отмена',
                        onPressed: () => Navigator.of(context).pop(),
                        backgroundColor: Colors.grey[200],
                        textColor: Colors.grey[700],
                        borderRadius: 10,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DefaultButton(
                        text: 'Удалить',
                        onPressed: () {
                          Navigator.of(context).pop();
                          final parentState = context
                              .findAncestorStateOfType<
                                _MainProfileScreenState
                              >();
                          if (parentState != null) {
                            parentState._deleteAccount();
                          }
                        },
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        borderRadius: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
