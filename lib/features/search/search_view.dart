import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/utils/app_colors.dart';
import 'package:weather/core/utils/app_constants.dart';
import 'package:weather/core/utils/app_functions.dart';
import 'package:weather/features/weather_cubit/weather_view_model.dart';
import 'package:weather/features/weather_cubit/weather_states.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  static const String routeName = "search";

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late WeatherViewModel viewModel;

  @override
  void initState() {
    viewModel = BlocProvider.of<WeatherViewModel>(context);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.cityController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherViewModel, WeatherStates>(
      listener: (context, state) async {
        if (state is WeatherLoadingState) {
          AppFunctions.loadingDialog(context: context);
        }
        if (state is WeatherSuccessState) {
          AppFunctions.popDialog(context: context);

          await AppFunctions.messageDialog(
            context: context,
            message: 'Search Successed',
          );

          Navigator.pop(context);
        }
        if (state is WeatherErrorState) {
          AppFunctions.popDialog(context: context);

          await AppFunctions.messageDialog(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        String condition = viewModel.condition ?? 'def';
        return Container(
          decoration: BoxDecoration(
            gradient: AppConstants.getWeatherGradient(condition),
          ),
          child: Scaffold(
            appBar: AppBar(title: Text("Search a City")),
            body: Padding(
              padding: EdgeInsets.all(12.r),
              child: Center(
                child: TextField(
                  controller: viewModel.cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppConstants.getWeatherColor(condition),
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppConstants.getWeatherColor(condition),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppConstants.getWeatherColor(condition),
                        width: 2,
                      ),
                    ),

                    contentPadding: EdgeInsets.symmetric(
                      vertical: 22.h,
                      horizontal: 16.w,
                    ),

                    label: Text(
                      "Search",
                      style: TextTheme.of(context).labelLarge,
                    ),

                    hintText: "Enter the City Name",
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),

                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.getWeather(
                          cityName: viewModel.cityController.text,
                        );
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColors.black,
                        size: 22.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
