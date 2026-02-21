part of 'report_bloc.dart';

sealed class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

final class SubmitReportEvent extends ReportEvent {
  final int itemId;
  final String reason;

  const SubmitReportEvent({required this.itemId, required this.reason});

  @override
  List<Object> get props => [itemId, reason];
}

final class GetReportEvent extends ReportEvent {
  const GetReportEvent();

  @override
  List<Object> get props => [];
}
