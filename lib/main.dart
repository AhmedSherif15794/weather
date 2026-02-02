import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/caching/cachhelper.dart';
import 'package:weather/core/injectable/di.dart';
import 'package:weather/core/utils/app_colors.dart';
import 'package:weather/core/utils/my_bloc_obserever.dart';
import 'package:weather/domain/use_cases/weather_use_case.dart';
import 'package:weather/features/weather_cubit/weather_view_model.dart';
import 'package:weather/features/home/home_view.dart';
import 'package:weather/features/search/search_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Cachhelper.init();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => BlocProvider(
            create:
                (context) =>
                    WeatherViewModel(weatherUseCase: getIt<WeatherUseCase>()),
            child: MaterialApp(
              routes: {
                HomeView.routeName: (_) => HomeView(),
                SearchView.routeName: (_) => SearchView(),
              },
              initialRoute: HomeView.routeName,

              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  centerTitle: true,
                  // iconTheme: IconThemeData(
                  //   color: AppConstants.getWetherTextColor(condition),
                  // ),
                  // titleTextStyle: TextStyle(
                  //   color: AppConstants.getWetherTextColor(condition),
                  //   fontSize: 20.sp,
                  //   fontWeight: FontWeight.bold,
                  // ),
                  // actionsIconTheme: IconThemeData(
                  //   color: AppConstants.getWetherTextColor(condition),
                  //   size: 20.r,
                  // ),
                  surfaceTintColor: Colors.transparent,
                ),

                textTheme: TextTheme(
                  titleLarge: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  titleMedium: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  titleSmall: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),

                  headlineLarge: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  headlineMedium: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  headlineSmall: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),

                  bodyLarge: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  bodySmall: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),

                  labelLarge: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                  labelMedium: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                  labelSmall: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
