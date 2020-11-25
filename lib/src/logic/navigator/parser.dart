import 'package:flutter/material.dart';
import 'package:nav2/src/shared/routes/registry/registry.dart';

class RouteParser extends RouteInformationParser<RouteInformation> {
  const RouteParser({this.registry});
  final RouteRegistry registry;

  @override
  Future<RouteInformation> parseRouteInformation(RouteInformation info) async =>
      registry(info);

  @override
  RouteInformation restoreRouteInformation(RouteInformation info) =>
      registry(info);
}
