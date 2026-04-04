import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:maadati/core/components/GridComponents/gridSection_component.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/cubits/restaurant_cubit.dart';
import 'package:maadati/core/states/restaurant_state.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;

  void onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 800), () {
      if (query.trim().isNotEmpty) {
        context.read<RestaurantCubit>().getRestaurantsByCity(query.trim());
      } else if (query.isEmpty && isSearching) {
        context.read<RestaurantCubit>().getAllRestaurants();
      }
    });
  }

  void showFullMap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40),
              ),
              child: Stack(
                children: [
                  FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(33.5138, 36.2765),
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.maadati.app',
                      ),
                      const MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(33.5138, 36.2765),
                            child: Icon(
                              Icons.restaurant,
                              color: AppColor.color4,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: AppColor.color4,
                      onPressed: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutBack,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isSearching ? 25 : 50),
            boxShadow: [
              BoxShadow(
                color: AppColor.color4.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              if (!isSearching) ...[
                Hero(
                  tag: 'logo',
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColor.color4, AppColor.color3],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "MA",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        "Maddati",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Expanded(
                flex: isSearching ? 10 : 0,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child:
                      isSearching
                          ? TextField(
                            controller: searchController,
                            onChanged: onSearchChanged,
                            decoration: InputDecoration(
                              hintText: "Search area (e.g. Mezzeh)",
                              prefixIcon: IconButton(
                                icon: const Icon(
                                  Icons.map_rounded,
                                  color: AppColor.color4,
                                ),
                                onPressed: showFullMap,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isSearching = false;
                                    searchController.clear();
                                  });
                                  context
                                      .read<RestaurantCubit>()
                                      .getAllRestaurants();
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          )
                          : GestureDetector(
                            onTap: () => setState(() => isSearching = true),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColor.color4.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.search,
                                color: AppColor.color4,
                                size: 26,
                              ),
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),

        if (isSearching)
          BlocBuilder<RestaurantCubit, RestaurantState>(
            builder: (context, state) {
              if (state is RestaurantLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColor.color4),
                  ),
                );
              } else if (state is RestaurantLoaded) {
                if (state.restaurants.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text("No restaurants found in this city."),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GridSection(restaurants: state.restaurants),
                );
              } else if (state is RestaurantError) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Error: ${state.message}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
      ],
    );
  }
}
