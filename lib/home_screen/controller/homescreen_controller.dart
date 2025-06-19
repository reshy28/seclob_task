import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:seclobtechnologies_task/constants/api_urls.dart';
import 'package:seclobtechnologies_task/home_screen/model/blance_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomescreenController extends ChangeNotifier {
  List<Balance> homeScreenDatas = [];

  bool _isLoading = false;
  String? _errorMessage;
  String? userName;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  double get balanceAmount =>
      homeScreenDatas.isNotEmpty ? homeScreenDatas.first.balance : 0.0;

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('name');
    notifyListeners();
  }

  Future<void> fetchBalance() async {
    // const String api =
    //     "https://seclobbackendapi.seclob.com/v1/cPartner/wallet/balance";

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
        Uri.parse(AppUrls.walletBalance),
        headers: {
          'Authorization': 'Bearer $storedToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final BalanceModel balanceModel = BalanceModel.fromJson(responseData);

        homeScreenDatas = balanceModel.balances;
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
