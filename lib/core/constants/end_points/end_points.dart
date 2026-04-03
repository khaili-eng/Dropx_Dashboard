class EndPoints{
static const String login = "/adminlogin";
static const String customers ="/admin/getallcustomers";
static String updateUserStatus(int userId){  return "/admin/users/$userId/updateuseractivation";}
static const String createAdv = "/admin/ads/store-ads";
static const String getAllAdv = "/admin/all-ads";
static  String updateAdv(int id)=>"/admin/ads/update-ads/$id";
static const String createDriver = " /admin/driver/storeDriver";
static String resetDriverOrRestaurantPassword(int id)=>"admin/driverandresturant/resetDriverOrResturantPassword/$id ";
static const String getAllDrivers = "/admin/driver/desplayalldriver";
static const String getDriversByCity = "/admin/driver/getDriversByCity";
static const String getAllDriversActive = "/admin/driver/desplayalldriverActive";
static const String getActiveDriversByCity = "/admin/driver/getActiveWorkingDriversByCity";
static const String getCurrentDriverTurn = "/admin/driver/getCurrentDriverInTurn";


}