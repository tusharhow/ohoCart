import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oho_cart/src/controllers/auth_controller.dart';
import 'package:oho_cart/src/controllers/cart_controller.dart';
import 'package:oho_cart/src/controllers/product_controller.dart';
import 'package:oho_cart/src/widgets/product_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthController authController = AuthController();
  final CartController cartController = CartController();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            FutureBuilder(
              future: authController.getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Image.network(
                            snapshot.data!.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snapshot.data!.username!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                context.go('/');
              },
            ),
            ListTile(
              title: const Text('Cart'),
              onTap: () {
                context.go('/cart');
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                authController.logout();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('ohoCart'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldState.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  context.go('/cart');
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Consumer<CartController>(
                    builder: (context, cartController, child) {
                      return Text(
                        cartController.cartItems.length.toString() ?? '0',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              authController.logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<ProductController>().searchProducts('');
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
                onChanged: (value) {
                  context.read<ProductController>().searchProducts(value);
                },
              ),
            ),
            const SizedBox(height: 16 * 2),
            Consumer<ProductController>(
                builder: (context, productController, child) {
              return productController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: productController.products.length,
                      itemBuilder: (context, index) {
                        final product = productController.products[index];

                        return InkWell(
                          onTap: () {
                            context.go('/login');
                          },
                          child: ProductItem(
                            product: product,
                            cartController: cartController,
                          ),
                        );
                      },
                    );
            })
          ],
        ),
      ),
    );
  }
}
