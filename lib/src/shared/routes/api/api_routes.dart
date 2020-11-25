import 'package:flutter/material.dart';

class ApiInformation<T> extends RouteInformation {
  const ApiInformation({
    this.param,
    String location,
    Object state,
  })  : assert(location != null),
        assert(param != null),
        super(location: location, state: state);
  final T param;
}
