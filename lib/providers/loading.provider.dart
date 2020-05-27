import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
  bool isLoading = false;
  bool showLoading = false;

  void showLoader() async{
    this.isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 200));
    this.showLoading = true;
    notifyListeners();
  }

  void hideLoader() async{
    this.showLoading = false;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 200));
    this.isLoading = false;
    notifyListeners();
  }
}