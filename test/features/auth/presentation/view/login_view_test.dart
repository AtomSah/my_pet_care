import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_care/features/auth/presentation/view/login_view.dart';
import 'package:pet_care/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: MaterialApp(
        home: LoginView(),
      ),
    );
  }

  testWidgets('Check for all UI elements in LoginView', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('PET ME NOW'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.text("Remember Me"), findsOneWidget);
    expect(find.text("Forgot Password?"), findsOneWidget);
    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text("Sign up"), findsOneWidget);
  });

  testWidgets('Enter username and password, then tap login', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final emailField = find.byType(TextField).at(0);
    final passwordField = find.byType(TextField).at(1);
    final loginButton = find.byType(ElevatedButton);

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });

  testWidgets('Check for validation errors when fields are empty', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final loginButton = find.byType(ElevatedButton);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('Please enter username'), findsOneWidget);
    expect(find.text('Please enter password'), findsOneWidget);
  });

  testWidgets('Login success should show progress indicator', (tester) async {
    when(() => loginBloc.state).thenReturn(LoginState(isLoading: true, isSuccess: true));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Tapping Sign Up should navigate to Register Screen', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final signUpButton = find.text('Sign up');
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    verify(() => loginBloc.add(any<LoginEvent>())).called(1);
  });
}
