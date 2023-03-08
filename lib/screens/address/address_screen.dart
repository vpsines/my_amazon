import 'package:flutter/material.dart';
import 'package:my_amazon/configs/themes/ui_parameters.dart';
import 'package:my_amazon/helpers/utils.dart';
import 'package:my_amazon/providers/user_provider.dart';
import 'package:my_amazon/services/address_service.dart';
import 'package:my_amazon/widgets/base/custom_button.dart';
import 'package:my_amazon/widgets/base/custom_textfield.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address-screen';

  final String totalAmount;

  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressService addressService = AddressService();
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context,listen: false).user.address.isEmpty) {
      addressService.saveUserAddress(context: context, address: addressToBeUsed);

    }

    addressService.placeOrder(context: context, totalPrice: double.parse(widget.totalAmount), address: addressToBeUsed);
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context,listen: false).user.address.isEmpty) {
      addressService.saveUserAddress(context: context, address: addressToBeUsed);

    }

    addressService.placeOrder(context: context, totalPrice: double.parse(widget.totalAmount), address: addressToBeUsed);
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isEmpty ||
        pincodeController.text.isEmpty ||
        cityController.text.isEmpty ||
        areaController.text.isEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text}, ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the fields!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: UiParameters.appBarGradient)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                  key: _addressFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextfield(
                        controller: flatBuildingController,
                        hintText: "Flat, House No, Building",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: areaController,
                        hintText: "Area, Street",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: pincodeController,
                        hintText: "Pincode",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: cityController,
                        hintText: "Town/City",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              ApplePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                height: 50,
                margin: const EdgeInsets.only(top: 15),
                paymentItems: paymentItems,
                onPaymentResult: onApplePayResult,
              ),
              const SizedBox(
                height: 10,
              ),
              GooglePayButton(
                onPressed: () => payPressed(address),
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                type: GooglePayButtonType.buy,
                height: 50,
                margin: const EdgeInsets.only(top: 15),
                width: double.infinity,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
