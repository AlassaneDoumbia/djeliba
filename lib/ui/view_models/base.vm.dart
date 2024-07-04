
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isLoading => _isLoading;

  setIsLoading([bool busy = true]) {
    _isLoading = busy;
    notifyListeners();
  }

  void displaySnackBar(String message, BuildContext buildContext) {

    final scaffoldMessenger = ScaffoldMessenger.of(
      // scaffoldKey.currentContext!,
        buildContext,
    );

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.airline_stops, color: Colors.white),
            const SizedBox(width: 10),
            Flexible(child: Text(message)),
          ],
        ),
      ),
    );
  }
}