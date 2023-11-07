import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';

class CustomRequestButton extends StatefulWidget {
  final bool? buttonError;
  final String? buttonErrorMessage;
  final String? url;
  final String method;
  final String buttonText;
  final Map<String, dynamic> body;
  final dynamic onSuccess;

  const CustomRequestButton({
    super.key,
    this.buttonError,
    this.buttonErrorMessage,
    this.url,
    required this.method,
    required this.buttonText,
    required this.body,
    required this.onSuccess,
    required Map<String, String> headers,
  });

  @override
  _CustomRequestButtonState createState() => _CustomRequestButtonState();
}

class _CustomRequestButtonState extends State<CustomRequestButton> {
  bool isButtonDisabled = false;
  bool isLoading = false;
  late Dio _dio;
  String errorText = '';

  @override
  void initState() {
    super.initState();
    _dio = Dio();
  }

  Future<void> sendRequest() async {
    if (widget.buttonError == true) {
      return widget.onSuccess({
        'isSuccessful': false,
        'error': widget.buttonErrorMessage,
      });
    }

    if (widget.url == null) {
      return widget.onSuccess({'isSuccessful': true});
    }

    setState(() {
      isButtonDisabled = true;
      isLoading = true;
      errorText = ''; // Clear the previous error message
    });

    try {
      final response = await _makeRequest();
      if (response.statusCode == 200) {
        // Request was successful
        widget.onSuccess({'isSuccessful': true, 'data': response.data});
      } else {
        // Request returned an error status code
        setState(() {
          errorText = response.data['message'];
        });
        widget.onSuccess({
          'isSuccessful': false,
          'error': response.data['error'],
        });
      }
    } on DioException catch (error) {
      print('error');
      print(error);
    }

    setState(() {
      isButtonDisabled = false;
      isLoading = false;
    });
  }

  Future<Response<dynamic>> _makeRequest() async {
    // Retrieve user information from provider
    final headers = {
      'Versioncode': 99,
      'version': 99,
    };
    final options = Options(contentType: 'application/json', headers: headers);
    try {
      if (widget.method == 'POST') {
        print('url: ${ipAddress + widget.url!}');
        print('widget.body');
        return _dio.post(
          ipAddress + widget.url!,
          data: widget.body,
          options: options,
        );
      } else if (widget.method == 'GET') {
        return _dio.get(ipAddress + widget.url!, options: options);
      }
    } catch (error) {
      throw Exception('Invalid request method: ${widget.method}');
    }
    throw Exception('Invalid request method: ${widget.method}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sendRequest,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 2000),
        decoration: BoxDecoration(
          color: primaryDarkColor,
          borderRadius:
              isLoading ? BorderRadius.circular(8) : BorderRadius.circular(8),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          child: isLoading
              ? const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 20,
                )
              : Text(
                  widget.buttonText,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
        ),
      ),
    );
  }
}
