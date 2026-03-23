import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/constants/app_route/app_route.dart';
import 'package:maadati/core/localization/locale_cubit.dart';
import 'package:maadati/features/auth/presentation/manager/auth_cubit.dart';

import '../../../../core/constants/app_color/app_color.dart';
import '../manager/auth_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.authResponse.message))
          );
          Navigator.pushReplacementNamed(context, AppRoute.dashboard);
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: (){
                    final localeCubit = context.read<LocaleCubit>();
                    if (localeCubit.currentLocale.languageCode == 'ar') {
                      localeCubit.changeLanguage('en');
                    } else {
                      localeCubit.changeLanguage('ar');
                    }
                  },
                  icon: Icon(Icons.language,color: AppColor.color4,),
                 
                    ),
               SizedBox(height: 35,),
               Text(
          context.read<LocaleCubit>().translate('bb'),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColor.color4,
                ),
              ),
              const SizedBox(height: 6),
               Text(
               context.watch<LocaleCubit>().translate('aa'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,

                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(
                  labelText: context.watch<LocaleCubit>().translate('cc'),
                  hintText: "09xxxxxxxx",
                  prefixIcon: Icon(Icons.phone,color: AppColor.color4,),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.read<LocaleCubit>().translate('ee');
                  }
                  if (!RegExp(r'^09\d{8}$').hasMatch(value)) {
                    return context.read<LocaleCubit>().translate('ff');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: context.read<LocaleCubit>().translate('dd'),
                  hintText: "********",
                  prefixIcon:  Icon(Icons.lock,color: AppColor.color4,),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColor.color4,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return context.read<LocaleCubit>().translate('gg');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: state is AuthLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(

                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                                  phone: phoneNumberController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.color4,

                  ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.login,color: AppColor.color1,),
                            SizedBox(width: 5,),
                            Text(context.watch<LocaleCubit>().translate('login'),
                              style: TextStyle(
                              color: AppColor.color1,
                              fontSize: 16
                            ),),
                          ],
                        ),
                      ),
              ),

            ],
          ),
        );
      },
    );
  }
}
