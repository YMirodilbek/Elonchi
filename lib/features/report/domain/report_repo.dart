import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';

abstract class ReportRepo {
  Future<ResponseData<void>> getReports();
  Future<ResponseData<void>> sendReport(int objectId, String type, String text);
}

class ReportRepoImpl extends ReportRepo {
  final RequestManager requestManager;
  ReportRepoImpl(this.requestManager);
  @override
  Future<ResponseData<void>> getReports() {
    return requestManager.request(requestType: RequestType.get, path: PUrls.getComplaints);
  }

  @override
  Future<ResponseData<void>> sendReport(int objectId, String type, String text) {
    final data = {"object_id": objectId, "type": type, "text": text};
    return requestManager.request(requestType: RequestType.post, path: PUrls.createComplaint, data: data);
  }
}
