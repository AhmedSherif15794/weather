import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/caching/cachhelper.dart';
import 'package:weather/core/injectable/di.dart';
import 'package:weather/core/utils/app_routes.dart';
import 'package:weather/core/utils/app_theme.dart';
import 'package:weather/core/utils/my_bloc_obserever.dart';
import 'package:weather/domain/use_cases/weather_use_case.dart';
import 'package:weather/features/cubit/weather_view_model.dart';
import 'package:weather/features/home/home_view.dart';
import 'package:weather/features/home/search/search_view.dart';

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
                (context) => WeatherViewModel(useCase: getIt<WeatherUseCase>()),
            child: MaterialApp(
              routes: {
                AppRoutes.homeView: (_) => HomeView(),
                AppRoutes.searchView: (_) => SearchView(),
              },
              initialRoute: AppRoutes.homeView,

              theme: AppTheme.theme(),
            ),
          ),
    );
  }
}
