import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/driver.dart';
import 'package:petropal/models/order.dart';
import 'package:petropal/models/truck.dart';
import 'package:petropal/providers/driver.dart';
import 'package:petropal/providers/order.dart';
import 'package:petropal/providers/truck.dart';

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


  // adding a driver.

  Future<dynamic> addDriver(String path,dynamic data, {Map<String, dynamic>? headers}) async {
    try{

      // start loading

      DriverProvider().startLoading();

      // fetch

      final response = await _dio.post('$ipAddress$path',
          data: data, options: Options(headers: headers));

      // check if it is a successful response.

      Map<String,dynamic> jsonResponse = jsonDecode(response.data);

      if(jsonResponse['status'] == '1'){

          // successful, seed the data to the model
          DriverModel addedDriver = DriverModel(
              id: jsonResponse['data']['id'].toString(),
              fullName: jsonResponse['data']['full_name'].toString(),
              idNumber: jsonResponse['data']['id_number'].toString(),
              phoneNumber: jsonResponse['data']['phone_number'].toString(),
              epraLicenseNumber: jsonResponse['data']['epra_licence_number'].toString(),
              licenseNumber: jsonResponse['data']['licence_number'].toString(),
              status: jsonResponse['data']['status'].toString(),
              createdBy: jsonResponse['data']['created_by'].toString(),
              createdAt: jsonResponse['data']['createdAt'].toString(),
              updatedAt: jsonResponse['data']['updatedAt'].toString()
          );


          // seed the data to the provider.
          DriverProvider().addDriver(addedDriver);

          // stop loading.
          DriverProvider().stopLoading();

          // return the newly created driver to the screen.
          return addedDriver;


      }else{

        DriverProvider().stopLoading();

        // throw an exception, a server error occurred

        throw Exception(jsonResponse['message']);

      }
    }on DioException catch(error){

      DriverProvider().stopLoading();

      return error.response?.data;
    }

  }


  // listing drivers.

  Future<dynamic> fetchDrivers(String path,{Map<String, dynamic>? queryParameters,Map<String, dynamic>? headers}) async {
    try {

      // start the loading
      DriverProvider().startLoading();

      // fetch

      final response = await _dio.post('$ipAddress$path',data: null, options: Options(headers: headers));

      // check the status code returned.

      Map<String,dynamic> jsonResponse = jsonDecode(response.data);


      if(jsonResponse['status'] == '1'){ // Very successful response

        List<DriverModel> drivers = [];

        // map through the returned drivers.
        List fetchedDrivers = jsonResponse['data'];

        for (var element in fetchedDrivers) {

          // append the driver to the drivers list.

          drivers.add(DriverModel(
              id: element['id'].toString(),
              fullName: element['full_name'].toString(),
              idNumber: element['id_number'].toString(),
              phoneNumber: element['phone_number'].toString(),
              epraLicenseNumber: element['epra_licence_number'].toString(),
              licenseNumber: element['licence_number'].toString(),
              status: element['status'].toString(),
              createdBy: element['created_by'].toString(),
              createdAt: element['createdAt'].toString(),
              updatedAt: element['updatedAt'].toString()
          ));

        }

        // append the drivers.
        DriverProvider().addDrivers(drivers);

        // set the loading to off.
        DriverProvider().stopLoading();

        return;

      }else{

        // set the loading to off.
        DriverProvider().stopLoading();

        // some  server error occurred.
        throw Exception(jsonResponse['message']);

      }
    } on DioException catch (error) {

      // set the loading to off.
      DriverProvider().stopLoading();

      return error.response?.data;
    }
  }


  // adding a truck.

  Future<dynamic> addTruck(String path,dynamic data, {Map<String, dynamic>? headers}) async {
    try{

      // start loading

      TruckProvider().startLoading();

      // fetch

      final response = await _dio.post('$ipAddress$path',
          data: data, options: Options(headers: headers));

      // check if it is a successful response.

      Map<String,dynamic> jsonResponse = jsonDecode(response.data);

      if(jsonResponse['status'] == '1'){

        // successful, seed the data to the model
        TruckModel addedTruck = TruckModel(
            id: jsonResponse['data']['id'].toString(),
            registrationNumber: jsonResponse['data']['registration_number'].toString(),
            compartment: jsonResponse['data']['compartment'].toString(),
            status: jsonResponse['data']['status'].toString(),
            createdBy: jsonResponse['data']['created_by'].toString(),
            createdAt: jsonResponse['data']['createdAt'].toString(),
            updatedAt: jsonResponse['data']['updatedAt'].toString()
        );


        // seed the data to the provider.
        TruckProvider().addTruck(addedTruck);

        // stop loading.
        TruckProvider().stopLoading();

        // return the newly created driver to the screen.
        return addedTruck;


      }else{

        TruckProvider().stopLoading();

        // throw an exception, a server error occurred

        throw Exception(jsonResponse['message']);

      }
    }on DioException catch(error){

      TruckProvider().stopLoading();

      return error.response?.data;
    }

  }


  // listing trucks.
  Future<dynamic> fetchTrucks(String path,{Map<String, dynamic>? queryParameters,Map<String, dynamic>? headers}) async {
    try {

      // start the loading
      TruckProvider().startLoading();

      // fetch

      final response = await _dio.post('$ipAddress$path',data: null, options: Options(headers: headers));

      // check the status code returned.

      Map<String,dynamic> jsonResponse = jsonDecode(response.data);


      if(jsonResponse['status'] == '1'){ // Very successful response

        List<TruckModel> trucks = [];

        // map through the returned trucks.
        List fetchedTrucks = jsonResponse['data'];

        for (var element in fetchedTrucks) {

          // append the truck to the trucks list.

          trucks.add(TruckModel(
              id: element['id'].toString(),
              registrationNumber: element['registration_number'].toString(),
              compartment: element['compartment'].toString(),
              status: element['status'].toString(),
              createdBy: element['created_by'].toString(),
              createdAt: element['createdAt'].toString(),
              updatedAt: element['updatedAt'].toString()
          ));

        }

        // append the drivers.
        TruckProvider().addTrucks(trucks);

        // set the loading to off.
        TruckProvider().stopLoading();

        return;

      }else{

        // set the loading to off.
        TruckProvider().stopLoading();

        // some  server error occurred.
        throw Exception(jsonResponse['message']);

      }
    } on DioException catch (error) {

      // set the loading to off.
      TruckProvider().stopLoading();

      return error.response?.data;
    }
  }


  // making an order.
  Future<dynamic> makeOrder(String path,dynamic data, {Map<String, dynamic>? headers}) async {
    try{

      // start loading

      OrderProvider().startLoading();

      // fetch

      final response = await _dio.post('$ipAddress$path',
          data: data, options: Options(headers: headers));

      // check if it is a successful response.

      Map<String,dynamic> jsonResponse = jsonDecode(response.data);

      if(jsonResponse['status'] == '1'){

        // successful, seed the data to the model
        OrderModel addedOrder = OrderModel(
            id: jsonResponse['data']['id'].toString(),
            commissionEarned: jsonResponse['data']['commission_earned'].toString(),
            driverId: jsonResponse['data']['driver_id'].toString(),
            truckId: jsonResponse['data']['truck_id'].toString(),
            invoiceNumber: jsonResponse['data']['invoice_number'].toString(),
            payableAmount: jsonResponse['data']['payable_amount'].toString(),
            paymentBankOption: jsonResponse['data']['payment_bank_option'].toString(),
            invoiceDocument: jsonResponse['data']['invoice_document'].toString(),
            accountId: jsonResponse['data']['account_id'].toString(),
            status: jsonResponse['data']['status'].toString(),
            createdBy: jsonResponse['data']['created_by'].toString(),
            createdAt: jsonResponse['data']['createdAt'].toString(),
            updatedAt: jsonResponse['data']['updatedAt'].toString()
        );


        // seed the data to the provider.
        OrderProvider().addOrder(addedOrder);

        // stop loading.
        OrderProvider().stopLoading();

        // return the newly created driver to the screen.
        return addedOrder;


      }else{

        OrderProvider().stopLoading();

        // throw an exception, a server error occurred

        throw Exception(jsonResponse['message']);

      }
    }on DioException catch(error){

      OrderProvider().stopLoading();

      return error.response?.data;
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
