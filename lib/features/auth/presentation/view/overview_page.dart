import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maadati/core/components/ActivityComponents/activitySection_component.dart';
import 'package:maadati/core/components/GridComponents/gridSection_component.dart';
import 'package:maadati/core/components/header_component.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/constants/app_route/app_route.dart';
import 'package:maadati/core/cubits/restaurant_cubit.dart';
import 'package:maadati/core/responsive/responsive.dart';
import 'package:maadati/core/states/restaurant_state.dart';
import 'package:maadati/core/widgets/side_drawer.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController cityController = TextEditingController();
final TextEditingController commissionController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
final TextEditingController workingHoursStartController =
    TextEditingController();
final TextEditingController workingHoursEndController = TextEditingController();

List<dynamic> images = [];
String getImageUrl(String? path) {
  if (path == null || path.isEmpty)
    return 'https://images.unsplash.com/photo-1537047902294-62a40c20a6ae?w=500&q=80';

  if (path.startsWith('http')) return path;

  return "http://127.0.0.1:8000/storage/$path";
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    Widget buildField(
      String label,
      IconData icon,
      TextEditingController controller, {
      bool isPassword = false,
    }) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: AppColor.color4),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );
    }

    Future pickImages(StateSetter setSheetState) async {
      final picker = ImagePicker();
      final picked = await picker.pickMultiImage();
      if (picked.isNotEmpty) {
        setSheetState(() {
          images = picked.cast<dynamic>();
        });
      }
    }

    void showAddRestaurantSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        builder:
            (context) => StatefulBuilder(
              builder: (context, setSheetState) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.9,
                  expand: false,
                  builder:
                      (_, scrollController) => ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(20),
                        children: [
                          const Text(
                            "Add New Restaurant",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildField("Full Name", Icons.person, nameController),
                          buildField(
                            "Phone Number",
                            Icons.phone,
                            phoneController,
                          ),
                          buildField(
                            "Password",
                            Icons.lock,
                            passController,
                            isPassword: true,
                          ),
                          buildField(
                            "City",
                            Icons.location_city,
                            cityController,
                          ),
                          buildField(
                            "Commission Value",
                            Icons.percent,
                            commissionController,
                          ),
                          buildField(
                            "Description",
                            Icons.description,
                            descriptionController,
                          ),
                          buildField(
                            "Working Hours Start",
                            Icons.access_time,
                            workingHoursStartController,
                          ),
                          buildField(
                            "Working Hours End",
                            Icons.access_time,
                            workingHoursEndController,
                          ),
                          GestureDetector(
                            onTap: () => pickImages(setSheetState),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:
                                    images.isEmpty
                                        ? const Center(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                          ),
                                        )
                                        : kIsWeb
                                        ? Image.network(
                                          images[0].path,
                                          fit: BoxFit.cover,
                                        )
                                        : Image.network(
                                          images[0].path,
                                          fit: BoxFit.cover,
                                        ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: () {
                              if (nameController.text.isEmpty ||
                                  images.isEmpty) {
                                return;
                              }

                              context.read<RestaurantCubit>().storeRestaurant(
                                fullname: nameController.text,
                                phone: phoneController.text,
                                password: passController.text,
                                city: cityController.text,
                                commissionValue: commissionController.text,
                                images: images,
                                description: descriptionController.text,
                                workingHoursStart:
                                    workingHoursStartController.text,
                                workingHoursEnd: workingHoursEndController.text,
                                commissionType: "fixed",
                              );
                              Navigator.pop(context);
                            },
                            child: const Text("Save Restaurant"),
                          ),
                        ],
                      ),
                );
              },
            ),
      );
    }

    return Scaffold(
      key: drawerKey,
      drawer: SizedBox(
        width: 250,
        child: SideDrawer(currentRoute: AppRoute.overview),
      ),
      appBar:
          !Responsive.isDesktop(context)
              ? AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    drawerKey.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: AppColor.color4),
                ),
                title: const Text(
                  "Overview",
                  style: TextStyle(color: Colors.black),
                ),
              )
              : const PreferredSize(
                preferredSize: Size.zero,
                child: SizedBox(),
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddRestaurantSheet(context),
        backgroundColor: AppColor.color4,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add Restaurant",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: AppColor.color1,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 1,
                child: SideDrawer(currentRoute: AppRoute.overview),
              ),

            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 20 : 40,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  const Header(),
                    const SizedBox(height: 25),
                    const Text(
                      "Overview Management",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    BlocBuilder<RestaurantCubit, RestaurantState>(
                      builder: (context, state) {
                        if (state is RestaurantLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is RestaurantError) {
                          return Center(child: Text(state.message));
                        }
                        if (state is RestaurantLoaded) {
                          final restaurants = state.restaurants;
                          return Column(
                            children: [
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Available Restaurants",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap:
                                                () =>
                                                    context
                                                        .read<RestaurantCubit>()
                                                        .getAllRestaurants(),
                                            child: const Text(
                                              "Show All",
                                              style: TextStyle(
                                                color: AppColor.color4,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "${restaurants.length}",
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w900,
                                          color: AppColor.color4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),

                              if (restaurants.isEmpty)
                                buildEmptyState(context)
                              else ...[
                                GridSection(restaurants: restaurants),
                                const SizedBox(height: 25),
                                ActivitySection(restaurants: restaurants),
                              ],
                            ],
                          );
                        }
                        return const Center(child: Text("Please wait..."));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildEmptyState(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 50),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/notfound.jpg',
          width: 500,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        const Text(
          "No restaurants found in this area",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            context.read<RestaurantCubit>().getAllRestaurants();
          },
          icon: const Icon(Icons.refresh),
          label: const Text("Show All Restaurants"),
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.color4),
        ),
      ],
    ),
  );
}
