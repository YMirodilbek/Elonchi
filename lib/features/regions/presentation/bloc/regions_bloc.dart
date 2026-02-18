import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/regions/data/regions_response.dart';
import 'package:elonchi/features/regions/domain/regions_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'regions_event.dart';
part 'regions_state.dart';

class RegionsBloc extends Bloc<RegionsEvent, RegionsState> {
  final RegionsRepo repository;
  RegionsBloc(this.repository) : super(const RegionsState()) {
    on<GetRegionsEvent>(getRegions);
  }

  void getRegions(GetRegionsEvent event, Emitter<RegionsState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await repository.getRegions();
    if (result.ok) {
      emit(state.copyWith(regions: result.data, apiStatus: ApiStatus.success));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }
}
