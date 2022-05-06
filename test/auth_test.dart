import 'package:practise/services/auth/auth_exceptions.dart';
import 'package:practise/services/auth/auth_provider.dart';
import 'package:practise/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main(){
  group('Mock Authentication',(){
    final provider=MockAUthProvider();
    test('Should not be initialized to begin with',(){
       expect(provider.isInitialized,false);
    });
  test('Cannot Logout if not initialized',(){
    expect(provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>(),),
    );
  });
  test('Should be able to initialized',()async{
    await provider.initialize();
    expect(provider.isInitialized,true);
  });
  test('User should be null',(){
    expect(provider.currentUser,null);
  });
  test('Should be able to initialize in less than 2 seconds',()async{
await provider.initialize();
expect(provider.isInitialized,true);
  }, timeout: const Timeout(Duration(seconds:2)),
  );
    test ('Create user should delegate to LogIn function',()async{
      final badEmailUser= provider.createUser(
          email: 'yolo@gmail.com',
          password: 'any password');
expect(badEmailUser,throwsA(const TypeMatcher<UserNotFoundAuthException>()));
final badPasswordUser=provider.createUser(
    email: 'someone@bar.com', password: 'yolo',
);
expect (badPasswordUser,throwsA(const TypeMatcher<WrongPasswordAuthException>()));
final user=await provider.createUser(
    email: 'yo',
    password: 'lo');
expect(provider.currentUser,user);
expect(user.isEmailVerified,false);
    });
    test('Logged user should be able to get verified',(){
      provider.sendEmailVerification();
      final user=provider.currentUser;
      expect(user,isNotNull);
      expect(user!.isEmailVerified,true);
    });
    test('Should be able to logout and login again',()async{
      await provider.logOut();
      await provider.logIn(
          email: 'email',
          password: 'password');
      final user=provider.currentUser;
      expect(user,isNotNull);

    });
  });
  

}
class NotInitializedException implements Exception{}

class MockAUthProvider implements AuthProvider{
  AuthUser? _user ;//private member
  var _isInitialized=false;
  bool get isInitialized=> _isInitialized;
  @override
  Future<AuthUser> createUser({required String email, required String password,
  })async {
    if(!isInitialized) throw NotInitializedException();
await Future.delayed(const Duration(seconds:1));
return logIn(
    email: email,
    password: password);

  }

  @override
  //  implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize()async {
    await Future.delayed(const Duration(seconds:1));
    _isInitialized= true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if(!isInitialized) throw NotInitializedException();
    if(email=='yolo@gmail.com')throw UserNotFoundAuthException();
    if(password=='yolo')throw WrongPasswordAuthException();
    const user=AuthUser(isEmailVerified:false, email: 'yolo@gmail.com');
    _user=user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async{
    if(!isInitialized) throw NotInitializedException();
    if(_user==null)throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds:1));
    _user=null;
  }

  @override
  Future<void> sendEmailVerification()async {
    if(!isInitialized) throw NotInitializedException();
    final user=_user;
    if(user==null)throw UserNotFoundAuthException();
    const newUser=AuthUser(isEmailVerified: true, email: 'yolo@gmail.com');
    _user=newUser;
  }
  
}