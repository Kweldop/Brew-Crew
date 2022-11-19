import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/myuser.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  MyUser? _userFromFireBaseUser(User user){
    return user!=null ? MyUser(uid: user.uid): null;
  }
  Stream<MyUser?>get user{
    return _auth.authStateChanges().map((User? user) => _userFromFireBaseUser(user!));
  }
  

  Future signInAnon() async{
    try{
     UserCredential result = await _auth.signInAnonymously();
    User? username= result.user;
    return _userFromFireBaseUser(username!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future register (String email,String password)async{
    try{
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? username=result.user;
      await DataBaseService(uid: username?.uid).updateUserData('New Crew Member', '0', 100);
      return _userFromFireBaseUser(username!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signin(String email, String password)async{
    try{
      UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? username=result.user;
      return _userFromFireBaseUser(username!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }




  Future signout()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
    }
}