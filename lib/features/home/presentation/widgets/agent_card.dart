import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/features/home/data/models/agent_model.dart';
import 'package:transcation_app/features/home/presentation/pages/agents_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgentCard extends StatelessWidget {
  final Agent agent;

  const AgentCard({super.key, required this.agent});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColor.darkGray,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColor.brandHighlight.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            // Optional: Navigate to agent details page
          },
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side with photo and badge

                // Right side with agent info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColor.brandHighlight,
                            size: 14.sp,
                          ),
                          SizedBox(width: 3.w),
                          Flexible(
                            child: Text(
                              '${agent.country} - ${agent.city}',
                              style: TextStyle(
                                color: AppColor.white.withOpacity(0.8),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        agent.name,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 8.h),
                      // Action buttons moved to right side
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (agent.phone != null)
                            _buildIconButton(
                              icon: SvgPicture.asset(
                                'assets/icons/whatsapp.svg',
                                color: Colors.green,
                              ),
                              color: Color(0xFF25D366),
                              onTap: () => _launchUrl(
                                  'whatsapp://send?phone=${agent.phone}'),
                            ),
                          SizedBox(width: 8.w),
                          if (agent.website != null)  // Updated condition
                            _buildIconButton(
                              icon: Icon(
                                Icons.language,
                                color: Colors.blue,
                                size: 18.sp,
                              ),
                              color: Colors.blue,
                              onTap: () => _launchUrl(agent.website!),  // Updated field name
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    // Agent photo with verification badge
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: AppColor.brandDark,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.brandHighlight.withOpacity(0.5),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.brandHighlight.withOpacity(0.2),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColor.white.withOpacity(0.9),
                            size: 30.sp,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(3.sp),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.darkGray,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Badge under photo (moved from right side)
                    SizedBox(height: 8.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColor.brandHighlight.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColor.brandHighlight.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'وكيل معتمد',
                        style: TextStyle(
                          color: AppColor.brandHighlight,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required Widget icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
          padding: EdgeInsets.all(6.sp),
          decoration: BoxDecoration(
            color: AppColor.darkGray,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
            border: Border.all(
              color: color.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: icon),
    );
  }
}
