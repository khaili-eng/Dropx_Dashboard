import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/advertesment/data/model/adv_model.dart';

import '../../../../core/constants/app_color/app_color.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../manager/adv_cubit.dart';
import '../manager/adv_state.dart';

class UpdateAdvForm extends StatefulWidget {
  final AdvModel adv;
  const UpdateAdvForm({super.key, required this.adv});

  @override
  State<UpdateAdvForm> createState() => _UpdateAdvForm();
}

class _UpdateAdvForm extends State<UpdateAdvForm> {

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
  void initState() {
    titleController.text = widget.adv.title;
    descController.text = widget.adv.description;

    super.initState();
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
              if(state is AdvUpdateSuccess){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message))
                );
                Navigator.pop(context);
                context.read<AdvCubit>().getAllAdv();
              }
              if(state is AdvUpdateError){
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
                      height: 320,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: imageBytes != null
                          ? Image.memory(imageBytes!, fit: BoxFit.cover)
                          :Image.network(
                        widget.adv.image,
                        fit: BoxFit.cover,
                      ) ,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: pickImage, 
                    icon: Icon(Icons.upload,color: AppColor.color4,),
                    label: Text("Change Image",style: TextStyle(color: AppColor.color4),),),
                  state is UpdateAdvLoading ? const CircularProgressIndicator():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()
                             ) {

                            context.read<AdvCubit>().updateAdv(
                              id: widget.adv.id,
                                title: titleController.text.trim(),
                                description: descController.text.trim(),
                                imageBytes: imageBytes,
                                fileName: fileName);

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.color4,

                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit,color: AppColor.color1,),
                            SizedBox(width: 5,),
                            Text(context.watch<LocaleCubit>().translate('hh'),
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