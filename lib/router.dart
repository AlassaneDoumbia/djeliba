import 'package:djeliba/models/delivery.dart';
import 'package:djeliba/ui/details_screen.dart';
import 'package:djeliba/ui/home.dart';
import 'package:djeliba/ui/login_screen.dart';
import 'package:djeliba/ui/views/login.view.dart';
import 'package:go_router/go_router.dart';

final GoRouter routers = GoRouter(

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
      // routes: <RouteBase>[
      //   GoRoute(
      //     path: 'login',
      //     builder: (context, state) => LoginScreen(),
      //   ),
      //   GoRoute(
      //     path: 'home',
      //     builder: (context, state) => HomeScreen(),
      //   ),
      // ],
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      name: 'details',
      builder: (context, state) => DetailsView(id: state.pathParameters['id']!,),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
  ],
);

