class AppConstants {
  static const String baseUrl = 'http://192.168.1.38:3000';

  // api urls
  static const String signUp = '/api/signup';
  static const String signIn = '/api/signin';
  static const String validateToken = '/api/validate-token';
  static const String getUser = '/';

  static const String addProduct = '/api/admin/add-product';
  static const String getProducts = '/api/admin/products';
  static const String deleteProducts = '/api/admin/delete-product';
  static const String getCategoryProducts = '/api/products';
  static const String searchProducts = '/api/products/search';
  static const String rateProducts = '/api/rate-product';
  static const String dealOfDay = '/api/deals-of-day';
  static const String addProductToCart = '/api/add-to-cart';
  static const String removeFromCart = '/api/remove-from-cart';
  static const String saveUserAddress = '/api/save-user-address';
  static const String placeOrder = '/api/order';
  static const String getOrders = '/api/orders/me';
  static const String getAllOrders = '/api/admin/orders';
  static const String updateOrderStatus = '/api/admin/update-order-status';
  static const String getEarnings = '/api/admin/annalytics';
}
