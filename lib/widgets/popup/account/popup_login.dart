import 'package:bbb/Components/button.dart';
import 'package:bbb/Components/input.dart';
import 'package:bbb/config/mutation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PopupLogin extends StatefulWidget {
  const PopupLogin({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<PopupLogin> createState() => _PopupLoginState();
}

class _PopupLoginState extends State<PopupLogin> {
  final bool _obscureText = true;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GroupFiledInput(obscureText: false, controller: widget.emailController, label: "Email"),
        GroupFiledInput(obscureText: _obscureText, controller: widget.passwordController, label: "Password"),
        Mutation(
          options: MutationOptions(
            document: gql(CreateCustomer),
            update: (cache, result) {
              
            },
            onCompleted: (data) {
              print(data);
            },
          ), 
          builder: (runMutation, result) {
            return InkWell(
              onTap: () {
              },
              child: ButtonSecondary(text: 'Đăng nhập'),
            );
          },
        ),

      ],
    );
  }
}







