import 'package:brew_crew/models/myuser.dart';
import 'package:brew_crew/screens/loading.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey=GlobalKey<FormState>();
  final List<String> sugar=['0','1','2','3','4 ','5'];

  String? _currentName;
   String? _currentSugar;
   int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser>(context);
    return StreamBuilder<Object>(
      stream: DataBaseService(uid: user.uid).userData,
    builder: (context, snapshot) {
      if(snapshot.hasData) {
        UserData userData=snapshot.data as  UserData;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Update your Brew settings',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  initialValue: _currentName,
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                  decoration: InputDecoration(
                    hintText: 'Name',
                    filled: true,
                  ),
                ),
                SizedBox(height: 15,),
                DropdownButtonFormField(
                  value: _currentSugar ?? userData.sugar,
                  items: sugar.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugar = val ),
                ),
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentStrength = val.round()),
                ),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: ()async {
                  if(_formKey.currentState!.validate()){
                    await DataBaseService(uid: user.uid).updateUserData(_currentName?? userData.name,
                        _currentSugar ?? userData.sugar,
                        _currentStrength ?? userData.strength,
                    );
                    Navigator.pop(context);
                  }
                },
                    child: Text('Update')
                ),
              ],
            ),
          );
      } else{
        return Loading();
      }
    }
    );
  }
}
