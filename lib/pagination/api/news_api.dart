import 'package:dio/dio.dart';
import 'package:pageination/pagination/data/leBazarData.dart';
import 'package:pageination/pagination/data/texnomartData.dart';

class NewsApi {
  final dio = Dio();

  Future<List<LeBazarData>> news({
    int offset = 0,
    int limit = 10,
    String search = "",
  }) async {
    final response = await dio.get(
      "https://api.lebazar.uz/api/v1/search/product?start=$offset&limit=$limit&searchKey=$search",
      options: Options(headers: {"companyId": 78}),
    );
    return (response.data["data"]["list"] as List)
        .map((e) => LeBazarData.fromJson(e))
        .toList();
  }


  Future <TexnomartData> texnomartData({
    int current=0,
    String search=""
}) async{

    final response = await dio.get(
        "https://backend.texnomart.uz/api/v2/search/search?q=${search}&page=$current",
    );
    print("ssss ${search} v${response.data}");
    return TexnomartData.fromJson(response.data["data"]);

  }

}
