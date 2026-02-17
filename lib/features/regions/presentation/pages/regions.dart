import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/regions/presentation/bloc/regions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegionsSheet extends StatefulWidget {
  const RegionsSheet({super.key});

  @override
  State<RegionsSheet> createState() => _RegionsSheetState();
}

class _RegionsSheetState extends State<RegionsSheet> {
  late final RegionsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<RegionsBloc>();
    bloc.add(const GetRegionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.8,
      child: Column(
        children: [
          Row(
            children: [
              WScaleAnimation(
                onTap: () {
                  context.pop();
                },
                child: SvgPicture.asset(PIcons.arrowLeftIcon),
              ),
              const Spacer(),
              Text(
                "Выберите город",
                style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 20),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<RegionsBloc, RegionsState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.regions.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final region = state.regions[index];
                    return WScaleAnimation(
                      onTap: () {
                        context.pop(region);
                      },
                      child: Container(
                        padding: .symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(borderRadius: .circular(12), color: context.color.bgelevation),
                        child: Row(
                          children: [
                            Text(region.name ?? '', style: TextStyle(color: context.color.textStrong)),
                            const Spacer(),
                            SvgPicture.asset(PIcons.arrowRightIcon),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
