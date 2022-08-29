import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/constants/routes.dart';
import '../utilities/show_error_dailog.dart';


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
                    notesRoute,
                     (route) => false,);
                }
                on FirebaseAuthException catch(e){
                  if(e.code=='user-not-found'){
                    showErrorDdailog(context, 'Email not registered');
                  }
                  else if (e.code=='wrong-password'){
                    showErrorDdailog(context, 'Wrong Password');
                  }
                  else if (e.code=='invalid-email'){
                    showErrorDdailog(context, 'Invalid Email Address Format');
                  }
                  else{
                    showErrorDdailog(context, 'Error: ${e.code}');
                  }
                }
                  catch(e){
                    showErrorDdailog(context, e.toString());
                  }
                },
              child: const Text('LOGIN'),
              ),
   
              TextButton(
                onPressed:(){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,);
                } , 
              
              child: const Text('Note registered? Register Here'))
            ],
          ),
      );
    }
  }  

  