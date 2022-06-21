import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController addressController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
}
