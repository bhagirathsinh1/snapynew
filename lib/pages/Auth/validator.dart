class Validators {
  static late String confrompassword1;
  static String? nameValidator(String? name) {
    if (name!.isEmpty) {
      return ' Please Enter Name';
    }
  }

  static String? emailValidates(String? email) {
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email!)) {
      return 'Please enter vaild Email ';
    }
  }

  static String? passwordValidator(String? password) {
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password!)) {
      confrompassword1 = password;
      return 'Please enter Strong Password ';
    }
  }

 static String? confirmPasswordValidates(String? confromPassword) {
    if (confromPassword != confrompassword1) {
      return 'Confrom password should be match with above.';
    }
  }
}
