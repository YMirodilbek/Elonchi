import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/profile/data/user_response.dart';
import 'package:elonchi/features/profile/presentation/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:elonchi/features/profile/presentation/widgets/image_change_options.dart';
import 'package:elonchi/features/profile/presentation/widgets/name_input.dart';
import 'package:elonchi/features/profile/presentation/widgets/phone_input.dart';
import 'package:elonchi/features/profile/presentation/widgets/top_info_part.dart';
import 'package:elonchi/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProfileEditPage extends StatefulWidget {
  final UserModel userModel;
  const ProfileEditPage({super.key, required this.userModel});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late final ProfileEditBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ProfileEditBloc>();
    bloc.add(EditProfileInfoEvent(widget.userModel));
    bloc.add(InitControllerEvent(TextEditingController(text: widget.userModel.firstName)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: WScaleAnimation(
          onTap: () {
            context.pop();
          },
          child: Padding(padding: const EdgeInsets.all(11.0), child: SvgPicture.asset(PIcons.arrowLeftIcon)),
        ),
        title: Text(
          "nav.profile".tr(),
          style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocListener<ProfileEditBloc, ProfileEditState>(
        listener: (context, state) {
          if (state.apiStatus == ApiStatus.success) {
            context.pop(state.userModel);
          }
        },
        child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopInfoPart(
                      pickedImg: state.pickedImg,
                      selectedImageIndex: localSource.selectedPhotoIndex,
                      userModel: state.userModel,
                      onImageAddTap: () {
                        bloc.add(const ChangeUserImgEvent());
                      },
                    ),
                    ImageChangeOptions(
                      selectedImg: localSource.selectedPhotoIndex,
                      onImageSelect: (inxed) {
                        localSource.setSelectedPhIndex(inxed);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16),
                    NameInput(
                      controller: state.controller,
                      onChanged: (value) {
                        bloc.add(EditProfileInfoEvent(state.userModel.copyWith(firstName: value)));
                      },
                      userName: state.userModel.firstName ?? '',
                    ),
                    const SizedBox(height: 16),
                    PhoneInput(phoneNumber: state.userModel.phoneNumber ?? ''),
                    const SizedBox(height: 150),
                    ButtonWithScale(
                      onPressed: (state.userModel.firstName == null || state.userModel.firstName!.trim().isEmpty)
                          ? null
                          : () {
                              bloc.add(EditProfileEvent(state.userModel));
                            },
                      text: 'save'.tr(),
                      textStyle: (state.userModel.firstName == null || state.userModel.firstName!.trim().isEmpty)
                          ? null
                          : TextStyle(color: context.color.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    ButtonWithScale(
                      onPressed: () {},
                      text: "profile.delete_account".tr(),
                      color: Color(0xffFFDBDC),
                      textStyle: TextStyle(color: context.color.errorColor, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 40),
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
