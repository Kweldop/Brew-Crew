import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/setting_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void showSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child:SettingForm(),
        );
      });
    }
    return StreamProvider<List<Brew>?>.value(
      initialData: null,
      value: DataBaseService(uid: '').brew,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Brew Crew'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(onPressed: ()=> showSettingPanel(),
                icon:Icon(Icons.settings),
                  color: Colors.white,
                ),
           SizedBox(width: 10,),
           IconButton(onPressed: ()async{
              await auth.signout();
            },
                icon:Icon(Icons.logout),
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: BrewList()),
      ),
    );
  }
  }

