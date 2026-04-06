import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/features/admin_fees/data/datasources/admin_fees_remote_data_source.dart';
import 'package:maadati/features/admin_fees/data/model/admin_fee.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_cubit.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_status.dart';

class FessPage extends StatelessWidget {
  const FessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: AppColor.color4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 150,
        elevation: 0,
        title: Center(
          child: Text(
            "Admin Fees",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => AdminFeesCubit(AdminFeesRemoteDataSourceImpl()),
        child: BlocBuilder<AdminFeesCubit, AdminFeesStatus>(
          builder: (context, state) {
            if (state is AdminFeesInitial) {
              return Center(child: Text("Press the button to load fees"));
            } else if (state is AdminFeesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AdminFeesLodded) {
              return ListView.builder(
                itemCount: state.adminFees.length,
                itemBuilder: (context, index) {
                  final fee = state.adminFees[index];
                  return ListTile(
                    title: Text("Fee Toltal: ${fee.date}"),
                    subtitle: Text("Date: ${fee.total}"),
                  );
                },
              );
            } else if (state is AdminFeesError) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
