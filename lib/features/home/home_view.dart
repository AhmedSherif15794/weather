import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/utils/app_constants.dart';

import 'package:weather/features/weather_cubit/weather_view_model.dart';
import 'package:weather/features/weather_cubit/weather_states.dart';

import 'package:weather/features/search/search_view.dart';
import 'package:weather/features/home/widgets/no_weather_body.dart';

import 'package:weather/features/home/widgets/weather_with_data.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static final String routeName = "home";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late WeatherViewModel viewModel;

  @override
  void initState() {
    viewModel = BlocProvider.of<WeatherViewModel>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherViewModel, WeatherStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Weather"),
            iconTheme: IconThemeData(
              color: AppConstants.getWetherTextColor(
                viewModel.condition ?? "def",
              ),
            ),
            titleTextStyle: TextStyle(
              color: AppConstants.getWetherTextColor(
                viewModel.condition ?? "def",
              ),
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            actionsIconTheme: IconThemeData(
              color: AppConstants.getWetherTextColor(
                viewModel.condition ?? "def",
              ),
              size: 20.r,
            ),

            backgroundColor: AppConstants.getWeatherColor(
              viewModel.condition ?? 'def',
            ),
            // search
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchView.routeName);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body:
              (state is WeatherInitialState)
                  ? NoWeatherBody()
                  : (state is WeatherSuccessState)
                  ? WeatherWithData()
                  : (state is WeatherErrorState)
                  ? Center(child: Text(state.message))
                  : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
