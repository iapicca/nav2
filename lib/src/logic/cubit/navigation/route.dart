import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav2/src/shared/extensions/route_information.dart';
import 'package:nav2/src/shared/routes/registry/registry.dart';

class RouteCubit extends Cubit<List<RouteInformation>> {
  RouteCubit(this._registry) : super([_registry.home]);
  final RouteRegistry _registry;

  static RouteCubit of(BuildContext context) => context.read<RouteCubit>();

  void push(RouteInformation info) {
    final _stack = state;
    _stack.add(_registry(info));
    emit(_stack);
  }

  void pushBelow(RouteInformation info) {
    final _stack = state;
    _stack.insert(
      _stack.length > 3 ? _stack.length - 2 : 1,
      _registry(info),
    );
    emit(_stack);
  }

  void pushMulti(List<RouteInformation> infoList) {
    final _stack = state;
    for (RouteInformation info in infoList) {
      _stack.add(info);
      if (info.justifiedLocation == _registry.unknown.justifiedLocation) {
        break;
      }
    }
    emit(_stack);
  }

  void pop(RouteInformation info) {
    final _stack = state;
    if (_stack.contains(info)) {
      _stack.remove(info);
    }
    emit(_stack);
  }

  void pushUntil(RouteInformation info) {
    final _stack = state;
    if (_stack.contains(info)) {
      final _index = _stack.indexOf(info);
      _stack.removeRange(_index + 1, _stack.length - 1);
    }
    emit(_stack);
  }
}
