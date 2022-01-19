// import 'dart:convert';
//
// import 'package:http/http.dart';
//
// class ProviderController {
//   ApiResponse revenuesResponse;
//   ApiResponse myBookingsResponse;
//   ApiResponse clientsResponse;
//
//   Future<StatsResponse> getStatistics() async {
//     var request = await get(
//       Uri.parse("${Constants.domain}getStatistics"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     StatsResponse response = StatsResponse.fromJson(
//       output,
//     );
//     // print(response.response);
//     return response;
//   }
//
//   Future<ApiResponse> getMyProfile() async {
//     var request = await get(
//       Uri.parse("${Constants.domain}MyProfile"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//       key: 'user',
//       fun: (json) => ServiceProvider.fromJson(json),
//     );
//     // print(response.response);
//     return response;
//   }
//
//   Future<Booking> getBookingDetails({int id}) async {
//     var request = await get(
//       Uri.parse("${Constants.domain}getBookingDetails/$id"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     Booking response = Booking.fromJson(output['items']);
//     print(response);
//     return response;
//   }
//
//   Future<ApiResponse> editMyServices({List<int> services}) async {
//     String svc = '';
//
//     for (var item in services) {
//       if (item == services.last) {
//         svc = svc + '$item';
//       } else {
//         svc = svc + '$item' + ',';
//       }
//     }
//     var request = await post(
//       Uri.parse("${Constants.domain}editMyServices"),
//       body: {'newService': '$services'},
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//     );
//     return response;
//   }
//
//   Future<ApiResponse> editMyAgeCategories({List<int> ages}) async {
//     String cats = '';
//
//     for (var item in ages) {
//       if (item == ages.last) {
//         cats = cats + '$item';
//       } else {
//         cats = cats + '$item' + ',';
//       }
//     }
//     var request = await post(
//       Uri.parse("${Constants.domain}editAgeCategories"),
//       body: {'age_categories': cats},
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//     );
//     return response;
//   }
//
//   Future<ApiResponse> getRevenue() async {
//     var request = await get(
//       Uri.parse("${Constants.domain}getRevenue"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     revenuesResponse = ApiResponse.fromJson(
//       output,
//       key: 'items',
//       fun: (json) => Revenue.fromJson(json),
//     );
//     return revenuesResponse;
//   }
//
//   Future<ApiResponse> getClients() async {
//     var request = await get(
//       Uri.parse("${Constants.domain}getClients"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     clientsResponse = ApiResponse.fromJson(
//       output,
//       key: 'items',
//       fun: (json) => User.fromJson(json),
//     );
//     return clientsResponse;
//   }
//
//   Future<ApiResponse> acceptOrRejectBooking({int id, String acceptance}) async {
//     var request = await post(
//       Uri.parse("${Constants.domain}acceptOrReject/$id"),
//       body: {'status': acceptance},
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//     );
//     return response;
//   }
//
//   Future<ApiResponse> completedBooking({
//     int id,
//   }) async {
//     var request = await get(
//       Uri.parse("${Constants.domain}completedBooking/$id"),
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//     );
//     return response;
//   }
//
//   Future<ApiResponse> addAdditionalTime(
//       {int id, String hours, String cost}) async {
//     var request = await post(
//       Uri.parse("${Constants.domain}addAdditionalTime/$id"),
//       body: {
//         'hours': hours,
//         'cost': cost,
//       },
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//     );
//     return response;
//   }
//
//   Future<ApiResponse> addBusinessHours(
//       {int day, String from, String to}) async {
//     var request = await post(
//       Uri.parse("${Constants.domain}addBusinessHours"),
//       body: {
//         'day': '$day',
//         'from': from,
//         'to': to,
//       },
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//     );
//     return response;
//   }
//
//   Future<ApiResponse> editBusinessHours({List<WorkTimes> days}) async {
//     Map body = {};
//     for (int i = 0; i < days.length; i++) {
//       body.putIfAbsent(
//           'days[$i]', () => '${days[i].day},${days[i].from},${days[i].to}');
//     }
//     var request = await post(
//       Uri.parse("${Constants.domain}editBusinessHours"),
//       body: body,
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(
//       output,
//     );
//     return response;
//   }
//
// //add or edit discount
//   Future<ApiResponse> addOrEditDiscount(
//       {String name,
//       int type,
//       int id,
//       String value,
//       String startDate,
//       String endDate,
//       String status,
//       bool isEdit}) async {
//     if (isEdit) {
//       var request = await post(
//         Uri.parse("${Constants.domain}editDiscountCode/$id"),
//         body: {
//           'name': name,
//           'type': type.toString(),
//           'value': value,
//           'start_date': startDate,
//           'end_date': endDate,
//           'status': status,
//         },
//         headers: Constants().headers,
//       );
//       var output = json.decode(request.body);
//       ApiResponse response = ApiResponse.fromJson(output);
//       return response;
//     }
//     var request = await post(
//       Uri.parse("${Constants.domain}addDiscountCode"),
//       body: {
//         'name': name,
//         'type': type.toString(),
//         'value': value,
//         'start_date': startDate,
//         'end_date': endDate,
//         'status': status,
//       },
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//     ApiResponse response = ApiResponse.fromJson(output);
//     return response;
//   }
//
//   //add or edit Package
//
//   Future<ApiResponse> addOrEditPackage(
//       {String nameEn,
//       String nameAr,
//       int type,
//       int id,
//       String price,
//       int ageCategoryId,
//       int gender,
//       String status,
//       String delayPolicy,
//       bool isEdit}) async {
//     if (isEdit) {
//       var request = await post(
//         Uri.parse("${Constants.domain}editPackage/$id"),
//         body: {
//           'name_en': nameEn,
//           'name_ar': nameAr,
//           'type': type.toString(),
//           'price': price,
//           'age_category_id': ageCategoryId.toString(),
//           'gender': gender.toString(),
//           'status': status,
//           'delay_policy': delayPolicy,
//         },
//         headers: Constants().headers,
//       );
//       var output = json.decode(request.body);
//       ApiResponse response = ApiResponse.fromJson(output);
//       return response;
//     }
//     var request = await post(
//       Uri.parse("${Constants.domain}addPackage"),
//       body: {
//         'name_en': nameEn,
//         'name_ar': nameAr,
//         'type': type.toString(),
//         'price': price,
//         'age_category_id': ageCategoryId.toString(),
//         'gender': gender.toString(),
//         'status': status,
//         'delay_policy': delayPolicy,
//       },
//       headers: Constants().headers,
//     );
//     var output = json.decode(request.body);
//
//     ApiResponse response = ApiResponse.fromJson(output);
//     return response;
//   }
// }
