import 'package:flutter/material.dart';
import 'package:nav2/src/shared/collections/routes.dart';

enum RouteType {
  unknown,
  home,
  details,
}

abstract class BookRoutePath {
  const BookRoutePath({@required this.type, @required this.info});
  final RouteType type;
  final RouteInformation info;
}

class BookRouteUnknown extends BookRoutePath {
  const BookRouteUnknown()
      : super(
          type: RouteType.unknown,
          info: const RouteInformation(location: Routes.UNKNOWN),
        );
}

class BookRouteHome extends BookRoutePath {
  const BookRouteHome()
      : super(
          type: RouteType.home,
          info: const RouteInformation(location: Routes.HOME),
        );
}

class BookRouteDetails extends BookRoutePath {
  BookRouteDetails(this.id)
      : super(
          type: RouteType.details,
          info: RouteInformation(location: Routes.DETAILS + '$id'),
        );
  final int id;
}
