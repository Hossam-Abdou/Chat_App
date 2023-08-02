import 'package:chat_app_test/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/custom_textfield.dart';
import '../bloc/system_cubit.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit,ChatState>(
      listener: (context,state) async {
        if (state is ChatRegisterSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ));
          const snackBar = SnackBar(
            content: Text('Registered Successfully'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is ChatRegisterError) {
          const snackBar = SnackBar(
            content: Text('Error'),
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
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:Image(image: AssetImage('images/m2.png'),width: 250),
                  ),

                  CustomTextField(label: 'Email',
                    controller: cubit.emailController,
                  ),

                  CustomTextField(label: 'Password',
                    controller: cubit.passwordController,
                  ),

                  Material(
                    color: Color(0xff2FC2FF),
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: ()
                      {
                        cubit.Register();
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 200,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text('Register',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have An Account?',style: TextStyle(color: Colors.white),),
                      TextButton(
                          onPressed: ()
                          {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                            cubit.emailController.clear();
                            cubit.passwordController.clear();
                          },
                          child: const Text('Login Now',style: TextStyle(color: Colors.white),)
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
       },
    );
  }
}
