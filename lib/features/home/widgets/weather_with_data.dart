import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/utils/app_constants.dart';
import 'package:weather/features/weather_cubit/weather_view_model.dart';
import 'package:weather/features/weather_cubit/weather_states.dart';

class WeatherWithData extends StatefulWidget {
  const WeatherWithData({super.key});

  @override
  State<WeatherWithData> createState() => _WeatherWithDataState();
}

class _WeatherWithDataState extends State<WeatherWithData> {
  late WeatherViewModel viewModel;

  @override
  void initState() {
    viewModel = BlocProvider.of<WeatherViewModel>(context);
    // viewModel.getWeather(cityName: cityName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherViewModel, WeatherStates>(
      builder: (context, state) {
        if (state is WeatherSuccessState) {
          var updatedAt = DateTime.fromMillisecondsSinceEpoch(
            state.responseDto.lastUpdatedEboch * 1000,
          );

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: AppConstants.getWeatherGradient(
                state.responseDto.condition,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // The city
                  Text(
                    state.responseDto.name,
                    style: TextTheme.of(context).bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.getWetherTextColor(
                        state.responseDto.condition,
                      ),
                    ),
                  ),

                  //updated at
                  Text(
                    (updatedAt.hour == 12)
                        ? "Uptated at: 12: ${updatedAt.minute} am"
                        : (updatedAt.hour > 12)
                        ? "Uptated at: ${updatedAt.hour - 12}: ${updatedAt.minute} pm"
                        : "Uptated at: ${updatedAt.hour}: ${updatedAt.minute} am",
                    style: TextTheme.of(context).bodySmall!.copyWith(
                      fontSize: 16.sp,
                      color: AppConstants.getWetherTextColor(
                        state.responseDto.condition,
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  //image,temp,min and max
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        "https:${state.responseDto.conditionIcon}",
                        height: 80.h,
                        width: 80.w,
                      ),

                      // temp degree
                      Text(
                        state.responseDto.tempC.toString(),

                        style: TextTheme.of(context).bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppConstants.getWetherTextColor(
                            state.responseDto.condition,
                          ),
                        ),
                      ),

                      //max & min temp
                      Column(
                        children: [
                          Text(
                            "MaxTemp: ${state.responseDto.forecastDayDto.first.maxTempC} ",
                            style: TextTheme.of(context).bodySmall!.copyWith(
                              fontSize: 14.sp,
                              color: AppConstants.getWetherTextColor(
                                state.responseDto.condition,
                              ),
                            ),
                          ),
                          Text(
                            "MinTemp: ${state.responseDto.forecastDayDto.first.minTempC} ",
                            style: TextTheme.of(context).bodySmall!.copyWith(
                              fontSize: 14.sp,
                              color: AppConstants.getWetherTextColor(
                                state.responseDto.condition,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),

                  // weather condition
                  Text(
                    state.responseDto.condition,
                    style: TextTheme.of(context).bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.getWetherTextColor(
                        state.responseDto.condition,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
