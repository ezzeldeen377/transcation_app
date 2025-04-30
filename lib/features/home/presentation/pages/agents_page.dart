import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transcation_app/core/theme/app_color.dart';
import 'package:country_picker/country_picker.dart';
import 'package:transcation_app/features/home/data/models/agent_model.dart';
import 'package:transcation_app/features/home/presentation/widgets/agent_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:transcation_app/features/home/presentation/bloc/agent/agent_cubit.dart';

class AgentsPage extends StatelessWidget {
  const AgentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.darkGray,
        appBar: AppBar(
          backgroundColor: AppColor.darkGray,
          title: Text(
            'الوكلاء',
            style: TextStyle(
              color: AppColor.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCountrySelector(context),
              SizedBox(height: 16.h),
              _buildAgentsList(),
            ],
          ),
        ));
  }

  Widget _buildCountrySelector(BuildContext context) {
    return BlocBuilder<AgentCubit, AgentState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColor.darkGray,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColor.brandHighlight.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.brandHighlight.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: () => _showCountryPicker(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (state.selectedCountry != null) ...[
                      Text(
                        state.selectedCountry!.flagEmoji,
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      SizedBox(width: 12.w),
                    ],
                    Text(
                      state.selectedCountry?.getTranslatedName(context) ??
                          'اختر الدولة',
                      style: TextStyle(
                        color: state.selectedCountry != null
                            ? AppColor.white
                            : AppColor.white.withOpacity(0.7),
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColor.brandHighlight,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAgentsList() {
    return BlocBuilder<AgentCubit, AgentState>(
      builder: (context, state) {
        if (state.selectedCountry == null) {
          return _buildEmptyState();
        }

        if (state.isLoading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.agents.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                'لا يوجد وكلاء في هذه الدولة',
                style: TextStyle(
                  color: AppColor.white.withOpacity(0.7),
                  fontSize: 16.sp,
                ),
              ),
            ),
          );
        }

        return Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              itemCount: state.agents.length,
              itemBuilder: (context, index) {
                final agent = state.agents[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: AgentCard(agent: agent),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.public,
              color: AppColor.brandHighlight.withOpacity(0.7),
              size: 60.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'الرجاء اختيار دولة لعرض الوكلاء',
              style: TextStyle(
                color: AppColor.white.withOpacity(0.7),
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      exclude: ['SR','CH'],
      showPhoneCode: false,
      countryListTheme: CountryListThemeData(
        backgroundColor: AppColor.brandDark,
        textStyle: TextStyle(
          color: AppColor.white,
          fontSize: 14.sp,
        ),
        searchTextStyle: TextStyle(
          color: AppColor.white,
          fontSize: 14.sp,
        ),
        inputDecoration: InputDecoration(
          hintText: 'بحث',
          hintStyle: TextStyle(
            color: AppColor.white.withOpacity(0.7),
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColor.brandHighlight,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: AppColor.brandHighlight.withOpacity(0.3),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: AppColor.brandHighlight.withOpacity(0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: AppColor.brandHighlight,
            ),
          ),
        ),
        bottomSheetHeight: 500.h,
      ),
      onSelect: (country) => _onCountrySelected(context, country),
    );
  }

  void _onCountrySelected(BuildContext context, Country country) {
    context.read<AgentCubit>().getAgents(country: country);
  }
}
