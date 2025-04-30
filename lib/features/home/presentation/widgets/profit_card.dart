import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/presentation/bloc/home/home_cubit_cubit.dart';

class ProfitCard extends StatefulWidget {
  const ProfitCard({super.key});

  @override
  State<ProfitCard> createState() => _ProfitCardState();
}

class _ProfitCardState extends State<ProfitCard> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _showOverlay(BuildContext context) {
    _overlayEntry?.remove();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  bool _isOverlayVisible = false;

  void _toggleOverlay(BuildContext context) {
    if (_isOverlayVisible) {
      _hideOverlay();
    } else {
      _showOverlay(context);
    }
    setState(() {
      _isOverlayVisible = !_isOverlayVisible;
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () => _toggleOverlay(context),
            behavior: HitTestBehavior.translucent,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Positioned(
            width: 300, // Increased width for more content
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 50),
              child: Material(
                elevation: 4,
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColor.brandHighlight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'كيف تستخدم التطبيق؟',
                        style: TextStyle(
                          color: AppColor.brandHighlight,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoItem('يتكون من 5 خطط استثمارية'),
                      _buildInfoItem('اودع اموالك، اشترك في الخطة المناسبة، انتظر انقضاء 7 ايام لاستلام رأس المال والربح، يتم معالجة السحب حالا بمدة دقيقة واحدة'),
                      _buildInfoItem('المستخدم لن يتداول، المنصة هي تدير خطط استثمارية، وتطبيقنا ليس تداول ولا يوجد خسارة اموال'),
                      _buildInfoItem('مستشاريين ماليين يديرون المحفظة لأكثر من 200 الف حساب مستثمر في إثراء'),
                      _buildInfoItem('دعم فني مستمر مع اي مشاكل مع المستخدمين'),
                      _buildInfoItem('لأجل الايداع والسحب ينصح في التحدث مع الدعم الفني لضمان اموالك'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Icon(Icons.circle, size: 8, color: AppColor.brandHighlight),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColor.white.withOpacity(0.9),
                fontSize: 14,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'الربح المحقق',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Text(
                        '+${state.user?.profit ?? 0}',
                        style: TextStyle(
                          color: AppColor.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              constraints: BoxConstraints.tightFor(width: 24, height: 24),
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.info_outline,
                color: AppColor.brandHighlight,
                size: 20,
              ),
              onPressed: () => _toggleOverlay(context),
            ),
          ],
        ),
      ),
    );
  }
}
