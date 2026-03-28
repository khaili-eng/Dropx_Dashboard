class EndPoints{
static const String AllOrder = "/admin/AllOrders";
static const String customers ="/admin/getallcustomers";
static String updateUserStatus(int userId){
  return "/admin/users/$userId/updateuseractivation";
}
}