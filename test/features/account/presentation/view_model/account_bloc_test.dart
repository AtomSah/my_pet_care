import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_care/app/shared_prefs/token_shared_prefs.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/account/domain/entity/user_profile_entity.dart';
import 'package:pet_care/features/account/domain/repository/account_repository.dart';
import 'package:pet_care/features/account/presentation/view_model/account_bloc.dart';
import 'package:pet_care/features/account/presentation/view_model/account_event.dart';

// Mock classes
class MockAccountRepository extends Mock implements IAccountRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late AccountBloc bloc;
  late MockAccountRepository mockRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockRepository = MockAccountRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    bloc = AccountBloc(
      accountRepository: mockRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  tearDown(() {
    bloc.close();
  });

  const testUser = UserProfileEntity(
    id: '1',
    name: 'John Doe',
    email: 'johndoe@example.com',
    phone: '9876543210',
    role: 'user',
    avatar: 'https://example.com/profile.jpg',
  );

  group('AccountBloc', () {
    test('initial state is AccountInitial', () {
      expect(bloc.state, equals(AccountInitial()));
    });

    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading, AccountLoaded] when GetUserProfileEvent is successful',
      build: () {
        when(() => mockRepository.getUserProfile())
            .thenAnswer((_) async => const Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(GetUserProfileEvent()),
      expect: () => [
        AccountLoading(),
        const AccountLoaded(profile: testUser),
      ],
      verify: (_) {
        verify(() => mockRepository.getUserProfile()).called(1);
      },
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading, AccountError] when GetUserProfileEvent fails',
      build: () {
        when(() => mockRepository.getUserProfile()).thenAnswer(
          (_) async =>
              const Left(ApiFailure(message: 'Failed to load profile')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetUserProfileEvent()),
      expect: () => [
        AccountLoading(),
        const AccountError(message: 'Failed to load profile'),
      ],
      verify: (_) {
        verify(() => mockRepository.getUserProfile()).called(1);
      },
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading, AccountUpdated] when UpdateUserProfileEvent is successful',
      build: () {
        when(() => mockRepository.updateUserProfile('John Doe', '9876543210'))
            .thenAnswer((_) async => const Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(
          const UpdateUserProfileEvent(name: 'John Doe', phone: '9876543210')),
      expect: () => [
        AccountLoading(),
        const AccountUpdated(profile: testUser),
      ],
      verify: (_) {
        verify(() => mockRepository.updateUserProfile('John Doe', '9876543210'))
            .called(1);
      },
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading, AccountError] when UpdateUserProfileEvent fails',
      build: () {
        when(() => mockRepository.updateUserProfile('John Doe', '9876543210'))
            .thenAnswer(
                (_) async => const Left(ApiFailure(message: 'Update failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(
          const UpdateUserProfileEvent(name: 'John Doe', phone: '9876543210')),
      expect: () => [
        AccountLoading(),
        const AccountError(message: 'Update failed'),
      ],
      verify: (_) {
        verify(() => mockRepository.updateUserProfile('John Doe', '9876543210'))
            .called(1);
      },
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading, ProfilePictureUploaded] and triggers GetUserProfileEvent when UploadProfilePictureEvent is successful',
      build: () {
        when(() => mockRepository.uploadProfilePicture('path/to/image.jpg'))
            .thenAnswer((_) async =>
                const Right('https://example.com/new-profile.jpg'));
        return bloc;
      },
      act: (bloc) => bloc
          .add(const UploadProfilePictureEvent(filePath: 'path/to/image.jpg')),
      expect: () => [
        AccountLoading(),
        const ProfilePictureUploaded(
            imageUrl: 'https://example.com/new-profile.jpg'),
      ],
      verify: (_) {
        verify(() => mockRepository.uploadProfilePicture('path/to/image.jpg'))
            .called(1);
      },
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading, AccountError] when UploadProfilePictureEvent fails',
      build: () {
        when(() => mockRepository.uploadProfilePicture('path/to/image.jpg'))
            .thenAnswer(
                (_) async => const Left(ApiFailure(message: 'Upload failed')));
        return bloc;
      },
      act: (bloc) => bloc
          .add(const UploadProfilePictureEvent(filePath: 'path/to/image.jpg')),
      expect: () => [
        AccountLoading(),
        const AccountError(message: 'Upload failed'),
      ],
      verify: (_) {
        verify(() => mockRepository.uploadProfilePicture('path/to/image.jpg'))
            .called(1);
      },
    );

    blocTest<AccountBloc, AccountState>(
      'emits LogoutSuccess when LogoutEvent is successful',
      build: () {
        when(() => mockTokenSharedPrefs.deleteToken())
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [
        LogoutSuccess(),
      ],
      verify: (_) {
        verify(() => mockTokenSharedPrefs.deleteToken()).called(1);
      },
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountError] when LogoutEvent fails',
      build: () {
        when(() => mockTokenSharedPrefs.deleteToken()).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Logout failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [
        const AccountError(message: 'Logout failed'),
      ],
      verify: (_) {
        verify(() => mockTokenSharedPrefs.deleteToken()).called(1);
      },
    );
  });
}
