
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttering/constants/routes.dart';
import 'package:fluttering/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/views/register_view.dart';
import 'package:fluttering/views/verify_email_view.dart';
import 'firebase_options.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute :(context) => const LoginView(),
        registerRoute :(context) => const RegisterView(),
        notesRoute :(context) => const NotesView(),
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
                ),
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
                    
                    
                    case ConnectionState.done:
                    
                  final user = FirebaseAuth.instance.currentUser;
                  
                  if(user!= null){
                    if(user.emailVerified){
                      return const NotesView();
                    }
                    else{
                      return const EmailVerifyView();
                    }    
                  }
                  else{
                    return const LoginView();
                  }
                  
                    
                    default: 
                    return const CircularProgressIndicator();
                  }
                },
      );
  }
}

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main UI'),
      
      
      actions: [
        PopupMenuButton<MenuAction>(
          onSelected: (value) async{
            switch (value){
              case MenuAction.logout:
                final shouldLogOut= await showLogOutDailog(context);
                
                if(shouldLogOut){
                  await FirebaseAuth.instance.signOut();
                  
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                     (route) => false,);
                  
                  
                }

                break;
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text('Log Out'),
              )
            ];
          },
        )
      ],

      ),
      body: const Text('Hello world'),
      
      );
  }
}

Future<bool> showLogOutDailog(BuildContext context){
  return showDialog<bool>(
    context: context, 
    builder:(context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure, you want to sign out!'),

          actions: [
            TextButton(onPressed:() {
              Navigator.of(context).pop(false);
            },
             child: const Text('Cancel')),

             TextButton(onPressed:() {
              Navigator.of(context).pop(true);
            },
             child: const Text('Sign Out')),
          ],
        );

       }, 
       
    ).then((value) => value ?? false);

}
