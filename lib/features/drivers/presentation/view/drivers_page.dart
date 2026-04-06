import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/features/drivers/data/model/working_hour_model.dart';
import 'package:maadati/features/drivers/presentation/widget/driver_daily_report_widget.dart';

import '../../../../core/constants/app_color/app_color.dart';
import '../../../../core/constants/app_route/app_route.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/services/enum.dart';
import '../../../../core/widgets/header.dart';
import '../../../../core/widgets/header_actions_items.dart';
import '../../../../core/widgets/side_drawer.dart';
import '../../../auth/data/model/user_mpdel.dart';
import '../../data/model/driver_item_model.dart';
import '../../data/model/driver_list_response.dart';
import '../../data/model/driver_model.dart';
import '../../repo/driver_repo_impl.dart';
import '../manager/driver_cubit.dart';
import '../manager/driver_state.dart';
import '../widget/driver_card.dart';

class DriversPage extends StatefulWidget {
  const DriversPage({super.key});

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final cityController = TextEditingController();
  List<WorkingHourModel> workingHours = [];
  DriverViewType selectedView = DriverViewType.all;
  String? selectedCity;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DriverCubit>().getAllDrivers();
    });
    super.initState();
  }
  @override
  void dispose() {
    fullnameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    vehicleTypeController.dispose();
    vehicleNumberController.dispose();
    cityController.dispose();
    super.dispose();
  }
  void applyFilter(String filter) {
    final cubit = context.read<DriverCubit>();
    switch (filter) {
      case "all":
        cubit.getAllDrivers();
        break;
      case "active":
        cubit.getAllActiveDrivers();
        break;
      case "city":
        cubit.getDriversByCity(selectedCity!);
        break;
      case "activeCity":
        cubit.getActiveDriversByCity(selectedCity!);
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Scaffold(
        backgroundColor: Colors.white,
        key: drawerKey,
        drawer: SizedBox(width: 100,child: SideDrawer(currentRoute: AppRoute.drivers),),
        appBar: !Responsive.isDesktop(context)?
        AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){drawerKey.currentState!.openDrawer();},
            icon: Icon(Icons.menu,color: AppColor.color4,),
          ),
          actions:  [
            HeaderActionItems(),
          ],
        ):
        const PreferredSize(
            preferredSize: Size.zero,
            child: SizedBox()
        ),
        body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(Responsive.isDesktop(context))
                  const Expanded(
                      flex: 1,
                      child: SideDrawer(currentRoute: AppRoute.drivers,)),
                Expanded(
                    flex:10,
                    child: SafeArea(
                        child: SingleChildScrollView(
                          padding:  EdgeInsets.symmetric(horizontal: Responsive.isMobile(context)?20:40,vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Header(),
                              SizedBox(height: SizeConfig.blockSizeVertical*4,),
                              Text(
                                "Drivers Management",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical*1,),
                              buildActionBar(),
                              SizedBox(height: SizeConfig.blockSizeVertical*4,),
                              animatedDashboardWrapper(buildDashboardSection()),
                              SizedBox(height: SizeConfig.blockSizeVertical*4,),
                              buildFilters(),
                              SizedBox(height: SizeConfig.blockSizeVertical*4,),
                              BlocBuilder<DriverCubit, DriverState>(
                                builder: (context, state) {
                                  List<DriverItemModel> drivers = [];

                                  /// 🔄 LOADING
                                  if (state is DriversLoading ||
                                      state is AllActiveDriversLoading ||
                                      state is DriversByCityLoading ||
                                      state is ActiveDriversLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  /// ✅ SUCCESS
                                  else if (state is DriversSuccess) {
                                    drivers = state.drivers;
                                  } else if (state is AllActiveDriversSuccess) {
                                    drivers = state.drivers.cast<DriverItemModel>();
                                  } else if (state is DriversByCitySuccess) {
                                    drivers = state.drivers.cast<DriverItemModel>();
                                  } else if (state is ActiveDriversSuccess) {
                                    drivers = state.drivers.cast<DriverItemModel>();
                                  }


                                  else if (state is DriversError ||
                                      state is AllActiveDriversError ||
                                      state is DriversByCityError ||
                                      state is ActiveDriversError) {
                                    drivers = [
                                      DriverItemModel(
                                        user:UserModel(
                                          id: 1,
                                          fullName: "Demo Driver",
                                          phone: "1111111111",
                                          isActive: false,
                                          isVerified: false,
                                        ),
                                        driver: DriverModel(
                                          id: 0,
                                          userId: 0,
                                          vehicletype: "Car",
                                          vehiclenumber: "XXX-000",
                                          isActive: true,
                                          createdAt: "",
                                          updatedAt: "",
                                        ),
                                      ),
                                      DriverItemModel(
                                       user:UserModel(
                                  id: 1,
                                  fullName: "Demo Driver",
                                  phone: "1111111111",
                                  isActive: false,
                                  isVerified: false,
                                  ),
                                        driver: DriverModel(
                                          id: 1,
                                          userId: 1,
                                          vehicletype: "Bike",
                                          vehiclenumber: "YYY-111",
                                          isActive: false,
                                          createdAt: "",
                                          updatedAt: "",
                                        ),
                                      ),
                                    ];
                                  }
                                  if (drivers.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 400),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.person_off,
                                                size: 80,
                                                color: Colors.grey.shade400,
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                "No Drivers Found",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade700,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "Currently there are no drivers matching the selected filter. Try refreshing or changing filters.",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey.shade600,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 20),


                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton.icon(
                                                  onPressed: () {
                                                    context.read<DriverCubit>().getAllDrivers();
                                                  },
                                                  icon: const Icon(Icons.refresh, color: Colors.white),
                                                  label: const Text(
                                                    "Refresh",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColor.color4,
                                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: drivers.length,
                                    itemBuilder: (context, index) {
                                      return DriverCard(
                                        data: drivers[index],
                                      );
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: SizeConfig.blockSizeHorizontal*4,),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColor.color2,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Driver Performance Reports",
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Monitor driver activity with daily and monthly reports. Analyze completed, running, and cancelled orders through interactive charts.",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockSizeHorizontal*4,),
                              DriverReportWidget(report: {},useMock: true,),


                            ],
                          ),
                        ))),

              ],
      
            )),

    );
  }
  //widget for action bar
  Widget buildActionBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // RIGHT SIDE (Buttons)
        Row(
          children: [
            buildPrimaryButton(
              title: "Create Driver",
              icon: Icons.add,
              onTap: () {
                showCreateDriverDialog();
              },
            ),
          ],
        )
      ],
    );
  }
  //widget for primary button
  Widget buildPrimaryButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.color4,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  //widget for secondary button
  Widget buildSecondaryButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(title),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        side: BorderSide(color: AppColor.color4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
//dialog for create driver
  void showCreateDriverDialog() {
    final driverCubit = context.read<DriverCubit>();
    showDialog(
      context: context,
      builder: (Context) {
        return BlocProvider.value(
          value: driverCubit,
          child: StatefulBuilder(
            builder: (context, setStateDialog) {
              return AlertDialog(
                title: const Text("Create Driver"),
                content: SizedBox(
                  width: 550,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // 🔹 BASIC INFO
                        buildTextField(fullnameController, "Full Name"),
                        buildTextField(phoneController, "Phone"),
                        buildTextField(passwordController, "Password"),
                        buildTextField(vehicleTypeController, "Vehicle Type"),
                        buildTextField(vehicleNumberController, "Vehicle Number"),
                        buildTextField(cityController, "City"),

                        const SizedBox(height: 20),

                        // 🔹 WORKING HOURS HEADER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Working Hours",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setStateDialog(() {
                                  workingHours.add(
                                    WorkingHourModel(
                                      dayOfWeek: "sunday",
                                      startTime: "08:00",
                                      endTime: "17:00",
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // 🔹 EMPTY STATE
                        if (workingHours.isEmpty)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "No working hours added",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),

                        // 🔹 LIST OF WORKING HOURS
                        ...workingHours.asMap().entries.map((entry) {
                          int index = entry.key;
                          WorkingHourModel item = entry.value;

                          return buildWorkingHourItem(item, index, setStateDialog);
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      workingHours.clear();
                      fullnameController.clear();
                      phoneController.clear();
                      passwordController.clear();
                      vehicleTypeController.clear();
                      vehicleNumberController.clear();
                      cityController.clear();
                    },
                    child: const Text("Cancel"),
                  ),

                  // 🔹 CREATE DRIVER BUTTON
                  BlocConsumer<DriverCubit, DriverState>(
                    listener: (context, state) {
                      if (state is DriverSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                        Navigator.pop(context);
                        workingHours.clear();
                        fullnameController.clear();
                        phoneController.clear();
                        passwordController.clear();
                        vehicleTypeController.clear();
                        vehicleNumberController.clear();
                        cityController.clear();
                      } else if (state is DriverError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is DriverLoading) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (fullnameController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              vehicleTypeController.text.isEmpty ||
                              vehicleNumberController.text.isEmpty ||
                              cityController.text.isEmpty ||
                              workingHours.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Please fill all fields and add working hours")),
                            );
                            return;
                          }

                          context.read<DriverCubit>().createDriver(
                            fullname: fullnameController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            vehicleType: vehicleTypeController.text,
                            vehicleNumber: vehicleNumberController.text,
                            city: cityController.text,
                            workingHours: workingHours,
                          );
                        },
                        child: const Text("Create"),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
  //dialog for reset password
  void showResetPasswordDialog(List<DriverModel?> drivers) {
    final passwordController = TextEditingController();

    DriverModel? selectedDriver;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(
                "Reset Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<DriverModel>(
                      hint: Text("Select Driver"),
                      value: selectedDriver,
                      items: drivers.map((driver) {
                        if (driver == null) return null;
                        return DropdownMenuItem(
                          value: driver,
                          child: Text("${driver.vehiclenumber} "),
                        );
                      }).whereType<DropdownMenuItem<DriverModel>>().toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedDriver = value;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    /// 🔑 PASSWORD
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedDriver == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select a driver")),
                      );
                      return;
                    }

                    // مثال على استدعاء الدالة داخل Cubit
                    context.read<DriverCubit>().resetDriverPassword(
                      id: selectedDriver!.id,
                      newPassword: passwordController.text,
                    );

                    Navigator.pop(context);
                  },
                  child: Text("Reset"),
                ),
              ],
            );
          },
        );
      },
    );
  }
  //widget for text field
  Widget buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
  //widget for working hours ui
  Widget buildWorkingHourItem(
      WorkingHourModel item,
      int index,
      Function setStateDialog,
      ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            /// 🔹 DAY DROPDOWN
            DropdownButtonFormField<String>(
              value: item.dayOfWeek,
              decoration: InputDecoration(
                labelText: "Day",
                border: OutlineInputBorder(),
              ),
              items: [
                "sunday",
                "monday",
                "tuesday",
                "wednesday",
                "thursday",
                "friday",
                "saturday",
              ].map((day) {
                return DropdownMenuItem(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (value) {
                setStateDialog(() {
                  item.dayOfWeek = value!;
                });
              },
            ),

            const SizedBox(height: 10),

            /// 🔹 TIME PICKERS
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (picked != null) {
                        final formatted =
                            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";

                        setStateDialog(() {
                          item.startTime = formatted;
                        });
                      }
                    },
                    child: Text(
                      item.startTime.isEmpty
                          ? "Start Time"
                          : item.startTime,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (picked != null) {
                        final formatted =
                            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";

                        setStateDialog(() {
                          item.endTime = formatted;
                        });
                      }
                    },
                    child: Text(
                      item.endTime.isEmpty
                          ? "End Time"
                          : item.endTime,
                    ),
                  ),
                ),

                const SizedBox(width: 5),

                /// 🔴 DELETE
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setStateDialog(() {
                      workingHours.removeAt(index);
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  //widget for filter
  Widget buildFilters() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.color4.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.tune, color: AppColor.color4),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Filter Drivers",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              TextButton.icon(
                onPressed: () {
                  setState(() {
                    selectedView = DriverViewType.all;
                    selectedCity = null;
                  });
                },
                icon: Icon(Icons.refresh, size: 18, color: AppColor.color4),
                label: Text(
                  "Reset",
                  style: TextStyle(color: AppColor.color4),
                ),
              )
            ],
          ),

          const SizedBox(height: 20),


          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              buildFilterItem("All", Icons.list, DriverViewType.all),
              buildFilterItem("Active", Icons.check_circle, DriverViewType.active),
              buildFilterItem("By City", Icons.location_city, DriverViewType.byCity),
              buildFilterItem("Active By City", Icons.map, DriverViewType.activeByCity),
            ],
          ),

          const SizedBox(height: 20),



          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: (selectedView == DriverViewType.byCity ||
                selectedView == DriverViewType.activeByCity)
                ? Column(
              key: const ValueKey("cityDropdown"),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select City",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                buildCityDropdown(),
              ],
            )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
  //widget for build filter item
  Widget buildFilterItem(String title, IconData icon, DriverViewType type) {
    final isSelected = selectedView == type;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        setState(() {
          selectedView = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.color4
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected
                ? AppColor.color4
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),

            /// 🔥 Indicator
            if (isSelected) ...[
              const SizedBox(width: 6),
              Icon(Icons.check, size: 16, color: Colors.white),
            ]
          ],
        ),
      ),
    );
  }
  //widget for dropdown
  Widget buildCityDropdown() {
    List<String> cities = ["فلسطين", "دمشق", "حلب"];

    return Container(
      key: const ValueKey("cityDropdown"),
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: selectedCity,
        hint: const Text("Select City"),
        isExpanded: true,
        underline: const SizedBox(),
        items: cities.map((city) {
          return DropdownMenuItem(
            value: city,
            child: Text(city),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCity = value;
          });
        },
      ),
    );
  }
  //widget for cards dashboards
  Widget buildDashboardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.color4.withOpacity(0.9),
                AppColor.color4,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColor.color4.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.analytics, color: Colors.white),
              ),
              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Operations Overview",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Real-time system metrics",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        const SizedBox(height: 25),

        /// 🔥 GRID CARDS
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isDesktop(context) ? 5 : 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
          ),
          children: [

            buildStatCard(
              title: "Inactive Drivers\n(In Working Hours)",
              value: "12",
              icon: Icons.pause_circle,
              color: Colors.orange,
              onTap: () {
                showDriversDialog(
                  "Inactive Drivers",
                  getMockDrivers("inactive"),
                );
              },
            ),

            buildStatCard(
              title: "Leaked Drivers\n(Palestine)",
              value: "5",
              icon: Icons.warning,
              color: Colors.red,
              onTap: () {
                showDriversDialog(
                  "Leaked Drivers",
                  getMockDrivers("inactive"),
                );
              },
            ),

            buildStatCard(
              title: "Completed Orders Today",
              value: "120",
              icon: Icons.check_circle,
              color: Colors.green,
              onTap: () {
                showDriversDialog(
                  "Completed Orders",
                  getMockDrivers("active"),
                );
              },
            ),

            buildStatCard(
              title: "Running Orders",
              value: "18",
              icon: Icons.delivery_dining,
              color: Colors.blue,
              onTap: () {
                showDriversDialog(
                  "Running Orders",
                  getMockDrivers("active"),
                );
              },
            ),

            buildStatCard(
              title: "Orders In Restaurant",
              value: "9",
              icon: Icons.restaurant,
              color: Colors.deepPurple,
              onTap: () {
                showDriversDialog(
                  "Restaurant Orders",
                  getMockDrivers("active"),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
  List<DriverModel> getMockDrivers(String type) {
    return List.generate(5, (index) {
      return DriverModel(
        id: index,
        userId: index,
        vehicletype: "Motorcycle",
        vehiclenumber: "ABC-${index + 100}",
        isActive: type == "active",
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      );
    });
  }
  void showDriversDialog(String title, List<DriverModel> drivers) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              /// 🔴 زر إعادة تعيين كلمة المرور (بالأعلى)
              buildSecondaryButton(
                title: "Reset Password",
                icon: Icons.lock_reset,
                onTap: () {
                  showResetPasswordDialog(drivers);
                },
              ),
            ],
          ),

          content: SizedBox(
            width: 650,
            height: 500,
            child: drivers.isEmpty
                ? Center(child: Text("No Drivers Found"))
                : SingleChildScrollView(
              child: Column(
                children: drivers.map((driver) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: driver.isActive
                                ? Colors.green.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              color: driver.isActive
                                  ? Colors.green
                                  : Colors.red,
                              size: 28,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Driver #${driver.id}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text("Vehicle Type: ${driver.vehicletype}"),
                                Text("Vehicle Number: ${driver.vehiclenumber}"),
                                Text(
                                  "Created At: ${driver.createdAt.split(' ')[0]}",
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: driver.isActive
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              driver.isActive ? "Active" : "Inactive",
                              style: TextStyle(
                                color: driver.isActive
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            )
          ],
        );
      },
    );
  }
  //widget state card
  Widget buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHover = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHover = true),
          onExit: (_) => setState(() => isHover = false),
          child: AnimatedScale(
            scale: isHover ? 1.05 : 1,
            duration: const Duration(milliseconds: 200),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: isHover
                        ? [color.withOpacity(0.15), Colors.white]
                        : [Colors.white, Colors.white],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isHover
                          ? color.withOpacity(0.25)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: isHover ? 20 : 10,
                      offset: const Offset(0, 6),
                    ),
                  ],

                  border: Border.all(
                    color: isHover
                        ? color.withOpacity(0.4)
                        : Colors.grey.shade200,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: color),
                    ),

                    const Spacer(),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget animatedDashboardWrapper(Widget child) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 40, end: 0),
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(
            opacity: (1 - (value / 40)).clamp(0, 1),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
