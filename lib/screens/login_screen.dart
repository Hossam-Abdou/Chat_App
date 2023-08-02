
import 'package:chat_app_test/screens/chat_screen.dart';
import 'package:chat_app_test/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/custom_textfield.dart';
import '../bloc/system_cubit.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer <ChatCubit,ChatState>(
      listener: (context,state) async{
     if(state is ChatLoginSuccess)
     {

       Navigator.pushReplacement(context, MaterialPageRoute(
         builder: (context) => ChatScreen(),
       ));
       const snackBar = SnackBar(
         content: Text('Login Successfully'),
         backgroundColor: Colors.green,
       );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }
     if(state is ChatLoginError)
     {
       SnackBar snackBar = SnackBar(
         content: Text(state.error),
         backgroundColor: Colors.red,
       );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }
   },
      builder: (context,state)
      {
        var cubit=ChatCubit.get(context);
        return Scaffold(
            backgroundColor: Color(0xff101649),
            body:SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(20),
                        child:Image(image: AssetImage('images/s.png'),width: 170),
                    ),
                    CustomTextField(label: 'Email',
                      controller: cubit.emailController,
                    ),
                    CustomTextField(label: 'Password',
                      isPassword: true,
                      controller: cubit.passwordController,
                    ),
                    Material(
                      color: Color(0xff2FC2FF),
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: ()
                        {
                          cubit.Login();
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 200,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text('Login',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t Have An Account',style: TextStyle(color: Colors.white),),
                        TextButton(
                            onPressed: ()
                            {
                              cubit.emailController.clear();
                              cubit.passwordController.clear();
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ));
                            },
                            child: const Text('Register Now',style: TextStyle(color: Colors.white),)
                        )
                      ],
                    )




                  ],),
              ),
            )
        );
      },
    );
  }
}
