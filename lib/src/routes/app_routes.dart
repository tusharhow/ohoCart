import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oho_cart/src/controllers/auth_controller.dart';
import 'package:oho_cart/src/views/auth/login_screen.dart';
import 'package:oho_cart/src/views/cart/cart_screen.dart';
import 'package:oho_cart/src/views/detail/detail_screen.dart';
import 'package:oho_cart/src/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class MyRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) async {
      final authController =
          Provider.of<AuthController>(context, listen: false);
      if (await authController.isLogged()) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return slideTransition(animation, child);
            },
          );
        },
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return slideTransition(animation, child);
            },
          );
        },
      ),
      GoRoute(
        path: '/cart',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const CartScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return slideTransition(animation, child);
            },
          );
        },
      ),
      GoRoute(
        path: '/product/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'];

          return CustomTransitionPage(
            key: state.pageKey,
            child: DetailScreen(
              id: id.toString(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return slideTransition(animation, child);
            },
          );
        },
      ),
    ],
  );
}

slideTransition(Animation<double> animation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(animation),
    child: child,
  );
}
