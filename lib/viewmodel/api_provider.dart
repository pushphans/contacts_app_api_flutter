// ignore_for_file: prefer_final_fields

import 'package:contacts_app_api_flutter/model/contact.dart';
import 'package:contacts_app_api_flutter/repository/api_service.dart';
import 'package:flutter/material.dart';

class ApiProvider extends ChangeNotifier {
  final apiService = ApiService();

  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  String? _error = "";
  String? get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _postingResult = "";
  String get postingResult => _postingResult;

  String _updationResult = "";
  String get updationResult => _updationResult;

  String _deletionResult = "";
  String get deletionResult => _deletionResult;

  Future<void> fetchContacts() async {
    _isLoading = true;

    try {
      _contacts = await apiService.fetchcontacts();
      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> createContact(Contact newContact) async {
    _isLoading = true;
    try {
      _postingResult = await apiService.createContact(newContact);
      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateContact(Contact contact) async {
    _isLoading = true;
    try {
      _updationResult = await apiService.updateContact(contact);
      await fetchContacts();
      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteContact(Contact contact) async {
    try {
      _deletionResult = await apiService.deleteContact(contact);
      await fetchContacts();
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
