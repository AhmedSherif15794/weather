import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/utils/app_colors.dart';
import 'package:weather/core/utils/app_functions.dart';
import 'package:weather/features/cubit/weather_states.dart';
import 'package:weather/features/cubit/weather_view_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Search",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.black,
            fontSize: 22.sp,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocBuilder<WeatherViewModel, WeatherStates>(
          builder: (context, state) {
            if (state is SuccessState) {
              return Column(
                spacing: 12.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // search
                  TextField(
                    keyboardType: TextInputType.webSearch,
                    style: Theme.of(context).textTheme.bodyLarge,
                    onSubmitted: (value) {
                      viewModel.getWeatherByCityName(value);
                      Navigator.pop(context);
                    },

                    decoration: InputDecoration(
                      border: AppFunctions.buildDecorationBorder(
                        borderColor: AppColors.black.withAlpha(60),
                      ),
                      enabledBorder: AppFunctions.buildDecorationBorder(
                        borderColor: AppColors.black.withAlpha(60),
                      ),
                      focusedBorder: AppFunctions.buildDecorationBorder(
                        borderColor: AppColors.black.withAlpha(60),
                      ),

                      hintText: 'Search a city name',
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      fillColor: AppColors.grey.withAlpha(20),
                      filled: true,
                      prefixIcon: Icon(Icons.search, size: 22.r),
                    ),
                  ),

                  // the current location
                  Text(
                    'The currnet location',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  // the current location tap
                  InkWell(
                    onTap: () {
                      viewModel.getWeatherByCurrentLocation();
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(16.r),
                    child: Container(
                      width: 200.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.grey.withAlpha(40),
                      ),
                      child: Text(
                        viewModel.locationCity,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),

                  // the most famous cities
                  Text(
                    'The Most famous cities',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  // the most famous cities tabs
                  Expanded(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(6.r),
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 110,
                        mainAxisExtent: 40,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                      ),
                      itemBuilder: (context, index) {
                        List<String> citiesNames = [
                          'Cairo',
                          "Alexandria",
                          "London",
                          "Paris",
                          "Tokyo",
                          "New York",
                          "Roma",
                          "Moscow",
                          "Berlin",
                        ];

                        return InkWell(
                          onTap: () {
                            viewModel.getWeatherByCityName(citiesNames[index]);
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: AppColors.grey.withAlpha(40),
                            ),
                            child: Text(
                              citiesNames[index],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
