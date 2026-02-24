import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:elonchi/features/auth/presentation/widgets/login_input.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final LoginBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state.welcomeStatus == ApiStatus.success) {
          final result = await context.push<bool>(
            Routes.otpConfirmScreen,
            extra: {
              'number': '${state.countryCode} ${state.number.trim()}',
              'initialSeconds': state.remainingOtpSeconds,
            },
          );

          // If user returned from OTP screen, we don't need to do anything
          // The OTP session info is already stored in LoginBloc state
          if (result == true) {
            // User pressed "change number" - they're back to login screen
            // LoginBloc state already has the OTP session info for smart handling
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WScaleAnimation(
                  onTap: () {
                    context.pop();
                  },
                  child: SvgPicture.asset(PIcons.arrowLeftIcon),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/images/login.png', height: 80, width: 80),
                const SizedBox(height: 20),
                Text(
                  'auth.login.title'.tr(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: context.color.textStrong),
                ),
                const SizedBox(height: 5),
                Text('auth.login.subtitle'.tr(), style: TextStyle(color: context.color.textSub)),
                const SizedBox(height: 20),
                Text('auth.login.phone_label'.tr(), style: TextStyle(color: context.color.textSoft)),
                PhoneInputs(
                  onChanged: (value) {
                    bloc.add(OnChanged(number: value));
                  },
                  onTap: () {},
                ),
                const Spacer(),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return ButtonWithScale(
                      isLoading: state.welcomeStatus == ApiStatus.loading,
                      textStyle: (state.number.length == 9)
                          ? TextStyle(color: context.color.white, fontSize: 16, fontWeight: FontWeight.w500)
                          : null,
                      onPressed: (state.number.length == 9)
                          ? () {
                              bloc.add(const Login());
                            }
                          : null,
                      text: 'auth.login.get_code'.tr(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
