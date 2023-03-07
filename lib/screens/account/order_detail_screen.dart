import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_amazon/configs/themes/ui_parameters.dart';
import 'package:my_amazon/models/order.dart';
import 'package:my_amazon/providers/user_provider.dart';
import 'package:my_amazon/screens/search/search_screen.dart';
import 'package:my_amazon/services/admin_service.dart';
import 'package:my_amazon/widgets/base/custom_button.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = 'order-details-screen';
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  final AdminService adminService = AdminService();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  /// only for admin
  void changeOrderStatus(int currentStatus) {
    adminService.updateOrderStatus(
        context: context,
        status: currentStatus + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: UiParameters.appBarGradient)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(7),
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1)),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                color: Colors.transparent,
                height: 42,
                child: const Icon(
                  Icons.mic,
                  size: 25,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View Order Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Order Date: ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}'),
                    Text('Order Id: ${widget.order.id}'),
                    Text(
                        'Total Price: \$${widget.order.totalPrice.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Purchase Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  'Qty: ${widget.order.quantity[i].toString()}'),
                            ],
                          ))
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Tracking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Stepper(
                      currentStep: currentStep,
                      controlsBuilder: (context, details) {
                        if (user.type == 'admin') {
                          return CustomButton(
                              onTap: () {
                                changeOrderStatus(details.currentStep);
                              },
                              buttonText: 'Done');
                        }
                        return const SizedBox();
                      },
                      steps: [
                        Step(
                            isActive: currentStep > 0,
                            title: const Text('Pending'),
                            content: const Text(
                                'Your order is yet to be delivered.'),
                            state: currentStep > 0
                                ? StepState.complete
                                : StepState.indexed),
                        Step(
                            isActive: currentStep > 1,
                            title: const Text('Completed'),
                            content: const Text(
                                'Your order has been delivered, you are yet to sign.'),
                            state: currentStep > 1
                                ? StepState.complete
                                : StepState.indexed),
                        Step(
                            isActive: currentStep > 2,
                            title: const Text('Received'),
                            content: const Text(
                                'Your order has been delivered and signed by you.'),
                            state: currentStep > 2
                                ? StepState.complete
                                : StepState.indexed),
                        Step(
                            isActive: currentStep >= 3,
                            title: const Text('Delivered'),
                            content: const Text(
                                'Your order has been delivered and signed by you.'),
                            state: currentStep >= 3
                                ? StepState.complete
                                : StepState.indexed),
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
