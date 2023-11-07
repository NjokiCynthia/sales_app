import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ButtonUtils {
  static Widget ElevatedButton({
    required Function() onPressed,
    required Widget child,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget textButton({
    required Function() onPressed,
    required Widget child,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.transparent; // Set the color to transparent
            }
            return Colors
                .transparent; // Use the default overlay color for other states
          },
        ),
      ),
      child: child,
    );
  }
}

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
    setState(() {
      isButtonDisabled = true;
      isLoading = true;
    });

    try {
      final response = await _makeRequest();
      setState(() {
        isButtonDisabled = false;
        isLoading = false;
      });
      if (response.statusCode == 200) {
        // Request was successful
        widget
            .onSuccess({'isSuccessful IS HERE ': true, 'data': response.data});
      } else {
        // Request returned an error status code
        widget.onSuccess({
          'isSuccessful': false,
          'error': response.data['error'],
        });
      }
    } on DioException catch (error) {
      setState(() {
        isButtonDisabled = false;
        isLoading = false;
      });
      print('error8***********');
      print(error.response);
      var theError = error.response?.data;
      var theStatus = error.response?.statusCode;

      if (theStatus != 500) {
        return widget.onSuccess({
          'isSuccessful': false,
          'error': theError['error'],
        });
      }
      widget.onSuccess({
        'isSuccessful': false,
        'error': 'Error making request',
      });
    }

    setState(() {
      isButtonDisabled = false;
      isLoading = false;
    });
  }

  Future<Response<dynamic>> _makeRequest() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final options = Options(contentType: 'application/json', headers: headers);
    print('here it is ${ipAddress + widget.url!}');
    print(widget.body);
    print(options);

    try {
      if (widget.method == 'POST') {
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
      onTap: isButtonDisabled ? null : sendRequest,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 10000),
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
                )
              : Text(
                  widget.buttonText,
                  style: MyTheme.darkTheme.textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
