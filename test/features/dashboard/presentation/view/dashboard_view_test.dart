import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_care/features/dashboard/domain/entity/pet_entity.dart';
import 'package:pet_care/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_bloc.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_event.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_state.dart';

class MockDashboardBloc extends MockBloc<DashboardEvent, DashboardState>
    implements DashboardBloc {}

void main() {
  late MockDashboardBloc dashboardBloc;

  setUp(() {
    dashboardBloc = MockDashboardBloc();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<DashboardBloc>(
      create: (context) => dashboardBloc,
      child: const MaterialApp(
        home: Scaffold(body: DashboardView()),
      ),
    );
  }

  testWidgets('Check if DashboardView UI elements are displayed',
      (tester) async {
    when(() => dashboardBloc.state).thenReturn(DashboardLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Find Your'), findsOneWidget);
    expect(find.text('Perfect Pet 🐾'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays error message when DashboardError state is emitted',
      (tester) async {
    when(() => dashboardBloc.state)
        .thenReturn(const DashboardError(message: 'Error loading pets'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Error loading pets'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('Displays a list of pets when DashboardLoaded state is emitted',
      (tester) async {
    final pets = [
      PetEntity(
        id: '1',
        name: 'Buddy',
        type: 'Dog',
        breed: 'Golden Retriever',
        age: '3',
        gender: 'Male',
        weight: '30kg',
        color: 'Golden',
        location: 'New York',
        price: '500',
        description: 'Friendly and playful dog',
        vaccinated: true,
        image: '/images/buddy.jpg',
        available: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      PetEntity(
        id: '2',
        name: 'Mittens',
        type: 'Cat',
        breed: 'Siamese',
        age: '2',
        gender: 'Female',
        weight: '5kg',
        color: 'Brown',
        location: 'Los Angeles',
        price: '300',
        description: 'Loves to cuddle',
        vaccinated: false,
        image: '/images/mittens.jpg',
        available: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    when(() => dashboardBloc.state).thenReturn(DashboardLoaded(pets: pets));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Available Pets (2)'), findsOneWidget);
    expect(find.text('Buddy'), findsOneWidget);
    expect(find.text('Mittens'), findsOneWidget);
  });

  testWidgets('Triggers filtering when category is selected', (tester) async {
    when(() => dashboardBloc.state).thenReturn(const DashboardLoaded(pets: []));

    await tester.pumpWidget(createWidgetUnderTest());

    final categoryButton = find.text('Dog');
    await tester.tap(categoryButton);
    await tester.pumpAndSettle();

    verify(() => dashboardBloc.add(const FilterPetsByTypeEvent('Dog')))
        .called(1);
  });

  testWidgets('Navigates to pet details page when pet card is tapped',
      (tester) async {
    final pets = [
      PetEntity(
        id: '1',
        name: 'Buddy',
        type: 'Dog',
        breed: 'Golden Retriever',
        age: '3',
        gender: 'Male',
        weight: '30kg',
        color: 'Golden',
        location: 'New York',
        price: '500',
        description: 'Friendly and playful dog',
        vaccinated: true,
        image: '/images/buddy.jpg',
        available: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    when(() => dashboardBloc.state).thenReturn(DashboardLoaded(pets: pets));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Buddy'));
    await tester.pumpAndSettle();

    expect(find.text('Buddy'), findsWidgets);
  });

  testWidgets('Hides unavailable pets when filtering', (tester) async {
    final pets = [
      PetEntity(
        id: '1',
        name: 'Buddy',
        type: 'Dog',
        breed: 'Golden Retriever',
        age: '3',
        gender: 'Male',
        weight: '30kg',
        color: 'Golden',
        location: 'New York',
        price: '500',
        description: 'Friendly and playful dog',
        vaccinated: true,
        image: '/images/buddy.jpg',
        available: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      PetEntity(
        id: '2',
        name: 'Mittens',
        type: 'Cat',
        breed: 'Siamese',
        age: '2',
        gender: 'Female',
        weight: '5kg',
        color: 'Brown',
        location: 'Los Angeles',
        price: '300',
        description: 'Loves to cuddle',
        vaccinated: false,
        image: '/images/mittens.jpg',
        available: false, // Unavailable pet
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    when(() => dashboardBloc.state).thenReturn(DashboardLoaded(pets: pets));

    await tester.pumpWidget(createWidgetUnderTest());

    // Verify only available pets are displayed
    expect(find.text('Buddy'), findsOneWidget);
    expect(find.text('Mittens'), findsNothing);
  });
}
