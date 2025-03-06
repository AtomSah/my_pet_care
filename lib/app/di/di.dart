import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_care/app/shared_prefs/token_shared_prefs.dart';
import 'package:pet_care/core/network/api_service.dart';
import 'package:pet_care/core/network/hive_service.dart';
import 'package:pet_care/features/account/data/data_source/account_data_source.dart';
import 'package:pet_care/features/account/domain/repository/account_repository.dart';
import 'package:pet_care/features/account/presentation/view_model/account_bloc.dart';
import 'package:pet_care/features/auth/data/data_source/local_datasource/local_datasource.dart';
import 'package:pet_care/features/auth/data/data_source/remote_datasource/remote_datasource.dart';
import 'package:pet_care/features/auth/data/repositories/user_local_repository.dart';
import 'package:pet_care/features/auth/data/repositories/user_remote_repository.dart';
import 'package:pet_care/features/auth/domain/use_case/create_user_usecase.dart';
import 'package:pet_care/features/auth/domain/use_case/login_usecase.dart';
import 'package:pet_care/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:pet_care/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:pet_care/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:pet_care/features/booked_pets/data/data_source/booking_data_source.dart';
import 'package:pet_care/features/booked_pets/domain/repository/booking_repository.dart';
import 'package:pet_care/features/booked_pets/presentation/view_model/booking_bloc.dart';
import 'package:pet_care/features/dashboard/data/data_source/pet_data_source.dart';
import 'package:pet_care/features/dashboard/domain/repository/pet_repository.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_bloc.dart';
import 'package:pet_care/features/home/presentation/view_model/home_cubit.dart';
import 'package:pet_care/features/onBoarding/presentation/view_model/onboarding_cubit.dart';
import 'package:pet_care/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initDashboardDependencies();
  await _initBookingDependencies();
  await _initAccountDependencies();

  await _initOnBoardingScreenDependencies();
  await _initSplashScreenDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initHiveService() async {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // Remote Data Source
   getIt.registerLazySingleton<Dio>(
    () => ApiService(
      Dio(),
      getIt<TokenSharedPrefs>(),
    ).dio,
  );
}

_initRegisterDependencies() async {
  // Local Data Source
  getIt
      .registerFactory<UserLocalDataSource>(() => UserLocalDataSource(getIt()));

  // Remote Data Source
  getIt.registerFactory<UserRemoteDataSource>(
      () => UserRemoteDataSource(getIt<Dio>()));

  // Local Repository
  getIt.registerLazySingleton<UserLocalRepository>(() =>
      UserLocalRepository(userLocalDataSource: getIt<UserLocalDataSource>()));

  // Remote Repository
  getIt.registerLazySingleton<UserRemoteRepository>(
      () => UserRemoteRepository(getIt<UserRemoteDataSource>()));

  // Usecases
  getIt.registerLazySingleton<CreateUserUsecase>(
    () => CreateUserUsecase(userRepository: getIt<UserRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<UserRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      createUserUsecase: getIt<CreateUserUsecase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
    ),
  );
}

_initOnBoardingScreenDependencies() async {
  getIt.registerFactory(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      getIt<UserRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUsecase: getIt<LoginUsecase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory(
    () => SplashCubit(getIt<OnboardingCubit>()),
  );
}

_initDashboardDependencies() {
  // Data Sources
  getIt.registerFactory<IPetDataSource>(
    () => PetRemoteDataSource(getIt<Dio>()),
  );

  // Repository
  getIt.registerLazySingleton<IPetRepository>(
    () => PetRepository(getIt<IPetDataSource>()),
  );

  // Bloc
  getIt.registerFactory<DashboardBloc>(
    () => DashboardBloc(
      petRepository: getIt<IPetRepository>(),
    ),
  );
}

_initBookingDependencies() {
  // Data Source
  getIt.registerFactory<IBookingDataSource>(
    () => BookingRemoteDataSource(getIt<Dio>()),
  );

  // Repository
  getIt.registerLazySingleton<IBookingRepository>(
    () => BookingRepository(getIt<IBookingDataSource>()),
  );

  // Bloc
  getIt.registerFactory<BookingBloc>(
    () => BookingBloc(
      bookingRepository: getIt<IBookingRepository>(),
    ),
  );
}

_initAccountDependencies() {
  // Data Source
  getIt.registerFactory<IAccountDataSource>(
    () => AccountRemoteDataSource(getIt<Dio>()),
  );

  // Repository
  getIt.registerLazySingleton<IAccountRepository>(
    () => AccountRepository(getIt<IAccountDataSource>()),
  );

  // Bloc
  getIt.registerFactory<AccountBloc>(
    () => AccountBloc(
      accountRepository: getIt<IAccountRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );
}