import 'package:flutter/material.dart';
import 'package:nav2/src/shared/routes/api/api_routes.dart';

extension JustifiedLocation on RouteInformation {
  String get justifiedLocation =>
      this.location.split('').last == '/' ? this.location : this.location + '/';
}

extension RouteInformationToApiInformation on RouteInformation {
  ApiInformation get toApiInformation {
    final _segments = [...Uri.parse(this.location).pathSegments];
    var _last = _segments.removeLast();
    final _param = int.tryParse(_last) ?? _last;
    final _location = '/' + _segments.join('/') + '/';
    return _param.runtimeType == int
        ? ApiInformation<int>(
            location: _location,
            param: _param,
          )
        : ApiInformation<String>(
            location: _location,
            param: _param,
          );
  }
}
