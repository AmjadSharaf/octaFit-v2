import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/input_field.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';

class CheckoutAddressScreen extends StatefulWidget {
  const CheckoutAddressScreen({super.key});

  @override
  State<CheckoutAddressScreen> createState() =>
      _CheckoutAddressScreenState();
}

class _CheckoutAddressScreenState extends State<CheckoutAddressScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _streetCtrl;
  late final TextEditingController _cityCtrl;
  late final TextEditingController _zipCtrl;
  late final TextEditingController _phoneCtrl;

  @override
  void initState() {
    super.initState();
    final s = context.read<MarketplaceCubit>().state;
    _nameCtrl = TextEditingController(text: s.addressFullName ?? 'Alex Johnson');
    _streetCtrl = TextEditingController(text: s.addressStreet ?? '42 Fitness Ave, Apt 12');
    _cityCtrl = TextEditingController(text: s.addressCity ?? 'San Francisco');
    _zipCtrl = TextEditingController(text: s.addressZip ?? '94102');
    _phoneCtrl = TextEditingController(text: s.addressPhone ?? '+1 (555) 012-3456');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _streetCtrl.dispose();
    _cityCtrl.dispose();
    _zipCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _continue() {
    context.read<MarketplaceCubit>().updateAddress(
          fullName: _nameCtrl.text,
          street: _streetCtrl.text,
          city: _cityCtrl.text,
          zip: _zipCtrl.text,
          phone: _phoneCtrl.text,
        );
    context.push(AppRoutes.checkoutPayment);
  }

  @override
  Widget build(BuildContext context) {
    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Shipping Address', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: [
                  _StepIndicator(current: 1),
                  const SizedBox(height: 20),
                  InputField(label: 'Full Name', controller: _nameCtrl),
                  const SizedBox(height: 16),
                  InputField(label: 'Street Address', controller: _streetCtrl),
                  const SizedBox(height: 16),
                  InputField(label: 'City', controller: _cityCtrl),
                  const SizedBox(height: 16),
                  InputField(label: 'ZIP Code', controller: _zipCtrl),
                  const SizedBox(height: 16),
                  InputField(
                    label: 'Phone',
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Continue to Payment',
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
