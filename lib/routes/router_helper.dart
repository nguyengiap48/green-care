import 'package:get/get.dart';
import 'package:green_care/pages/auth/login_page.dart';
import 'package:green_care/pages/auth/signup_page.dart';
import 'package:green_care/pages/farm_selection_page.dart';
import 'package:green_care/pages/gateway_selection_page.dart';
import 'package:green_care/pages/main/dashboard/node_dashboard_page.dart';
import 'package:green_care/pages/main/main_page.dart';
import 'package:green_care/pages/node_selection_page.dart';

class RouterHelper {
  static const String main = "/";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String farms = "/farms";
  static const String gateways = "/gateways";
  static const String nodes = "/nodes";
  static const String node_dashboard = "/node_dashboard";

  static List<GetPage> routes = [
    GetPage(
      name: login,
      page: () => LoginPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signup,
      page: () => SignupPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: farms,
      page: () => FarmSelectionPage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: gateways,
      page: () => GatewaySelectionPage(farmId: Get.arguments),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: nodes,
      page: () => NodeSelectionPage(gatewayId: Get.arguments),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: main,
      page: () => MainPage(),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
