// ignore_for_file: unnecessary_null_comparison, avoid_print, void_checks

import 'package:bbb/Components/button.dart';
import 'package:bbb/Components/input.dart';
import 'package:bbb/Components/message.dart';
import 'package:bbb/config/mutation.dart';
import 'package:bbb/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PopupRegister extends StatefulWidget {
  const PopupRegister({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  State<PopupRegister> createState() => _PopupRegisterState();
}

class _PopupRegisterState extends State<PopupRegister> {
  final bool _obscureText = true;
  bool isSubmitting = false;
  dynamic errorMessage = "";
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GroupFiledInput(obscureText: false, controller: widget.firstNameController, label: "First name"),
        GroupFiledInput(obscureText: false, controller: widget.lastNameController, label: "Last name"),
        GroupFiledInput(obscureText: false, controller: widget.emailController, label: "Email"),
        GroupFiledInput(obscureText: _obscureText, controller: widget.passwordController, label: "Password"),
        ErrorMessage(errorMessage: errorMessage, marginBottom: errorMessage == "" ? 0 : 20),
        Mutation(
          options: MutationOptions(
            document: gql(CreateCustomer),
            update: (cache, result) {
              return cache;
            },
            onCompleted: (data) {
              setState(() {
                isSubmitting = false;
              });
              
              if(data.runtimeType != Null){
                Navigator.pushNamed(context, HomePage.routeName);
              }else{
              }
            },
            onError: (error) {
              setState(() {
                errorMessage = error?.graphqlErrors[0].message;
              });
            },
          ), 
          builder: (runMutation, result) {
            return InkWell(
              onTap: () {
                runMutation({
                  'firstname' : widget.firstNameController.text,
                  'lastname' : widget.lastNameController.text,
                  'email' : widget.emailController.text,
                  'password' : widget.passwordController.text
                });
                setState(() {
                  isSubmitting = true;
                });
              },
              child: ButtonSecondary(text: 'Đăng ký', isLoading: isSubmitting)
            );
          },
        ),
      ],
    );
  }
}







