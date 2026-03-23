import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:maadati/features/auth/presentation/widgets/login_form.dart';
import 'package:maadati/features/auth/repo/auth_repo_impl.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepoImpl(ApiService())),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;

              final formArea = Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 30 : 24,
                    vertical: isWide ? 64: 16,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200,maxHeight: 700),
                    child:  Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Card(
                          color: AppColor.color1,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 80, bottom: 30, left: 24, right: 24),
                            child: LoginForm(),
                          ),
                        ),
                        Positioned(
                          top: -50,
                          child: Image.asset(
                            "assets/images/logo.png",
                            height:200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
              );

              if (isWide) {
                return Row(
                  children: [

                    Expanded(
                      flex: 4,
                      child: formArea,
                    ),
                  ],
                );
              }

              return Column(
                children: [

                  Expanded(child: formArea),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}



class _CircleBlur extends StatelessWidget {
  final double diameter;
  final Color color;

  const _CircleBlur({
    required this.diameter,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

