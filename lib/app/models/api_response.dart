import 'package:uni_lecture/app/shared/utils/enums.dart';

class ApiResponse {
  final ApiResponseType type;
  final dynamic response;

  ApiResponse({required this.type, required this.response});
}
