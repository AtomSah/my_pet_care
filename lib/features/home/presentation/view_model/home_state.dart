import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/features/account/presentation/view/account_view.dart';
import 'package:pet_care/features/booking/presentation/view/bookings_list_view.dart';
import 'package:pet_care/features/dashboard/presentation/view/dashboard_view.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      views: [
        DashboardView(),
        BookingsListView(),
        AccountView(),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
