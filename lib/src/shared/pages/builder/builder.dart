import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav2/src/shared/routes/api/api_routes.dart';

abstract class PageBuilder<T extends RouteInformation> {
  const PageBuilder(this.information);
  final T information;
  Page call();
}

class RoutePageBuilder extends PageBuilder<RouteInformation> {
  const RoutePageBuilder(
      {@required RouteInformation information, @required this.child})
      : super(information);
  final Widget child;

  @override
  Page call() => MaterialPage(key: Key(information.location), child: child);
}

class ApiPageBuilder<T> extends PageBuilder<ApiInformation> {
  const ApiPageBuilder({
    @required ApiInformation apiInformation,
    @required this.builder,
  }) : super(apiInformation);
  final Widget Function(T) builder;

  @override
  Page call() => MaterialPage(
        key: Key(information.location),
        child: builder(information.param as T),
      );
}
