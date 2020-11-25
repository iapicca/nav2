import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav2/src/logic/cubit/navigation/route.dart';

class BookRouterDelegate extends RouterDelegate<RouteInformation>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteInformation> {
  BookRouterDelegate(this.navigatorKey);
  @override
  final navigatorKey;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RouteCubit, List<RouteInformation>>(
        builder: (context, route) => Navigator(
          key: navigatorKey,
          pages: [],
          onPopPage: (Route route, result) => false,
        ),
      );

  @override
  Future<void> setNewRoutePath(RouteInformation path) async {}
}
