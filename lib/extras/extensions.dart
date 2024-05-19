import 'package:flutter/material.dart';

extension ContextFunctionalities on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get topPadding => MediaQuery.of(this).padding.top;

  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  double get leftPadding => MediaQuery.of(this).padding.left;

  double get rightPadding => MediaQuery.of(this).padding.right;

  Future<dynamic> push({required Widget child}) async {
    return await Navigator.of(this)
        .push(MaterialPageRoute(builder: (ctx) => child));
  }

  Future<dynamic> pushReplacement({required Widget child}) async {
    return await Navigator.of(this)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => child));
  }

  Future<dynamic> pushAndRemoveUntil({required Widget child}) async {
    return await Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => child),
          (route) => false,
    );
  }

  void pop({dynamic data}) {
    Navigator.of(this).pop(data);
  }

  Future<dynamic> showAlertDialog({required Widget child}) async {
    return await showDialog(context: this, builder: (_) => child);
  }
}

extension Validation on String {
  bool get isValidURl => RegExp(
      r"(https?://|http://|www.)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
      caseSensitive: false)
      .hasMatch(this);

  bool get isValidEmail => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  bool get isValidPassword =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(this);

  bool get isValidPassword2 => RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>~\[\]]).{8,}$')
      .hasMatch(this);

  bool get hasSpecialCharacters =>
      contains(RegExp(r'[!@#$%^&*(),.?":{}|<>~\[\]]'));

  bool get hasNumber => contains(RegExp('[0-9]'));

  bool get hasLowerCase => contains(RegExp("(?:[^a-z]*[a-z]){1}"));

  bool get hasUpperCase => contains(RegExp("(?:[^A-Z]*[A-Z]){1}"));
}

extension MultiSort on List {
  multiSort(List<bool> criteria, dynamic preference) {
    if (preference.length == 0 || criteria.isEmpty || length == 0) {
      return this;
    }
    if (preference.length != criteria.length) {
      // print('Criteria length is not equal to preferrence');
      return this;
    }

    int compare(int i, dynamic a, dynamic b) {
      if (a.get(preference[i]) == b.get(preference[i])) {
        return 0;
      } else if (a.get(preference[i]) > b.get(preference[i])) {
        return criteria[i] ? 1 : -1;
      } else {
        return criteria[i] ? -1 : 1;
      }
    }

    int sortAll(a, b) {
      int i = 0;
      int result = 0;
      while (i < preference.length) {
        result = compare(i, a, b);
        if (result != 0) break;
        i++;
      }
      return result;
    }

    sort((a, b) => sortAll(a, b));
  }
}

extension IterableExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}