import 'dart:developer';

import 'package:contacts_app_api_flutter/model/contact.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://68b4361145c90167876fcc9b.mockapi.io",
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),

      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log("Sending request ${options.method} ${options.path}");
          log("Sending data ${options.data}");
          return handler.next(options);
        },

        onResponse: (response, handler) {
          log("Recieved ressponse with statuscode ${response.statusCode}");
          log("Recieved data ${response.data}");
          return handler.next(response);
        },

        onError: (DioException e, handler) {
          log("Error occurred ${e.type} ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<List<Contact>> fetchcontacts() async {
    try {
      log("Fetching data from the api");

      final response = await _dio.get(
        '/contacts',
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        log("Api call successfull");
        List<dynamic> data = response.data;
        List<Contact> contacts = data.map((e) => Contact.fromJson(e)).toList();
        return contacts;
      } else {
        log("Error ${response.statusCode}");
        throw Exception("Error ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Network error ${e.message}");
    } catch (e) {
      log("Unexpected error $e");
      throw Exception("Unexpected error $e");
    }

    throw Exception("Unexpected flow - this shouldn't be happening");
  }

  Future<String> createContact(Contact newContact) async {
    try {
      log("Adding data to api");

      final response = await _dio.post(
        '/contacts',
        data: newContact.toJson(),
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        log("Api call successfull ${response.data} ${response.statusCode}");
        return "Success";
      } else {
        log("Error ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Network error $e");
    } catch (e) {
      throw Exception("Unexpected error $e");
    }

    throw Exception("Unexpected flow - this shouldn't be happening");
  }

  Future<String> updateContact(Contact contact) async {
    try {
      log("Update call to api started");

      final response = await _dio.put(
        '/contacts/${contact.id}',
        data: contact.toJson(),
        options: Options(
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("updation successful");
        return "success";
      } else {
        log("updation unsuccessful with error ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Error $e");
      throw Exception("Error $e");
    } catch (e) {
      throw Exception("Unexpected error $e");
    }
    throw Exception("Unexpected error");
  }

  Future<String> deleteContact(Contact contact) async {
    log("Connecting to api for deletion");

    try {
      final response = await _dio.delete(
        '/contacts/${contact.id}',
        options: Options(
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("deletion successfull");
        return "success";
      } else {
        log("deletion unnsuccessfull with error ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("error $e");
      throw Exception("Unexpected error $e");
    } catch (e) {
      log("Unexpected error $e");
      throw Exception("Unexpected error $e");
    }

    throw Exception("Error: it should not occur");
  }
}
