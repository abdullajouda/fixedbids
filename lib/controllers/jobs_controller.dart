import 'dart:convert';
import 'dart:io';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:async/async.dart';
import 'package:fixed_bids/models/responses/job_id_response.dart';
import 'package:fixed_bids/models/responses/nearby_jobs_response.dart';
import 'package:http/http.dart';

class JobsController {
  Future<JobDetailsResponse> addNewJob({
    String title,
    String details,
    String price,
    String zipCode,
    String urgencyType,
    String latitude,
    String longitude,
    String serviceId,
    File image,
    List<File> images,
  }) async {
    var request = MultipartRequest(
      "POST",
      Uri.parse(
        "${Constants.domain}addNewJob",
      ),
    );
    Map<String, String> body = {
      'title': title,
      'details': details,
      'price': price,
      'zip_code': zipCode,
      'urgency_type': urgencyType,
      'latitude': latitude ?? '',
      'longitude': longitude ?? '',
      'service_id': serviceId,
    };
    request.headers.addAll(Constants().headers);
    request.fields.addAll(body);
    if (image != null) {
      String fileName = image.path.split("/").last;
      var stream = new ByteStream(DelegatingStream(image.openRead()));
      var length = await image.length();
      var multipartFile =
          new MultipartFile('image', stream, length, filename: fileName);

      request.files.add(multipartFile);
    }
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        String fileName = images[i].path.split("/").last;
        var stream = new ByteStream(DelegatingStream(images[i].openRead()));
        var length = await images[i].length();
        var multipartFile =
            new MultipartFile('images[$i]', stream, length, filename: fileName);

        request.files.add(multipartFile);
      }
    }
    Response response = await Response.fromStream(await request.send());
    var output = json.decode(response.body);
    print(output);

    return JobDetailsResponse.fromJson(output);
  }

  Future<ApiResponse> editJob({
    int id,
    String title,
    String details,
    String price,
    String zipCode,
    String urgencyType,
    String latitude,
    String longitude,
    String serviceId,
    File image,
    List<File> images,
    List<int> deletedImages,
  }) async {
    var request = MultipartRequest(
      "POST",
      Uri.parse(
        "${Constants.domain}editJob/$id",
      ),
    );
    Map<String, String> body = {
      'title': title,
      'details': details,
      'price': price,
      'zip_code': zipCode,
      'urgency_type': urgencyType,
      'latitude': latitude ?? '',
      'longitude': longitude ?? '',
      'service_id': serviceId,
    };

    // if (deletedImages.isNotEmpty) {
    //   for (int i = 0; i < deletedImages.length; i++) {
    //     body.addAll({'deleted_images[$i]': '${deletedImages[i]}'});
    //   }
    // }

    request.headers.addAll(Constants().headers);
    request.fields.addAll(body);
    if (image != null) {
      String fileName = image.path.split("/").last;
      var stream = new ByteStream(DelegatingStream(image.openRead()));
      var length = await image.length();
      var multipartFile =
          new MultipartFile('image', stream, length, filename: fileName);

      request.files.add(multipartFile);
    }
    // if (images.isNotEmpty) {
    //   for (int i = 0; i < images.length; i++) {
    //     String fileName = images[i].path.split("/").last;
    //     var stream = new ByteStream(DelegatingStream(images[i].openRead()));
    //     var length = await images[i].length();
    //     var multipartFile =
    //         new MultipartFile('images[$i]', stream, length, filename: fileName);
    //
    //     request.files.add(multipartFile);
    //   }
    // }

    Response response = await Response.fromStream(await request.send());
    var output = json.decode(response.body);
    print(output);

    return ApiResponse.fromJson(output);
  }

  Future<ApiResponse> deleteJobById({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}deleteJobById/$id"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }

  Future<ApiResponse> addNewJobOffer({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}AddNewJobOffer/$id"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }

  Future<ApiResponse> completeJobOffer({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}makeMyJobOfferAsComplete/$id"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }

  Future<JobDetailsResponse> getJobId({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}getJobId/$id"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    JobDetailsResponse response = JobDetailsResponse.fromJson(output);
    return response;
  }

  Future<NearByJobsResponse> getJobsByUserId({int id, int isOpen = 1}) async {
    var request = await get(
      Uri.parse("${Constants.domain}getJobsByUserId/$id?is_open=$isOpen"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    NearByJobsResponse response = NearByJobsResponse.fromJson(output);
    return response;
  }

  Future<ApiResponse> jobOfferAction({int id, int status}) async {
    var request = await get(
      // status =>  2 = accept 3 = reject
      Uri.parse("${Constants.domain}jobOfferAction/$id?status=$status"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }
}
