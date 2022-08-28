import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

@override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(

     appBar: AppBar(title: const Text('Login'),), 

     body: Column(
            children: [
              TextField(
                controller: _email,
                autocorrect: false,
                enableSuggestions: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Enter your email here'),
                
              ),
              TextField(
                controller: _password,
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Enter your password here'),
                
              ),
        
              TextButton(
                onPressed: () async {
                  
        
                final email=_email.text;
                final password=_password.text;
        
                try{
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email, password: password);
                  
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/notes/',
                     (route) => false,);
                }
                on FirebaseAuthException catch(e){
                  if(e.code=='user-not-found'){
                    devtools.log('Email not registered');
                  }
                  else if (e.code=='wrong-password'){
                    devtools.log('Wrong password');
                  }
                  else if (e.code=='invalid-email'){
                    devtools.log('Invalid  email');
                  }
                }
                  
                },
              child: const Text('LOGIN'),
              ),
   
              TextButton(
                onPressed:(){
                  Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);
                } , 
              
              child: const Text('Note registered? Register Here'))
            ],
          ),
   );
  }
  }  