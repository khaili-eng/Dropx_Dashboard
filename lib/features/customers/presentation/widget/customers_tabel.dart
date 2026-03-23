import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/customers/data/model/customer_model.dart';

import '../manager/customers_cubit.dart';

class CustomersTabel extends StatelessWidget {
  final List<CustomerModel> customers;
  const CustomersTabel({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        headingRowColor: const MaterialStatePropertyAll(Colors.grey),
        headingTextStyle: const TextStyle(fontWeight: FontWeight.w600),
        columnSpacing: 28,
        columns: const[
          DataColumn(label: Text("id")),
          DataColumn(label: Text("fullname")),
          DataColumn(label: Text("Phone")),
          DataColumn(label: Text("location Text")),
          DataColumn(label: Text("Actions")),
        ],
        rows: customers.map((customer){
       return DataRow(
           cells: [
             DataCell(Text(customer.id.toString())),
             DataCell(Text(customer.fullname)),
             DataCell(Text(customer.phone)),
             DataCell(Text(customer.locationText??"No location")),

             //state and switch 
             DataCell(Row(
              children: [
                buildStatus(customer.isActive),
                SizedBox(width: 10,),
                buildStatusSwitch(customer, (value){
                  //actions for api
                  context.read<CustomersCubit>().updateUserActivation(customer.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("تم تحديث حالة الحساب بنجاح."))
                  );
                })
              ],
             ))
           ]);
        }).toList());
  }
}


//widget for state 
Widget buildStatus(bool isActive) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          isActive ? "Active" : "Inactive",
          style: TextStyle(
            color: isActive ? Colors.green : Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

//widget for switch between active and disactive state 
Widget buildStatusSwitch(CustomerModel customer, Function(bool) onChanged) {
  return Switch(
    value: customer.isActive,
    activeColor: Colors.green,
    onChanged: onChanged,
  );
}