import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpSubmitted extends AuthEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final String email;
  final String phone;
  final String countryCode;
  final String dialCode;

  SignUpSubmitted(this.firstName,this.lastName,this.username,this.password,this.email, this.phone,this.countryCode,this.dialCode);

  @override
  List<Object> get props => [firstName,lastName,username,password,email, phone,countryCode,dialCode];
}
class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  LoginSubmitted(this.email,this.password);

  @override
  List<Object> get props => [email,password];
}
class ForgotSubmitted extends AuthEvent {
  final String email;

  ForgotSubmitted(this.email);

  @override
  List<Object> get props => [email];
}
class SocialLoginSubmitted extends AuthEvent {
  final String email;
  final String name;
  final String providerId;

  SocialLoginSubmitted(this.email,this.name,this.providerId);

  @override
  List<Object> get props => [email,name,providerId];
}
