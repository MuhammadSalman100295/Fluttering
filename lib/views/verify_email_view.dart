import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerifyView extends StatefulWidget {
  const EmailVerifyView({Key? key}) : super(key: key);

  @override
  State<EmailVerifyView> createState() => _EmailVerifyViewState();
}

class _EmailVerifyViewState extends State<EmailVerifyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Email Verification'),),

      body: Column(
        children: [
          const Text('Please verify your Email first'),
    
          TextButton(onPressed: ()async{
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          }, 
          
          
          child:const  Text('EMAIL VERIFICATION'),
          )
        ],
      ),
    );
    
  }
}