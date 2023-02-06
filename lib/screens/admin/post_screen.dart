import 'package:flutter/material.dart';
import 'package:my_amazon/models/product.dart';
import 'package:my_amazon/screens/admin/add_product_screen.dart';
import 'package:my_amazon/screens/admin/admin_screen.dart';
import 'package:my_amazon/services/admin_service.dart';
import 'package:my_amazon/widgets/account/product_item.dart';
import 'package:my_amazon/widgets/base/loader.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final AdminService adminService = AdminService();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    products = await adminService.getProducts(context: context);
    setState(() {});
  }

  void navigateToAddProduct() {
    Navigator.pushNamedAndRemoveUntil(
        context, AddProductScreen.routeName, (route) => false);
  }

  void deleteProduct(Product product, int index) {
    adminService.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (products != null)
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: products?.length,
              itemBuilder: (context, index) {
                final product = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: ProductItem(imageUrl: product.images[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                            onPressed: () => deleteProduct(product, index),
                            icon: const Icon(Icons.delete_outline))
                      ],
                    )
                  ],
                );
              })
          : const Loader(),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add a Product',
          onPressed: navigateToAddProduct,
          child: const Icon(Icons.add)),
    );
  }
}
