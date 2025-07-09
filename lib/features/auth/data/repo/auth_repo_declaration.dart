
abstract class AuthRepoDeclaration {
Future<void> userSignUp(String email,String password);
Future<void> userLogIn(String email,String password);
Future<void> resetPassowrd(String email);

  
}