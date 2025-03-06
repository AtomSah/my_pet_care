import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_care/features/auth/presentation/view/register_view.dart';
import 'package:pet_care/features/auth/presentation/view_model/signup/register_bloc.dart';

class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterBloc {}

void main() {
  late MockRegisterBloc registerBloc;

  setUp(() {
    registerBloc = MockRegisterBloc();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<RegisterBloc>(
      create: (context) => registerBloc,
      child: const MaterialApp(
        home: RegistrationScreen(),
      ),
    );
  }

  testWidgets('Check for all UI elements in RegistrationScreen', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Register'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
    expect(find.byIcon(Icons.phone), findsOneWidget);
  });

  testWidgets('Enter user details and submit form', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final nameField = find.byType(TextFormField).at(0);
    final emailField = find.byType(TextFormField).at(1);
    final passwordField = find.byType(TextFormField).at(2);
    final phoneField = find.byType(TextFormField).at(3);
    final registerButton = find.byType(ElevatedButton);

    await tester.enterText(nameField, 'John Doe');
    await tester.enterText(emailField, 'john@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.enterText(phoneField, '1234567890');
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('john@example.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
    expect(find.text('1234567890'), findsOneWidget);
  });

  testWidgets('Check for validation errors when fields are empty', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final registerButton = find.byType(ElevatedButton);
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text('Full name is required'), findsOneWidget);
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
    expect(find.text('Phone number is required'), findsOneWidget);
  });

  testWidgets('Show success message on successful registration', (tester) async {
    when(() => registerBloc.state)
        .thenReturn(RegisterState(isSuccess: true,isLoading: true));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Registration successful!'), findsOneWidget);
  });

  testWidgets('Show loading indicator during registration process', (tester) async {
    when(() => registerBloc.state)
        .thenReturn(RegisterState(isLoading: true, isSuccess: false));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
