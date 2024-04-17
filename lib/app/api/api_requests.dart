import 'dart:convert';
import 'dart:io';
import 'package:uni_lecture/app/shared/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';
import '../shared/utils/debug_print.dart';
import '../shared/utils/shared_pref.dart';
import '../shared/utils/show_toast.dart';
import '../shared/utils/strings.dart';
import 'api_endpoints.dart';

///POST REQUEST
Future<ApiResponse> postRequest(
    {required String route,
    required BuildContext context,
    required Map<String, dynamic> payload,
    bool isAuthorized = true}) async {
  try {
    var response = await http
        .post(Uri.parse(Apis.baseUrl + route),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              if (isAuthorized) "Authorization": "Bearer ${await getString('token')}"
            },
            body: jsonEncode(payload))
        .timeout(const Duration(seconds: 60));

    dPrint('statusCode::: ${response.statusCode}');
    dPrint('response::: ${response.body}');

    //success
    if (response.statusCode == 200 || response.statusCode == 201) {
      dPrint('request successful:::');
      return ApiResponse(type: ApiResponseType.success, response: response.body);
    }
    //failure
    else {
      dPrint('request failed:::');
      return ApiResponse(type: ApiResponseType.failed, response: response.body);
    }
  } on SocketException {
    dPrint('socket exception:::');
    showToast(message: AppTexts.serverError, toastType: ToastType.info, context: context);
    return ApiResponse(type: ApiResponseType.server, response: null);
  } catch (e) {
    dPrint('exception::: $e');
    showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: context);
    return ApiResponse(type: ApiResponseType.exception, response: null);
  }
}

///GET REQUEST
Future<ApiResponse> getRequest({required String route, required BuildContext context, bool isAuthorized = true}) async {
  try {
    var response = await http.get(Uri.parse(Apis.baseUrl + route), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      if (isAuthorized) "Authorization": "Bearer ${await getString('token')}"
    }).timeout(const Duration(seconds: 60));

    dPrint('statusCode::: ${response.statusCode}');
    dPrint('response::: ${response.body}');

    //success
    if (response.statusCode == 200 || response.statusCode == 201) {
      dPrint('request successful:::');
      return ApiResponse(type: ApiResponseType.success, response: response.body);
    }
    //failure
    else {
      dPrint('request failed:::');
      return ApiResponse(type: ApiResponseType.failed, response: response.body);
    }
  } on SocketException {
    dPrint('socket exception:::');
    showToast(message: AppTexts.serverError, toastType: ToastType.info, context: context);
    return ApiResponse(type: ApiResponseType.server, response: null);
  } catch (e) {
    dPrint('exception::: $e');
    showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: context);
    return ApiResponse(type: ApiResponseType.exception, response: null);
  }
}
