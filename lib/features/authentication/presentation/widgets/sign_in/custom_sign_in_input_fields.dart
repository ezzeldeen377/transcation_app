
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/helpers/spacer.dart';
import 'package:transcation_app/core/helpers/validators.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:transcation_app/core/utils/custom_text_form_field.dart';

import '../../cubits/sign_in_cubit/sign_in_cubit.dart';
import '../../cubits/sign_in_cubit/sign_in_state.dart';

class CustomSignInInputFields extends StatelessWidget {
  const CustomSignInInputFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          verticalSpace(10),
          CustomTextFormField(
            animationIndex: 0,
            validator: emailValidator,
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            suffixIcon: const Icon(
              Icons.email_outlined,
                            color: AppColor.brandHighlight,

            ),
            controller: cubit.emailController,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
          ),
          SizedBox(height: 15.h),
          Text(
            'Password',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          verticalSpace(10),
          BlocBuilder<SignInCubit, SignInState>(
            builder: (context, state) {
              return CustomTextFormField(
                animationIndex: 1,
                validator: emptyValidator,
                hint: 'Enter your password',
                obscureText: state.isVisible,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<SignInCubit>().changeVisiblePassword();
                  },
                  icon: Icon(
                    state.isVisible
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined,
                                      color: AppColor.brandHighlight,

                  ),
                ),
                controller: cubit.passwordController,
                onSubmitted: (value) {
                  if (cubit.formKey.currentState!.validate()) {
                    context.read<SignInCubit>().login();
                  }
                  print("done");
                },
                textInputAction: TextInputAction.done,
              );
            },
          ),
        ],
      ),
    );
  }
}
