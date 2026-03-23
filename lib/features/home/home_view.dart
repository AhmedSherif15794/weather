import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/utils/app_colors.dart';
import 'package:weather/core/utils/app_constants.dart';
import 'package:weather/core/utils/app_routes.dart';
import 'package:weather/domain/entities/forecast_day_dto.dart';
import 'package:weather/features/cubit/weather_states.dart';
import 'package:weather/features/cubit/weather_view_model.dart';
import 'package:weather/features/home/widgets/custome_box.dart';
import 'package:weather/features/home/widgets/sunrise_sunset_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late WeatherViewModel viewModel;

  @override
  void initState() {
    viewModel = BlocProvider.of<WeatherViewModel>(context);
    viewModel.getWeatherByCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherViewModel, WeatherStates>(
      builder: (context, state) {
        if (state is SuccessState) {
          ForecastDayDto today = state.weather.forecastDayDto.first;
          print(today.sunRise);
          print(today.sunSet);

          print('lat : ${state.weather.lat}, lon : ${state.weather.lon}');

          return RefreshIndicator(
            onRefresh: () async {
              viewModel.getWeatherByCurrentLocation();
            },
            color: AppColors.grey,

            child: Container(
              // width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppConstants.getWeatherBackground(state.weather.condition),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: AppColors.black.withAlpha(60),

                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Scaffold(
                    backgroundColor: AppColors.transparent,
                    appBar: AppBar(
                      backgroundColor: AppColors.transparent,
                      title: // location
                          Text(
                        "${state.weather.name}, ${state.weather.country}",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(fontSize: 20.sp),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.searchView);
                          },
                          icon: Icon(Icons.search, color: AppColors.white),
                        ),
                      ],
                    ),

                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 28.h),
                          // temp & condition
                          Column(
                            children: [
                              // temp
                              Text(
                                "${state.weather.tempC.toInt()}° ",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),

                              // Condition ,max &many
                              Row(
                                spacing: 10.w,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // condition
                                  Text(
                                    state.weather.condition,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),

                                  Text(
                                    '${state.weather.forecastDayDto.first.maxTempC.toInt()}° /${state.weather.forecastDayDto.first.minTempC.toInt()}° ',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 32.h),

                          // other Items
                          Expanded(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                spacing: 12.h,
                                children: [
                                  SizedBox(height: 16.h),

                                  //  hours
                                  SizedBox(
                                    height: 120.h,
                                    child: CustomeBox(
                                      child: ListView.separated(
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(width: 12.w),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: viewModel.hours.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            spacing: 12.h,
                                            children: [
                                              // current hour
                                              Text(
                                                state.weather.localTime
                                                            .substring(0, 13) ==
                                                        viewModel
                                                            .hours[index]
                                                            .time
                                                            .substring(0, 13)
                                                    ? 'now'
                                                    : int.parse(
                                                          viewModel
                                                              .hours[index]
                                                              .time
                                                              .substring(
                                                                11,
                                                                13,
                                                              ),
                                                        ) ==
                                                        00
                                                    ? "12:00 AM"
                                                    : int.parse(
                                                          viewModel
                                                              .hours[index]
                                                              .time
                                                              .substring(
                                                                11,
                                                                13,
                                                              ),
                                                        ) <
                                                        12
                                                    ? " ${viewModel.hours[index].time.substring(11)} AM"
                                                    : int.parse(
                                                              viewModel
                                                                  .hours[index]
                                                                  .time
                                                                  .substring(
                                                                    11,
                                                                    13,
                                                                  ),
                                                            ) -
                                                            12 ==
                                                        0
                                                    ? "12:00 PM"
                                                    : " ${int.parse(viewModel.hours[index].time.substring(11, 13)) - 12}:00 PM",

                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: AppColors.white,
                                                    ),
                                              ),
                                              // weather condition icon
                                              Image.network(
                                                "https:${viewModel.hours[index].conditionIcon}",
                                                height: 30.h,
                                                width: 30.w,
                                                // color: AppColors.white,
                                              ),
                                              // current temp
                                              Text(
                                                "${viewModel.hours[index].tempC.toInt()}°",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: AppColors.white,
                                                    ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                  // sunrise,sunset bar
                                  CustomeBox(
                                    child: Column(
                                      spacing: 8.h,
                                      children: [
                                        // sunrise ,sunset
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "SunRise",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.copyWith(
                                                color: AppColors.white,
                                              ),
                                            ),
                                            Text(
                                              "SunSet",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.copyWith(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // linear progress
                                        SunriseSunsetBar(
                                          now: DateTime.parse(
                                            state.weather.localTime,
                                          ),

                                          sunrise: today.sunRise,
                                          sunset: today.sunSet,
                                        ),
                                        // time for those
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state
                                                  .weather
                                                  .forecastDayDto
                                                  .first
                                                  .sunRise,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.copyWith(
                                                color: AppColors.white,
                                              ),
                                            ),
                                            Text(
                                              state
                                                  .weather
                                                  .forecastDayDto
                                                  .first
                                                  .sunSet,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium!.copyWith(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Comparision between todays and Yesterday
                                  CustomeBox(
                                    child: Column(
                                      spacing: 4.h,
                                      children: [
                                        Text(
                                          'Tomorrow\'s temperature',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: AppColors.white),
                                        ),

                                        Text(
                                          [0, 1].contains(
                                                (state
                                                            .weather
                                                            .forecastDayDto
                                                            .first
                                                            .avgTempC
                                                            .toInt() -
                                                        state
                                                            .weather
                                                            .forecastDayDto[1]
                                                            .avgTempC
                                                            .toInt())
                                                    .abs(),
                                              )
                                              ? 'almost the same as today'
                                              : [2, 3, 4, 5].contains(
                                                (state
                                                        .weather
                                                        .forecastDayDto
                                                        .first
                                                        .avgTempC
                                                        .toInt() -
                                                    state
                                                        .weather
                                                        .forecastDayDto[1]
                                                        .avgTempC
                                                        .toInt()),
                                              )
                                              ? 'a little colder than today'
                                              : [-2, -3, -4, -5].contains(
                                                (state
                                                        .weather
                                                        .forecastDayDto
                                                        .first
                                                        .avgTempC
                                                        .toInt() -
                                                    state
                                                        .weather
                                                        .forecastDayDto[1]
                                                        .avgTempC
                                                        .toInt()),
                                              )
                                              ? 'a little hotter than today'
                                              : state
                                                      .weather
                                                      .forecastDayDto
                                                      .first
                                                      .avgTempC >
                                                  state
                                                      .weather
                                                      .forecastDayDto[1]
                                                      .avgTempC
                                              ? 'colder than today'
                                              : 'hooter than today',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // days
                                  CustomeBox(
                                    child: ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          state.weather.forecastDayDto.length,
                                      separatorBuilder:
                                          (context, index) =>
                                              SizedBox(height: 12.h),
                                      itemBuilder:
                                          (context, index) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // day
                                              Text(
                                                index == 0
                                                    ? "Today      "
                                                    : index == 1
                                                    ? "Tomorrow"
                                                    : DateFormat('dd/MM/yyyy')
                                                        .format(
                                                          DateTime.fromMillisecondsSinceEpoch(
                                                            state
                                                                    .weather
                                                                    .forecastDayDto[index]
                                                                    .dateEpoch *
                                                                1000,
                                                          ),
                                                        )
                                                        .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: AppColors.white,
                                                    ),
                                              ),
                                              // weather icon
                                              Image.network(
                                                "https:${state.weather.forecastDayDto[index].conditionIcon}",
                                                height: 24.h,
                                                width: 24.w,
                                              ),
                                              // temp
                                              Text(
                                                " ${state.weather.forecastDayDto[index].maxTempC.toInt()}° / ${state.weather.forecastDayDto[index].minTempC.toInt()}°",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: AppColors.white,
                                                    ),
                                              ),
                                            ],
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is ErrorState) {
          return SafeArea(
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20.h,

                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 28.sp),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        viewModel.getWeatherByCurrentLocation();
                      },
                      child: Text("Try again"),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: AppColors.white),
          );
        }
      },
    );
  }
}
