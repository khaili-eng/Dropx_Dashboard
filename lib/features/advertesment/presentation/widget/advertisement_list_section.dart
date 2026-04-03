import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/features/advertesment/presentation/manager/adv_cubit.dart';
import 'package:maadati/features/advertesment/presentation/manager/adv_state.dart';
import 'package:maadati/features/advertesment/presentation/widget/update_adv_form.dart';
import '../../data/model/adv_model.dart';

class AdsListSection extends StatefulWidget {
  const AdsListSection({super.key});

  @override
  State<AdsListSection> createState() => _AdsListSectionState();
}

class _AdsListSectionState extends State<AdsListSection> {
  AdvModel? advModel;

  int calculateCrossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            const SizedBox(height: 20),

            BlocBuilder<AdvCubit, AdvState>(
              builder: (context, state) {
                if (state is AdvLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is AdvError) {
                  return Center(
                    child: Text(
                      state.error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is AdvLoaded) {
                  if (state.advs.isEmpty) {
                    return const Center(
                      child: Text("No advertisements available"),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.advs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: calculateCrossAxisCount(screenWidth),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final ad = state.advs[index];

                      return _AdCard(
                        ad: ad,
                        onEdit: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<AdvCubit>(), // استخدم الـ Cubit الموجود مسبقاً
                              child: UpdateAdvForm(adv: ad),
                            ),
                          );
                        },
                        onDelete: () {},
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AdCard extends StatefulWidget {
  final AdvModel ad;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AdCard({
    required this.ad,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<_AdCard> createState() => _AdCardState();
}

class _AdCardState extends State<_AdCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, isHover ? -5 : 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHover ? 0.15 : 0.05),
              blurRadius: isHover ? 15 : 8,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          widget.ad.image,
                          fit: BoxFit.cover,
                        ),
                      ),


                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),


                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Active",
                            style: TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.ad.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.ad.description ?? "",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.ad.createdAt,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: widget.onEdit,
                              icon: Icon(Icons.edit,
                                  size: 18, color: AppColor.color4),
                              label: const Text("Edit"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: widget.onDelete,
                              icon: const Icon(Icons.delete, size: 18),
                              label: const Text("Delete"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}