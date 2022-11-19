import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

import '../loading.dart';
class Register extends StatefulWidget {
  final Function toggleView;

  Register( {required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService auth =AuthService();
  final _formKey=GlobalKey<FormState>();
  String email=' ';
  String password=' ';
  String error='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
        appBar: AppBar(
          title: Text('Sign up to Brew Crew'),
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 40),
          child:Form(
            key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('EMAIL ADDRESS'),
                  SizedBox(height: 10,),
                  TextFormField(
                    validator: (val)=> val!.isEmpty ?'Enter the Email': null,
                    onChanged: (val){setState(() {
                      email=val;
                    });},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                        hintText: 'name@email.com'
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('PASSWORD'),
                  SizedBox(height: 10,),
                  TextFormField(
                    validator: (val)=> val!.length <6 ? 'Enter the password 6+ characters': null,
                    obscureText: true,
                    onChanged: (val){setState(() {
                      password=val;
                    });},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                        hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(onPressed: ()async{
                                if(_formKey.currentState!.validate()){
                                  //print('$email\n$password');
                                  setState(() => loading=true);
                                dynamic result= await auth.register(email,password);
                                if(result==null){
                                  setState(() {
                                    error='Please supply a valid email';
                                    loading=false;
                                   }
                                  );
                                 }
                                }
                              },
                                child: Text('Sign up'),
                                style: ButtonStyle(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Have an account?',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextButton(onPressed: (){
                        widget.toggleView();
                      },
                        child: Text('Sign In',
                          style: TextStyle(
                            color: Colors.brown[400],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
            ),
          ),
        )

    );
  }
}
