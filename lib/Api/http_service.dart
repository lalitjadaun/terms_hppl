import 'package:dio/dio.dart';
import 'package:terms_hppl/Api/url_endpoints.dart';

class HttpService{
  late Dio _dio;

  //final baseUrl ="http://103.205.66.226:8082/TERMSHPPL/";
  final baseUrl ="http://45.64.8.42:8080/TermsPgSql/";

  HttpService() {
    _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: { "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Basic bW9iaWxlLWFuZHJvaWQ6c2VjcmV0"
          },
          responseType: ResponseType.json,
          receiveTimeout: 300000,
          connectTimeout: 1000000,
          followRedirects: false,
          receiveDataWhenStatusError: true,

        )
    );
    //initializeInterceptor();

  }

  //COMPANY NAME
  Future<Response> getCompanyName() async {
    Response response;
    try {
      response =
      await _dio.post(baseUrl + UrlEndPoints.COMPANYNAME, options:
      Options(headers: { "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode != 200) {
        print("User Type Call Getting error Code of ${e.response?.statusCode}");
      }
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }


  //USERDETAIL
  Future<Response> getUserDetail(String userName) async {
    Response response;
    try {
      response =
      await _dio.post(baseUrl + UrlEndPoints.USERDETAIL,
        data: {
        'userName':userName,
        },
        options:
      Options(headers: { "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode != 200) {
        print("User Type Call Getting error Code of ${e.response?.statusCode}");
      }
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  //UNIT LIST
  Future<Response> getUnitList(String userId) async {
    Response response;
    try {
      response =
      await _dio.post(baseUrl + UrlEndPoints.UNITLIST,
        data: {'userId':userId,
        },
        options:
      Options(headers: { "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode != 200) {
        print("User Type Call Getting error Code of ${e.response?.statusCode}");
      }
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  //LoginCall
  Future<Response> getLoginCall(String unit_cd, String userId,String userName, String userPass) async {
    Response response;
    try {
      response =
      await _dio.post(baseUrl + UrlEndPoints.LOGINCALL,
        data: {
        'unit_cd':unit_cd,
        'userId':userId,
        'userName':userName,
        'userPass':userPass,
        },
        options:
      Options(

          headers: { "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode != 200) {
        print("LOGIN Call Getting error Code of ${e.response?.statusCode}");
      }
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  //CategoryList
  Future<Response> getCategoryList(String emp_cd,String unit_cd ) async {
    Response response;

    try {
      response =
      await _dio.post(baseUrl + UrlEndPoints.GETCATEGORYLIST+"/"+emp_cd+"/"+unit_cd, options:
      Options(headers: { "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 200) {
        print("CATEGORY CALL Getting Error code ${e.response?.statusCode}");
      }
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  //CategoryList Purchase Ordewr
  Future<Response> getCategoryListDetails(int amd_no,String doc_type, String emp_cd, String unit_cd ) async {
    Response response;

    try {
      response =
      await _dio.post(baseUrl + UrlEndPoints.GETCATEGORYLIST,
        data: {
        'amd_no': amd_no,
        'doc_type': doc_type,
        'emp_cd': emp_cd,
        'unit_cd': unit_cd,
        },
        options:
      Options(headers: { "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 200) {
        print("PURCHASE ORDER CALL Getting Error code ${e.response?.statusCode}");
      }
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  //View Tab
  Future<Response> getViewTabDetails(int doc_amd_no,String doc_number) async {
    Response response;

    try {
      response =
      await _dio.post(baseUrl + UrlEndPoints.GETCATEGORYLISTDETAILS,
        data: {
        'doc_amd_no': doc_amd_no,
        'doc_number': doc_number,
        },
        options:
      Options(headers: { "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 200) {
        print("VIEW TAB CALL Getting Error code ${e.response?.statusCode}");
      }
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }


  //Approve and revert
  Future<Response> getApproveandRevert(int amdNO,String appDt, String appStage,
      String area,String comp_code,String doc_type,String poNo,String remark,String unit_code
      ) async {
    Response response;

    try {
      response =
      await _dio.post(baseUrl + UrlEndPoints.GETAPPROVAL,
        data: {
          'amdNO': amdNO,
          'appDt': appDt,
          'appStage': appStage,
          'area': area,
          'comp_code': comp_code,
          'doc_type': doc_type,
          'poNo': poNo,
          'remark': remark,
          'unit_code': unit_code,
        },
        options:
        Options(headers: { "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 200) {
        print("APPROVE AND REVERT CALL Getting Error code ${e.response?.statusCode}");
      }
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }


  //STOCKGRAPH
  Future<Response> getStockGraphView() async {
    Response response;

    try {
      response =
      await _dio.get(baseUrl + UrlEndPoints.GETSTOCKGRAPHVIEW,
        options:
        Options(headers: { "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 200) {
        print("STOCK GRAPH CALL Getting Error code ${e.response?.statusCode}");
      }
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

}