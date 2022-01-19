// import 'dart:convert';
// import 'package:flutter/material.dart' hide Banner;
//
// import 'package:http/http.dart';
//
// class UserController {
//   //get banners
//   Future<ApiResponse> getBanners() async {
//     var request = await get(
//       Uri.parse("${Constants.domain}getBanners"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//       key: 'items',
//       fun: (json) => Banner.fromJson(json),
//     );
//     return response;
//   }
//
//   Future<ApiResponse> getMyChildren() async {
//     var request = await get(
//       Uri.parse("${Constants.domain}getMyChildrens"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//       key: 'items',
//       fun: (json) => Child.fromJson(json),
//     );
//     return response;
//   }
//
//   Future<ApiResponse> getServiceProviders() async {
//     var request = await get(
//       Uri.parse("${Constants.domain}getServiceProviders"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     print(output);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//       key: 'items',
//       fun: (json) => User.fromJson(json),
//     );
//     return response;
//   }
//
//   Future<MyBooking> getBookingDetails({int id}) async {
//     var request = await get(
//       Uri.parse("${Constants.domain}getBookingDetail/$id"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     print(output);
//     MyBooking response = MyBooking.fromJson(output['items']);
//     return response;
//   }
//
//   Future<ApiResponse> filter(
//       {int nearby,
//       int gender,
//       String lat,
//       String lng,
//       String priceFrom,
//       String priceTo,
//       List<Services> services,
//       int sorting}) async {
//     String _services = '';
//     for (var element in services) {
//       _services = _services + element.id.toString() + ',';
//     }
//     var request = await get(
//       Uri.parse(
//           "${Constants.domain}filter?nearby=$nearby&lat=$lat&lng=$lng&gender=$gender&price_from=${priceFrom ?? ''}&price_to=${priceTo ?? ''}&services=$_services&sorting=$sorting"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     print(output);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//       key: 'items',
//       fun: (json) => User.fromJson(json),
//     );
//     return response;
//   }
//
//   Future<ApiResponse> addRating({int id, String note, String rate}) async {
//     var request = await post(
//       Uri.parse("${Constants.domain}addRate"),
//       body: {
//         'booking_id': '$id',
//         'rate': rate,
//         'comment': note,
//       },
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     print(output);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//     );
//     return response;
//   }
//
//   //add or edit child
//   Future<ApiResponse> addOrEditChild(
//       {String name, int id, int gender, String birthday, bool isEdit}) async {
//     if (isEdit) {
//       var request = await post(
//         Uri.parse("${Constants.domain}editChildren/$id"),
//         body: {
//           'name': name,
//           'gender': gender.toString(),
//           'birth_date': birthday,
//         },
//         headers: Constants().headers,
//       );
//       var output = json.decode(request.body);
//       ApiResponse response = ApiResponse.fromJson(output);
//       return response;
//     }
//     var request = await post(
//       Uri.parse("${Constants.domain}addChildren"),
//       body: {
//         'name': name,
//         'gender': gender.toString(),
//         'birth_date': birthday,
//       },
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     print(output);
//     ApiResponse response = ApiResponse.fromJson(output);
//     return response;
//   }
//
//   Future<CheckCodeResponse> checkCode({
//     String code,
//   }) async {
//     var request = await post(
//       Uri.parse("${Constants.domain}checkCode"),
//       body: {
//         'discount_code': code,
//       },
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     CheckCodeResponse response = CheckCodeResponse.fromJson(
//       output,
//     );
//     return response;
//   }
//
//   Future<ApiResponse> checkOut(
//       {int packId,
//       int spId,
//       String code,
//       String childCount,
//       int cityId,
//       double lat,
//       double lng,
//       int paymentMethod,
//       String note}) async {
//     var request = await post(
//       Uri.parse("${Constants.domain}checkout"),
//       body: {
//         'package_id': '$packId',
//         'service_provider_id': '$spId',
//         'discount_code': code,
//         'num_children': childCount,
//         'city_id': '$cityId',
//         'lat': '$lat',
//         'lng': '$lng',
//         'payment_method': '$paymentMethod',
//         'note': note,
//       },
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//     );
//     return response;
//   }
// }
