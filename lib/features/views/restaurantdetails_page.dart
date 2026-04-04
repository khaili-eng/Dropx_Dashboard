import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maadati/core/cubits/meal_cubit.dart';
import 'package:maadati/core/cubits/restaurantsDetails_cubit.dart';
import 'package:maadati/core/states/meal_state.dart';
import 'package:maadati/core/states/restaurntDetails_state.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/features/views/%D9%8DSetting_page.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;
  final String city;
  const RestaurantDetailsPage({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
    required this.city,
  });

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final descController = TextEditingController();
  final cityController = TextEditingController();
  final commissionTypeController = TextEditingController();
  final commissionValueController = TextEditingController();

  List<dynamic> meals = [];
  List<XFile> images = [];
  String? imageUrl;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() =>
      context.read<RestaurantDetailsCubit>().getDetails(widget.restaurantId);

  void save() {
    context.read<RestaurantDetailsCubit>().updateInfo(
      id: widget.restaurantId,
      fullname: nameController.text,
      phone: phoneController.text,
      description: descController.text,
      imageFile: images.isNotEmpty ? images.first : null,
      city: cityController.text,
      commissionType: "fixed",
      commissionValue: "1500",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<RestaurantDetailsCubit, RestaurantDetailsState>(
            listener: (context, state) {
              if (state is RestaurantDetailsLoaded) {
                final data = state.data['data'];
                final user = data['user'];
                String city = widget.city;
                if (user != null &&
                    user['areas'] != null &&
                    user['areas'].isNotEmpty) {
                  city = user['areas'][0]['city'] ?? widget.city;
                } else if (data['areas'] != null && data['areas'].isNotEmpty) {
                  city = data['areas'][0]['city'] ?? widget.city;
                }

                setState(() {
                  nameController.text = user?['fullname'] ?? '';
                  phoneController.text = user?['phone'] ?? '';
                  descController.text = data['description'] ?? '';

                  cityController.text = city;

                  commissionTypeController.text = 'fixed';
                  commissionValueController.text = '1500';
                  imageUrl = data['image'];
                  meals = data['meals'] ?? [];
                });
              }

              if (state is RestaurantUpdateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ Updated successfully')),
                );
                refresh();
              }
            },
          ),
          BlocListener<MealCubit, MealState>(
            listener: (context, state) {
              if (state is MealSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('✅ Meal Added successfully'),
                  ),
                );

                refresh();
              } else if (state is MealError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
        ],
        child: CustomScrollView(
          slivers: [
            buildSliverAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    sectionTitle("Basice information", Icons.info_outline),
                    infoCard(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        sectionTitle("Meal List", Icons.restaurant_menu),
                        IconButton(
                          onPressed: _openAddMealDialog,
                          icon: const Icon(
                            Icons.add_circle,
                            color: AppColor.color4,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    mealsList(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColor.color4,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          SettingsPage(restaurantId: widget.restaurantId),
                ),
              ),
        ),
        IconButton(
          icon: Icon(
            isEditing ? Icons.check_circle : Icons.edit,
            color: Colors.white,
          ),
          onPressed: () {
            if (isEditing) save();
            setState(() => isEditing = !isEditing);
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.restaurantName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            imageUrl != null
                ? Image.network(imageUrl!, fit: BoxFit.cover)
                : Container(color: AppColor.color2),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColor.color4, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            field("name", nameController, Icons.person_outline),
            field("phone number", phoneController, Icons.phone_android),
            field("description", descController, Icons.description_outlined),
            field("city", cityController, Icons.location_city_outlined),
            Row(
              children: [
                Expanded(
                  child: field(
                    "commission type",
                    commissionTypeController,
                    Icons.percent_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: field("value", commissionValueController, Icons.money),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget field(String label, TextEditingController c, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        enabled: isEditing,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColor.color4, size: 20),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          filled: true,
          fillColor: isEditing ? Colors.white : Colors.grey.shade50,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.color4),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
        ),
      ),
    );
  }

  Widget mealsList() {
    if (meals.isEmpty)
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text("haven't meals yet"),
        ),
      );

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final meal = meals[i];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.deepPurple.shade50,
                child: const Icon(Icons.fastfood, color: Colors.deepPurple),
              ),
            ),
            title: Text(
              meal['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${meal['original_price']} SYP",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                actionBtn(Icons.edit, AppColor.color4, () => editMeal(meal)),
                actionBtn(
                  Icons.delete,
                  Colors.red,
                  () => deleteMeal(meal['id']),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget actionBtn(IconData icon, Color color, VoidCallback tap) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 20),
        onPressed: tap,
      ),
    );
  }

  Widget header() {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [AppColor.color4, AppColor.color2]),
      ),
      child: Center(
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Colors.white,
          backgroundImage:
              images.isNotEmpty
                  ? FileImage(File(images.first.path))
                  : (imageUrl != null ? NetworkImage(imageUrl!) : null)
                      as ImageProvider?,
          child:
              imageUrl == null && images.isEmpty
                  ? const Icon(Icons.restaurant, size: 40)
                  : null,
        ),
      ),
    );
  }

  Widget mealsCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
            meals.isEmpty
                ? const Text("No meals")
                : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: meals.length,
                  itemBuilder: (_, i) {
                    final meal = meals[i];

                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          meal['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("${meal['original_price']} SYP"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => editMeal(meal),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteMeal(meal['id']),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }

  void _openAddMealDialog() {
    final name = TextEditingController();
    final price = TextEditingController();
    List<XFile> imgs = [];

    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColor.color1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: Column(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: AppColor.color4,
                  size: 40,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Add New Meal",
                  style: TextStyle(
                    color: AppColor.color4,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Enter meal details to display in the restaurant menu",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 20),

                  buildDialogTextField(
                    controller: name,
                    label: "name",
                    hint: "Example: Margherita Pizza",
                    icon: Icons.fastfood_rounded,
                  ),

                  const SizedBox(height: 16),

                  buildDialogTextField(
                    controller: price,
                    label: "price",
                    hint: "Example: 15000",
                    icon: Icons.monetization_on_rounded,
                    isNumber: true,
                  ),
                ],
              ),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "cancel",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.color4,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        if (name.text.isNotEmpty && price.text.isNotEmpty) {
                          await context.read<MealCubit>().addMeal(
                            token:
                                "11|6sfz4Z1jjSem2Z0oWUGb8YLknYDHnclUR9TsxYUEdccef799",
                            restaurantId: widget.restaurantId,
                            data: {
                              "name": name.text,
                              "original_price": price.text,
                              "category_name": "شرقي",
                            },
                            images: imgs.map((e) => File(e.path)).toList(),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  Widget buildDialogTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 12),
        prefixIcon: Icon(icon, color: AppColor.color4, size: 20),
        filled: true,
        fillColor: AppColor.color2.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColor.color4, width: 1),
        ),
      ),
    );
  }

  void editMeal(dynamic meal) {
    final name = TextEditingController(text: meal['name']);

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Edit"),
            content: TextField(controller: name),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await context.read<MealCubit>().updateMeal(
                    token:
                        "11|6sfz4Z1jjSem2Z0oWUGb8YLknYDHnclUR9TsxYUEdccef799",
                    mealId: meal['id'],
                    data: {"name": name.text},
                  );
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  void deleteMeal(int id) {
    context.read<MealCubit>().deleteMeal(
      token: "11|6sfz4Z1jjSem2Z0oWUGb8YLknYDHnclUR9TsxYUEdccef799",
      mealId: id,
    );
  }
}
