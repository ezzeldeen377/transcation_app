import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';

class ProfitCard extends StatelessWidget {
  const ProfitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Dark card background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            'الربح المحقق',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          // Left side: Green profit value
          Row(
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Text(
                    '+${state.user?.profit ?? 0}',
                    style: TextStyle(
                      color: AppColor.brandHighlight,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                },
              ),
              Icon(
                Icons.chevron_right,
                color: AppColor.brandHighlight,
              ),
            ],
          ),

          // Right side: Arabic text
        ],
      ),
    );
  }
}
