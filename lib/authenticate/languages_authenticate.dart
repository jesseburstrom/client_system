part of '../main.dart';

class LanguagesLogin extends Languages {
  final _required = {"English": "* Required"};
  final _passwordAtLeast = {"English": "Password should be atleast"};
  final _characters = {"English": "characters"};
  final _passwordNotGreater = {
    "English": "Password should not be greater than"
  };
  final _login = {"English": "Login"};
  final _signup = {"English": "Signup"};
  final _email = {"English": "Email"};
  final _enterValidEmail = {"English": "Enter valid email id as abc@gmail.com"};
  final _password = {"English": "Password"};
  final _enterSecurePassword = {"English": "Enter secure password"};
  final _forgotPassword = {"English": "Forgot Password"};
  final _newUser = {"English": "New User? Create Account"};

  String get required_ => getText(_required);

  String get passwordAtLeast_ => getText(_passwordAtLeast);

  String get characters_ => getText(_characters);

  String get passwordNotGreater_ => getText(_passwordNotGreater);

  String get login_ => getText(_login);

  String get signup_ => getText(_signup);

  String get email_ => getText(_email);

  String get enterValidEmail_ => getText(_enterValidEmail);

  String get password_ => getText(_password);

  String get enterSecurePassword_ => getText(_enterSecurePassword);

  String get forgotPassword_ => getText(_forgotPassword);

  String get newUser_ => getText(_newUser);

  languagesSetup() {
    _required["Swedish"] = "* Nödvändig";
    _passwordAtLeast["Swedish"] = "Lösenord skall vara minst";
    _characters["Swedish"] = "tecken";
    _passwordNotGreater["Swedish"] = "Lösenord skall inte vara större än";
    _login["Swedish"] = "Logga in";
    _signup["Swedish"] = "Registrera dig";
    _email["Swedish"] = "Epost";
    _enterValidEmail["Swedish"] =
        "Ange en giltig e-postadress som abc@gmail.com";
    _password["Swedish"] = "Lösenord";
    _enterSecurePassword["Swedish"] = "Ange ett säkert lösenord";
    _forgotPassword["Swedish"] = "Glömt lösenord";
    _newUser["Swedish"] = "Ny användare";
  }
}
