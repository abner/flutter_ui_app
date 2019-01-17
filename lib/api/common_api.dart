import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonApi {
  static const String baseUrl = 'https://api.kilimall.com';
  Future<dynamic> goodsList(page) async {
    final getUri = baseUrl + '/shops/v1/ke/shop_goods';
    Dio dio = new Dio();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String acc = prefs.getString('access_token');
      String auth = 'Bearer ';
      Map<String, dynamic> header = {'Authorization': '${auth}${acc}'};
      final response = await dio.get(getUri,
          data: {'page': page}, options: new Options(headers: header));
      var resData = response.data;
      if (resData['code'] == 200) {
        return resData['data']['goods_list']['data'];
      }
    } on DioError catch (e) {
      if (e.response != '') {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.message);
      }
    }
  }

  Future<dynamic> goodsDetail(id) async {
    final getUri =
        'https://mobile.kilimall.co.ke/index.php?act=goods&op=new_goods_detail';
    Dio dio = new Dio();
    try {
      final response = await dio.get(getUri, data: {'goods_id': id});
      var resData = jsonDecode(response.data);
      if (resData['code'] == 200) {
        return resData['datas'];
      }
    } on DioError catch (e) {
      if (e.response != '') {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.message);
      }
    }
  }

  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var acc = prefs.getString('access_token');
    return acc;
  }

  Future<dynamic> login(username, password) async {
    final getUri = baseUrl + '/shops/v1/ke/login';
    Dio dio = new Dio();
    try {
      var response = await dio.post(getUri,
          data: {'username': username, 'password': password, 'client': 'wap'});
      var res_data = response.data;
      if (res_data['code'] == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', username);
        prefs.setString('access_token', res_data['data']['access_token']);
        prefs.setString('refresh_token', res_data['data']['refresh_token']);
        prefs.setString('access_key', res_data['data']['data']['token']);
      }
      return res_data;
    } on DioError catch (e) {
      if (e.response != '') {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.message);
      }
    }
  }
}

CommonApi api = CommonApi();
