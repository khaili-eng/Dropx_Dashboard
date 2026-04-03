import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_color/app_color.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../manager/adv_cubit.dart';
import '../manager/adv_state.dart';

class CreateAdForm extends StatefulWidget {
  const CreateAdForm({super.key});

  @override
  State<CreateAdForm> createState() => _CreateAdFormState();
}

class _CreateAdFormState extends State<CreateAdForm> {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descController = TextEditingController();

  Uint8List? imageBytes;
  String? fileName;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      imageBytes = result.files.first.bytes;
      fileName = result.files.first.name;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: BlocConsumer<AdvCubit,AdvState>(
            listener: (context,state){
              if(state is AdvSuccess){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message))
                );
                //reset form
                titleController.clear();
                descController.clear();
                setState(() {
                  imageBytes=null;
                });
                //refresh advs list
                context.read<AdvCubit>().getAllAdv();
              }
              if(state is AdvError){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error))
                );
              }
            },
            builder: (context,state){
              return Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: "Title"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: descController,
                    decoration: InputDecoration(labelText: "Description"),
                  ),
                  SizedBox(height: 20),
                  //image
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: imageBytes == null
                          ? Center(child: Column(
                        children: [
                          SizedBox(height: 60,),
                          Icon(Icons.image,size: 50,),
                          Text("Click to upload image"),
                        ],))
                          : Image.memory(imageBytes!, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 20),
                  state is AdvLoading ? const CircularProgressIndicator():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              imageBytes != null) {

                            context.read<AdvCubit>().createAd(
                                title: titleController.text.trim(),
                                description: descController.text.trim(),
                                imageBytes: imageBytes!,
                                fileName: fileName!);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.color4,

                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,color: AppColor.color1,),
                            SizedBox(width: 5,),
                            Text(context.watch<LocaleCubit>().translate('ii'),
                              style: TextStyle(
                                  color: AppColor.color1,
                                  fontSize: 16
                              ),),
                          ],
                        ),
                      ),

                    ],
                  )
                ],
              );
            },

          ),
        ),
      ),
    );
  }
}