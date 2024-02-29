import 'package:flutter/material.dart';
import 'package:oho_cart/src/controllers/auth_controller.dart';
import 'package:oho_cart/src/controllers/cart_controller.dart';
import 'package:oho_cart/src/controllers/product_controller.dart';
import 'package:oho_cart/src/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  final MyRouter router = MyRouter();
  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});
  final MyRouter router;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CartController()),
      ],
      child: MaterialApp.router(
        title: 'ohoCart',
        debugShowCheckedModeBanner: false,
        routeInformationParser: router.router.routeInformationParser,
        routeInformationProvider: router.router.routeInformationProvider,
        routerDelegate: router.router.routerDelegate,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
