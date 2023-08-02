import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/system_cubit.dart';
import 'login_screen.dart';

class ChatScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final scroll=ScrollController();
  TextEditingController messageController =TextEditingController();

    return BlocConsumer<ChatCubit,ChatState>(
      listener:(context,state){},
      builder: (context,state){
        var cubit=ChatCubit.get(context);
        return StreamBuilder(
            stream:cubit.messagesStream! ,
            builder:(context,snapshot){
              if(snapshot.hasData)
              {
                QuerySnapshot values =snapshot.data as QuerySnapshot ;
                return Scaffold(
                  backgroundColor: Color(0xff101649),
                  appBar: AppBar(
                    backgroundColor: Colors.blueGrey,
                    elevation: 0,
                    actions: [IconButton(onPressed: ()
                    {
                      cubit.emailController.clear();
                      cubit.passwordController.clear();
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                    },
                        icon: Icon(Icons.exit_to_app))],
                  ),
                  body: Column(
                    children: [
                      cubit.messagesStream==null ?
                      const   CircularProgressIndicator()
                          :
                      Expanded(
                        child: ListView.builder(
                          controller: scroll,
                            physics:  const BouncingScrollPhysics(),
                            itemCount: values.docs.length ,
                            itemBuilder:(context,index)
                            {
                              bool isMe=false;
                              String text=values.docs[index]['text'];
                              String messaEmail=values.docs[index]['sender'];
                              if(FirebaseAuth.instance.currentUser!.email==messaEmail)
                              {
                                isMe=true;
                              }
                              return Align(
                                alignment:isMe? Alignment.centerRight:Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                      decoration:isMe?
                                      const BoxDecoration(
                                        borderRadius:  BorderRadius.only(
                                          topLeft:   Radius.circular(20),
                                          topRight:  Radius.circular(20),
                                          bottomLeft:Radius.circular(20),
                                        ),
                                        color:Color(0xff2399FF),
                                      )
                                          :
                                     const BoxDecoration(
                                          borderRadius:  BorderRadius.only(
                                            topLeft:   Radius.circular(20),
                                            topRight:  Radius.circular(20),
                                            bottomRight:Radius.circular(20),
                                          ),
                                          color: Color(0xff616471)
                                      ),
                                      child: Column(
                                        children: [
                                          Text(text,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            }),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            controller: messageController,
                            decoration:  InputDecoration(
                              hintText: 'Type Here ',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  DateTime now =DateTime.now();
                                  cubit.sendMessage(messageController.text,now);
                                  messageController.clear();

                                  scroll.animateTo(
                                    scroll.position.maxScrollExtent,
                                    curve: Curves.bounceInOut,
                                    duration: const Duration(milliseconds: 500),
                                  );
                                }, icon: Icon(Icons.send),
                              ),

                            )
                        ),
                      )
                    ],
                  ),
                );

              }
              else{
                return Text('Data is empty',style: TextStyle(color: Colors.black,fontSize: 40),);
              }


            }
        );


      }
    );
  }
}
