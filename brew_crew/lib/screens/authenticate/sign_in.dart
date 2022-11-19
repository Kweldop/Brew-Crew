import 'package:brew_crew/screens/loading.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);
  final Function toggleView;
  SignIn({required this.toggleView});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService auth =AuthService();
  final _formKey=GlobalKey<FormState>();

  String email='';
  String password='';
  String error='';
  bool loading= false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      appBar: AppBar(
        title: Text('Sign In to Brew Crew'),
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
              validator: (val)=>val!.isEmpty?'Enter the Email':null,
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
              validator: (val)=>val!.length<6 ? 'Enter 6+ characters': null,
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
            Column(
              children: [
                Row(
                 children: [
                  Expanded(
                    child: ElevatedButton(onPressed: ()async{
                     if(_formKey.currentState!.validate()){
                         //print('$email\n$password');
                       setState(() => loading=true);
                     dynamic result= await auth.signin(email,password);
                     if(result==null){
                     setState(()=>error='Incorrect email or password.');
                     loading=false;
                  }
                }
              },
                     child: Text('Sign In'),
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

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text('Don\'t have an account?',
                style: TextStyle(
                  fontSize: 15,
                ),
                ),
                TextButton(onPressed: (){
                  widget.toggleView();
                },
                    child: Text('Register',
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
      ),
    );
  }
}
