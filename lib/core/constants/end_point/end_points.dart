class EndPoints {
  // ignore: constant_identifier_names
  static const String AllOrder = "/admin/AllOrders";
  // ignore: non_constant_identifier_names
  static String OrderDet(int userId) {
    return "/admin/orderDetails/$userId";
  }

  static const String customers = "/admin/getallcustomers";
  static String updateUserStatus(int userId) {
    return "/admin/users/$userId/updateuseractivation";
  }
}
