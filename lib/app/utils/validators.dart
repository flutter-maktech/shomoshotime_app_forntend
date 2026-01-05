class AppValidators {
  // Email Validator
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  // Password Validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one capital letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // Confirm Password Validator
  static String? confirmPassword(String? value, String password) {

    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Phone Validator (Bangladesh)
  // static String? phone(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Phone number is required';
  //   }
  //
  //   if (value.length != 11) {
  //     return 'Phone number must be 11 digits';
  //   }
  //
  //   if (!value.startsWith('01')) {
  //     return 'Enter a valid Bangladeshi phone number';
  //   }
  //
  //   return null;
  // }
}























  // final passwordController = TextEditingController();
  //
  // CustomTextField(
  // hintText: 'Password',
  // obscureText: true,
  // validator: AppValidators.password,
  // ),
  //
  // CustomTextField(
  // hintText: 'Confirm Password',
  // obscureText: true,
  // validator: (value) =>
  // AppValidators.confirmPassword(
  // value,
  // passwordController.text,
  // ),
  // ),
  //
