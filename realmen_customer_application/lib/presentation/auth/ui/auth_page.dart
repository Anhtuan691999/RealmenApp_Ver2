// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/presentation/auth/bloc/auth_bloc.dart';
import 'package:realmen_customer_application/presentation/auth/pages/login_page.dart';
import 'package:realmen_customer_application/presentation/auth/pages/register/ui/register_page.dart';
import 'package:realmen_customer_application/presentation/pages/landing_page/landing_page.dart';
import 'package:realmen_customer_application/utils/dialog/loading_dialog.dart';
import 'package:realmen_customer_application/utils/snackbar/snackbar.dart';

import '../pages/create_otp_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  static const String AuthenticationPageRoute = "/auth-screen";

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final AuthenticationBloc authPageBloc = AuthenticationBloc();
  CloseDialog? _closeDialogHandle;
  ShowDialog? _showDialogHandle;

  @override
  void initState() {
    authPageBloc.add(AuthenticationInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: authPageBloc,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      buildWhen: (previous, current) => current is! AuthenticationActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case AuthPageInvalidPhoneActionState:
            ShowSnackBar.ErrorSnackBar(context, "Số điện thoại không đúng");
            break;
          case AuthPageInvalidOtpActionState:
            ShowSnackBar.ErrorSnackBar(context, "Mã xác thực không đúng");
            break;
          case ShowSnackBarActionState:
            final snackBarState = state as ShowSnackBarActionState;
            if (snackBarState.status == true) {
              ShowSnackBar.SuccessSnackBar(context, snackBarState.message);
            } else {
              ShowSnackBar.ErrorSnackBar(context, snackBarState.message);
            }
            break;
          case AuthenticationLoadingState:
            final currentState = state as AuthenticationLoadingState;
            if (!currentState.isLoading) {
              _closeDialogHandle = closeLoadingDialog(context: context);
              _closeDialogHandle = null;
              _showDialogHandle = null;
            } else if (currentState.isLoading) {
              _showDialogHandle = showLoadingDialog(context: context);
            }
            break;
          case AuthenticationSuccessState:
            final successState = state as AuthenticationSuccessState;
            print("token:" + successState.token);
            Get.offAllNamed(LandingPage.LandingPageRouter,
                arguments: {'token': successState.token});
            break;
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ShowCreateOtpPageState:
            final currentState = state as ShowCreateOtpPageState;
            return CreateOtpPage(bloc: authPageBloc, phone: currentState.phone);
          case ShowLoginPageState:
            return LoginPage(bloc: authPageBloc);
          case ShowRegisterPageState:
            final currentState = state as ShowRegisterPageState;
            return RegisterPage(
              bloc: authPageBloc,
              phone: currentState.phone,
            );
        }
        return const SizedBox();
      },
    );
  }
}
