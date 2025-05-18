import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transcation_app/core/routes/routes.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/show_snack_bar.dart';
import 'package:transcation_app/features/authentication/presentation/widgets/sign_in/custome_title_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubits/sign_in_cubit/sign_in_cubit.dart';
import '../cubits/sign_in_cubit/sign_in_state.dart';
import '../../../../core/utils/custom_button.dart';
import '../widgets/sign_in/custom_dont_have_account_row.dart';
import '../widgets/sign_in/custom_sign_in_input_fields.dart';
import '../widgets/sign_in/custom_sign_in_listener.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  final String telegramLink = "https://t.me/EthraaSP";

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();
    return CustomSignInListener(
      child: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: PopScope(
          canPop: false,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomeTitleText(
                          title: 'تسجيل الدخول',
                          animatedText: 'مرحباً بعودتك!',
                          padding: EdgeInsetsDirectional.only(
                              top: 148.h, bottom: 65.h, end: 35.w, start: 35.w),
                        ),
                        const CustomSignInInputFields(),
                        SizedBox(height: 60.h),
                        Column(
                          children: [
                            BlocBuilder<SignInCubit, SignInState>(
                              builder: (context, state) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Center(
                                    child: CustomButton(
                                      buttonContent: state.isLoading ||
                                              state.isAlreadySignIn ||
                                              state.isNotSignIn ||
                                              state.isSuccessSignIn
                                          ? const CircularProgressIndicator()
                                          : Text(
                                              'تسجيل الدخول',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: AppColor.white),
                                            ),
                                      animationIndex: 3,
                                      onTapButton: state.isLoading ||
                                              state.isAlreadySignIn ||
                                              state.isNotSignIn ||
                                              state.isSuccessSignIn
                                          ? null
                                          : () {
                                              if (cubit.formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<SignInCubit>()
                                                    .login();
                                              }
                                            },
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 30.h),
                            CustomDontHaveAccountRow(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteNames.signUp);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 30.h),
                              child: InkWell(
                                onTap: () {
                                  launchUrl(Uri.parse(telegramLink));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    color: AppColor.darkGray,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColor.brandHighlight
                                          .withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/telegram.svg',
                                        height: 24.h,
                                        width: 24.w,
                                        color: AppColor.brandAccent,
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        ' تواصل مع الدعم الفني اذا كنت تواجه مشكله ',
                                        style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                            .animate()
                            .slideY(
                                begin: 1,
                                end: 0,
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(
                                    milliseconds: (3) * 200 + 200))
                            .fadeIn(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(
                                    milliseconds: (3) * 200 + 200))
                            .then(delay: const Duration(milliseconds: 200)),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
