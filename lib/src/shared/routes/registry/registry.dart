import 'package:flutter/material.dart';
import 'package:nav2/src/shared/extensions/route_information.dart';
import 'package:nav2/src/shared/extensions/list.dart';

import 'package:nav2/src/shared/routes/api/api_routes.dart';

typedef Page PageBuilder(RouteInformation info);
typedef Page ApiPageBuilder(ApiInformation info);

class RouteRegistry {
  RouteRegistry({
    @required this.home,
    @required this.unknown,
    this.routes,
    this.apis,
  }) : assert(
            [
              for (RouteInformation i in [home, unknown, ...routes, ...apis])
                i.location
            ].isDistinct(),
            'RouteInformation must not be duplicate');

  final RouteInformation home;
  final RouteInformation unknown;
  final List<RouteInformation> routes;
  final List<RouteInformation> apis;

  bool isAvalable(RouteInformation info) => [
        for (RouteInformation r in [home, unknown, ...routes])
          r.justifiedLocation
      ].contains(info.location);

  RouteInformation isApi(RouteInformation info) {
    final _api = info.toApiInformation;
    return [for (RouteInformation api in apis) api.location]
            .contains(_api.location)
        ? _api
        : unknown;
  }

  RouteInformation call(RouteInformation info) =>
      isAvalable(info) ? info : isApi(info);

  /// this ccan change when null-safety lands

}

class RouteBuilder extends RouteRegistry {
  RouteBuilder({
    @required this.homeBuilder,
    @required this.unknownBuilder,
    @required this.routesBuilders,
    @required this.apisBuilders,
  }) : super(
          home: RouteInformation(location: homeBuilder.key),
          unknown: RouteInformation(location: unknownBuilder.key),
          routes: [
            for (MapEntry<String, PageBuilder> entry in routesBuilders.entries)
              RouteInformation(location: entry.key),
          ],
          apis: [
            for (MapEntry<String, PageBuilder> entry in apisBuilders.entries)
              RouteInformation(location: entry.key),
          ],
        );

  final MapEntry<String, PageBuilder> homeBuilder;
  final MapEntry<String, PageBuilder> unknownBuilder;
  final Map<String, PageBuilder> routesBuilders;
  final Map<String, ApiPageBuilder> apisBuilders;

  List<MapEntry<String, PageBuilder>> get _entries =>
      <MapEntry<String, PageBuilder>>[
        ...routesBuilders.entries,
        homeBuilder,
        unknownBuilder,
      ];

  Page build(RouteInformation info) => info is ApiInformation
      ? apisBuilders[info.location](info)
      : _entries.firstWhere((e) => e.key == info.location);
}

class DefaultRouteRegistry extends RouteRegistry {
  DefaultRouteRegistry({
    @required List<RouteInformation> routes,
    @required List<RouteInformation> apis,
  }) : super(
          routes: routes,
          apis: apis,
          home: const RouteInformation(location: '/'),
          unknown: const RouteInformation(location: '/404/'),
        );
}

class DefaultRouteBuilder extends DefaultRouteRegistry {
  DefaultRouteBuilder({
    @required this.homeBuilder,
    @required this.unknownBuilder,
    @required this.routesBuilders,
    @required this.apisBuilders,
  }) : super(
          routes: [
            for (MapEntry<String, PageBuilder> entry in routesBuilders.entries)
              RouteInformation(location: entry.key),
          ],
          apis: [
            for (MapEntry<String, PageBuilder> entry in apisBuilders.entries)
              RouteInformation(location: entry.key),
          ],
        );
  final PageBuilder homeBuilder;
  final PageBuilder unknownBuilder;
  final Map<String, PageBuilder> routesBuilders;
  final Map<String, ApiPageBuilder> apisBuilders;

  List<MapEntry<String, PageBuilder>> get _entries =>
      <MapEntry<String, PageBuilder>>[
        ...routesBuilders.entries,
        MapEntry<String, PageBuilder>(
          home.location,
          homeBuilder,
        ),
        MapEntry<String, PageBuilder>(
          unknown.location,
          unknownBuilder,
        ),
      ];

  Page build(RouteInformation info) => info is ApiInformation
      ? apisBuilders[info.location](info)
      : _entries.firstWhere((e) => e.key == info.location);
}

// class RouteRegistry {
//   const RouteRegistry({
//     @required this.home,
//     @required this.unknown,
//     this.routes,
//     this.apis,
//   });

//   final RouteInformation home;
//   final RouteInformation unknown;
//   final List<RouteInformation> routes;
//   final List<RouteInformation> apis;

//   RouteInformation isApi(RouteInformation info) {
//     final _api = info.toApiInformation;
//     return [for (RouteInformation api in apis) api.location]
//             .contains(_api.location)
//         ? _api
//         : unknown;
//   }

//   RouteInformation call(RouteInformation info) =>
//       isAvalable(info) ? info : isApi(info);

//   bool isAvalable(RouteInformation info) => [
//         for (RouteInformation r in [home, unknown, ...routes])
//           r.justifiedLocation
//       ].contains(info.location);
// }

// class DefaultRouteRegistry extends RouteRegistry {
//   const DefaultRouteRegistry(this.routes)
//       : super(
//           routes: routes,
//           home: const RouteInformation(location: '/'),
//           unknown: const RouteInformation(location: '/404/'),
//         );
//   final List<RouteInformation> routes;
// }
