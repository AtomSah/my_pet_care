import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app/di/di.dart';
import 'package:pet_care/core/theme/app_theme.dart';
import 'package:pet_care/features/account/presentation/view_model/account_bloc.dart';
import 'package:pet_care/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:pet_care/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:pet_care/features/booking/presentation/view_model/booking_bloc.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_bloc.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_event.dart';
import 'package:pet_care/features/home/presentation/view_model/home_cubit.dart';
import 'package:pet_care/features/splash/presentation/view/splash_view.dart';
import 'package:pet_care/features/splash/presentation/view_model/splash_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => getIt<SplashCubit>(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => getIt<HomeCubit>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => getIt<RegisterBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider<DashboardBloc>(
          create: (_) => getIt<DashboardBloc>()..add(LoadPetsEvent()),
        ),
        BlocProvider<BookingBloc>(
          create: (_) => getIt<BookingBloc>(),
        ),
        BlocProvider<AccountBloc>(
          create: (_) => getIt<AccountBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet Care',
        theme: getApplicationTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
