import 'package:elonchi/features/report/domain/report_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepo reportRepo;
  ReportBloc(this.reportRepo) : super(ReportState()) {
    on<GetReportEvent>(onGetReport);
  }

  void onGetReport(GetReportEvent event, Emitter<ReportState> emit) async {
    final result = await reportRepo.getReports();
  }
}
