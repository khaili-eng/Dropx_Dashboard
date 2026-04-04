class EndPoints {
  static const String AllOrder = "/admin/AllOrders";
  static String OrderDet(int userId) {
    return "/admin/orderDetails/$userId";
  }

  static const String customers = "/admin/getallcustomers";
  static String updateUserStatus(int userId) {
    return "/admin/users/$userId/updateuseractivation";
  }
}
