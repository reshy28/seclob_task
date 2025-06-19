import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seclobtechnologies_task/constants/api_urls.dart';
import 'package:seclobtechnologies_task/profile_screen/model/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilescreenController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<UserData> profileDatas = [];
  Future<void> fetchProfileDetails() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('accessToken');

      if (storedToken == null) {
        _errorMessage = 'No access token found';
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse(AppUrls.userDetails),
        headers: {
          'Authorization': 'Bearer $storedToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final UserDetailsModel datas = UserDetailsModel.fromJson(responseData);
        profileDatas = [datas.data!];
      } else {
        _errorMessage = 'Failed to fetch balance: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = 'Error fetching balance: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
