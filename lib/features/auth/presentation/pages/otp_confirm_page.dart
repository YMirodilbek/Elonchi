import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/auth/presentation/blocs/login_bloc/login_bloc.dart' as login_bloc;
import 'package:elonchi/features/auth/presentation/blocs/otp_bloc/otp_bloc.dart';
import 'package:elonchi/features/auth/presentation/widgets/pinput.dart';
import 'package:elonchi/features/profile/presentation/blocs/profile_main/profile_bloc.dart';
import 'package:elonchi/injector_container.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class OtpConfirmPage extends StatefulWidget {
  final String number;
  final int? initialSeconds;
  const OtpConfirmPage({super.key, required this.number, this.initialSeconds});

  @override
  State<OtpConfirmPage> createState() => _OtpConfirmPageState();
}

class _OtpConfirmPageState extends State<OtpConfirmPage> {
  late final OtpBloc bloc;
  late final login_bloc.LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<OtpBloc>();
    loginBloc = sl<login_bloc.LoginBloc>();

    bloc.add(InitialTimerEvent(initialSeconds: widget.initialSeconds));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state.status == ApiStatus.success) {
          sl<ProfileBloc>().add(ChangeLoggedIn(true));
          sl<ProfileBloc>().add(GetUserEvent());
          context.go(Routes.home);
        }
      },
      child: Scaffold(
        body: BlocBuilder<OtpBloc, OtpState>(
          builder: (context, otpState) {
            return SafeArea(
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
                    Image.asset('assets/images/otp_img.png', height: 80, width: 80),
                    const SizedBox(height: 20),
                    Text(
                      'auth.otp.title'.tr(),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: context.color.textStrong),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${'auth.otp.sms_sent'.tr()} ${widget.number}',
                      style: TextStyle(color: context.color.textSub),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: PinInput(
                        error: otpState.hasError,
                        onCompleted: (code) {
                          bloc.add(ChangeCodeEvent(code: code));
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: otpState.seconds != 0
                          ? Text(
                              '${"auth.new.code".tr()} ${formatToMinutesSeconds(otpState.seconds)}',
                              style: TextStyle(color: context.color.textSub),
                            )
                          : WScaleAnimation(
                              onTap: () {
                                loginBloc.add(login_bloc.ResendOtp());
                                bloc.add(InitialTimerEvent(initialSeconds: widget.initialSeconds));
                              },
                              child: Center(
                                child: Text(
                                  'auth.otp.resend'.tr(),
                                  style: TextStyle(
                                    color: context.color.textSub,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                    ),

                    const Spacer(),
                    BlocBuilder<OtpBloc, OtpState>(
                      builder: (context, state) {
                        return ButtonWithScale(
                          isLoading: state.status == ApiStatus.loading,
                          textStyle: (state.code.length == 6)
                              ? TextStyle(color: context.color.white, fontSize: 16, fontWeight: FontWeight.w500)
                              : null,
                          onPressed: state.code.length == 6
                              ? () {
                                  if (state.code.length == 6) {
                                    bloc.add(ConfirmOtp(number: widget.number));
                                  }
                                }
                              : null,
                          text: "auth.otp.confirm".tr(),
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
