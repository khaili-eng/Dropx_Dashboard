class EndPoints{
static const String login = "/adminlogin";
static const String customers ="/admin/getallcustomers";
static String updateUserStatus(int userId){
  return "/admin/users/$userId/updateuseractivation";
}
}