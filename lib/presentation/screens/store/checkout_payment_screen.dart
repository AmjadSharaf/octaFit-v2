import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/input_field.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  const CheckoutPaymentScreen({super.key});

  @override
  State<CheckoutPaymentScreen> createState() =>
      _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  late final TextEditingController _cardCtrl;
  late final TextEditingController _expiryCtrl;
  late final TextEditingController _cvvCtrl;
  late String _selectedMethod;

  @override
  void initState() {
    super.initState();
    final s = context.read<MarketplaceCubit>().state;
    _cardCtrl = TextEditingController(text: s.paymentCardNumber ?? '4242 4242 4242 4242');
    _expiryCtrl = TextEditingController(text: s.paymentExpiry ?? '12/28');
    _cvvCtrl = TextEditingController(text: s.paymentCvv ?? '123');
    _selectedMethod = s.paymentMethod ?? 'Visa';
  }

  @override
  void dispose() {
    _cardCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  void _continue() {
    context.read<MarketplaceCubit>().updatePayment(
          cardNumber: _cardCtrl.text,
          expiry: _expiryCtrl.text,
          cvv: _cvvCtrl.text,
          method: _selectedMethod,
        );
    context.push(AppRoutes.checkoutReview);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Payment', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _StepIndicator(current: 2),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    children: ['Visa', 'Mastercard', 'Apple Pay'].map((m) {
                      return ChipWidget(
                        label: m,
                        active: _selectedMethod == m,
                        onTap: () => setState(() => _selectedMethod = m),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  InputField(
                    label: 'Card Number',
                    controller: _cardCtrl,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.credit_card_rounded),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          label: 'Expiry',
                          controller: _expiryCtrl,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InputField(
                          label: 'CVV',
                          controller: _cvvCtrl,
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const Icon(Icons.lock_rounded, color: AppColors.green, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Your payment info is encrypted and secure',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Review Order',
                    onPressed: _continue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.current});

  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (i) {
        final step = i + 1;
        final active = step <= current;
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
            decoration: BoxDecoration(
              color: active ? AppColors.blue : AppColors.chipInactive,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
