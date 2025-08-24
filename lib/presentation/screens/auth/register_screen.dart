import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/icons.dart' as custom_icons;
import 'package:fort_monitor/presentation/riverpod/supabase_auth_notifier.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/router/app_router.dart';

@RoutePage()
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isAgreementChecked = true;

  final _fullNameController = TextEditingController(
    text: 'Иванов Иван Иванович',
  );
  final _emailController = TextEditingController(text: 'info@mail.ru');
  final _companyController = TextEditingController(text: 'Фирма');
  final _positionController = TextEditingController(text: 'менеджер');
  final _phoneController = TextEditingController(text: '+70000000000');
  final _passwordController = TextEditingController(text: '*********');

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _positionController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_isAgreementChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Необходимо согласие на обработку персональных данных'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await ref
          .read(supabaseAuthNotifierProvider.notifier)
          .signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            fullName: _fullNameController.text.trim(),
            company: _companyController.text.trim(),
            position: _positionController.text.trim(),
            phone: _phoneController.text.trim(),
          );

      // Проверяем успешность регистрации
      final authState = ref.read(supabaseAuthNotifierProvider);
      if (authState.hasValue && authState.value != null) {
        // Успешная регистрация - переходим на главный экран
        if (mounted) {
          context.router.replaceAll([const MainScreenRoute()]);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка регистрации: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authLoadingProvider);
    final error = ref.watch(authErrorProvider);

    // Показываем ошибку если есть
    if (error != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
        ref.read(authErrorProvider.notifier).state = null;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Регистрация',
          style: AppFonts.heading2.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // ФИО
                        _buildInputField(
                          label: 'ФИО',
                          controller: _fullNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Введите ФИО';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // E-mail
                        _buildInputField(
                          label: 'E-mail',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Введите email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Введите корректный email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Компания
                        _buildInputField(
                          label: 'Компания',
                          controller: _companyController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Введите название компании';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Должность
                        _buildInputField(
                          label: 'Должность',
                          controller: _positionController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Введите должность';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Телефон
                        _buildInputField(
                          label: 'Телефон',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Введите телефон';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Пароль
                        _buildPasswordField(),

                        const SizedBox(height: 20),

                        // Чекбокс согласия
                        Row(
                          children: [
                            Checkbox(
                              value: _isAgreementChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isAgreementChecked = value ?? false;
                                });
                              },
                              activeColor: AppColors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Согласие на обработку персональных данных',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Кнопка регистрации
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grey,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Зарегистрироваться',
                            style: AppFonts.button.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.bodyMedium.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: AppFonts.bodyMedium.copyWith(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.greyCard,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Пароль',
          style: AppFonts.bodyMedium.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите пароль';
            }
            if (value.length < 6) {
              return 'Пароль должен содержать минимум 6 символов';
            }
            return null;
          },
          style: AppFonts.bodyMedium.copyWith(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.greyCard,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
