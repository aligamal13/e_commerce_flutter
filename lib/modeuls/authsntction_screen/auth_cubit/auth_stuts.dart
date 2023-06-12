abstract class AuthStates{

}


class AuthInitialState extends AuthStates{}


class RegisterLoadingState extends AuthStates{

}
class RegisterSuccessState extends AuthStates{}
class RegisterFailedState extends AuthStates{

  String message;

  RegisterFailedState({required this.message});
}



class LoginLoadingState extends AuthStates{

}
class LoginSuccessState extends AuthStates{}
class LoginFailedState extends AuthStates{

  String message;

  LoginFailedState({required this.message});
}