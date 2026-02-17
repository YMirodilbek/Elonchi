import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/regions/data/regions_response.dart';

abstract class RegionsRepo {
  Future<ResponseData<List<RegionResponse>>> getRegions();
}

class RegionsRepoImpl extends RegionsRepo {
  final RequestManager requestManager;
  RegionsRepoImpl(this.requestManager);

  @override
  Future<ResponseData<List<RegionResponse>>> getRegions() async {
    return requestManager.request<List<RegionResponse>>(
      requestType: RequestType.get,
      path: PUrls.getRegions,
      dataParser: (json) {
        final List<RegionResponse> regions = [];
        for (final item in json) {
          regions.add(RegionResponse.fromJson(item));
        }
        return regions;
      },
    );
  }
}
