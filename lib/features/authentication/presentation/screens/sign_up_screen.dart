
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/show_snack_bar.dart';
import 'package:transcation_app/features/authentication/presentation/widgets/sign_in/custome_title_text.dart';

import '../cubits/sign_up_cubit/sign_up_cubit.dart';
import '../cubits/sign_up_cubit/sign_up_state.dart';
import '../../../../core/utils/custom_button.dart';
import '../widgets/sign_up/custome_already_have_an_account_row.dart';
import '../widgets/sign_up/custome_sign_up_input_fields.dart';
import '../widgets/sign_up/custome_sign_up_listner.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {



  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return CustomeSignUpListner(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomeTitleText(
                      title: "إنشاء حساب",
                      animatedText: "أنشئ حسابك الجديد",
                      padding: EdgeInsetsDirectional.only(
                          top: 35.h, bottom: 65.h, end: 35.w, start: 35.w),
                    ),
                   
                   CustomeSignUpInputFields(onSubmit: () => () {}),
                            
                    // Sign-Up Button
                    Column(
                      children: [
                        BlocBuilder<SignUpCubit, SignUpState>(
                          builder: (context, state) {
                            return CustomButton(
                              buttonContent: state.isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      "إنشاء حساب",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.white,
                                      ),
                                    ),
                              animationIndex: 3,
                              onTapButton: () {
                                if (state.isChecked == true) {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.signUp(
                                      name: cubit.nameController.text,
                                      email: cubit.emailController.text,
                                      password: cubit.passwordController.text,
                                      phone: cubit.phoneController.text,
                                    );
                                  }
                                } else {
                                  showSnackBar(context,
                                      "يرجى الموافقة على الشروط والأحكام");
                                }
                              },
                            );
                          },
                        ),
                        verticalSpace(15),
                        CustomeAlreadyHaveAnAccountRow(
                          onTap: () {},
                        ),
                      ],
                    )
                        .animate()
                        .slideY(
                            begin: 1,
                            end: 0,
                            duration: const Duration(milliseconds: 500),
                            delay:
                                const Duration(milliseconds: (4) * 200 + 200))
                        .fadeIn(
                            duration: const Duration(milliseconds: 500),
                            delay:
                                const Duration(milliseconds: (4) * 200 + 200))
                        .then(delay: const Duration(milliseconds: 200)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  const CustomeSignUpInputFields(),
//                           SizedBox(height: 27.h),

//                           // Sign-Up Button
//                           BlocBuilder<SignUpCubit, SignUpState>(
//                             builder: (context, state) {
//                               return state.isLoading
//                                   ? const Center(
//                                       child: CircularProgressIndicator(
//                                         color: AppColor.teal,
//                                       ),
//                                     )
//                                   : CustomButton(
//                                       buttonText: context.l10n.signUpButton,
//                                       onTapButton: () {
//                                         if (state.isChecked == true) {
//                                           if (cubit.formKey.currentState!
//                                               .validate()) {
//                                             cubit.signUp(
//                                               name: cubit.nameController.text,
//                                               email: cubit.emailController.text,
//                                               password:
//                                                   cubit.passwordController.text,
//                                               type: selectedRole,
//                                             );
//                                           }
//                                         } else {
//                                           showSnackBar(context,
//                                               'Please accept terms and conditions');
//                                         }
//                                       },
//                                     );
//                             },
//                           ),
//                           SizedBox(height: 10.h),

//                           // Already have an account
//                           CustomeAlreadyHaveAnAccountRow(
//                             onTap: () {
//                               Navigator.pushReplacementNamed(
//                                   context, RouteNames.signIn);
//                             },
//                           ),
