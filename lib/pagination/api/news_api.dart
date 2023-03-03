import 'package:dio/dio.dart';
import 'package:pageination/pagination/data/leBazarData.dart';

class NewsApi {
  final dio = Dio(BaseOptions(
    baseUrl: "https://api.lebazar.uz/api/v1",
    connectTimeout: 60000,
  ));

  Future<List<LeBazarData>> news({
    int offset = 0,
    int limit = 10,
    String search = "",
  }) async {
    final response = await dio.get(
      "/search/product?start=$offset&limit=$limit&searchKey=$search",
      options: Options(headers: {"companyId": 78}),
    );
    return (response.data["data"]["list"] as List)
        .map((e) => LeBazarData.fromJson(e))
        .toList();
  }
}
