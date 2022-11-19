import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{
  final String? uid;
  DataBaseService({required this.uid});

  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brew');

  Future updateUserData(String name,String sugar,int strength) async{
    return await brewCollection.doc(uid).set({
      'name': name,
      'sugar': sugar,
      'strength': strength,
    });

  }

  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(name: doc.get('name')?? '',
          sugar: doc.get('sugar')??'0',
          strength:doc.get('strength')?? 0 );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        sugar: snapshot.get('sugar'),
        strength: snapshot.get('strength'));
  }

  Stream <List<Brew>> get brew{
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }


}