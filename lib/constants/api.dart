import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

String ipAddress = 'https://petropal.sandbox.co.ke:8040';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio();

  Future<dynamic> post(String path, dynamic data,
      {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post('$ipAddress$path',
          data: data, options: Options(headers: headers));
      return response.data;
    } on DioException catch (error) {
      return error.response?.data;
    }
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get('$ipAddress$path',
          queryParameters: queryParameters, options: Options(headers: headers));
      return response.data;
    } on DioException catch (error) {
      return error.response;
    }
  }
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  //static double? blockSizeHorizontal;
  static double? blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

showToast(context, String title, String message, Color color) {
  return showOverlayNotification((context) {
    return MessageNotification(
      title: title,
      message: message,
      color: color,
      onReply: () {
        OverlaySupportEntry.of(context)!.dismiss();
      },
    );
  });
}

class MessageNotification extends StatelessWidget {
  final VoidCallback onReply;
  final String message;
  final String? title;
  final Color? color;

  const MessageNotification({
    Key? key,
    required this.onReply,
    required this.message,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal! * 90,
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 1,
        ),
        color: color ?? Colors.green,
        child: ListTile(
          title: title == null
              ? null
              : Text(
                  '$title',
                  style: MyTheme.darkTheme.textTheme.bodyMedium!
                      .copyWith(color: backColor),
                ),
          subtitle: Text(
            message,
            style: MyTheme.darkTheme.textTheme.bodyLarge!
                .copyWith(color: backColor),
          ),
        ),
      ),
    );
  }
}
