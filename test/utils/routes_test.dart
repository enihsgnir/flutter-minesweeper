import 'package:flutter_minesweeper/utils/routes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  test("router should contain all routes", () {
    final allRoutes = <String?>{};

    void containSubroutes(List<RouteBase> routes) {
      for (final route in List<GoRoute>.from(routes)) {
        allRoutes.add(route.name);
        if (route.routes.isNotEmpty) {
          containSubroutes(route.routes);
        }
      }
    }

    containSubroutes(router.configuration.routes);

    expect(allRoutes, AppRoute.values.map((e) => e.name).toSet());
  });
}
