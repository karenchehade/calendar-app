import 'package:app/widget/logIn.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widget/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
      isLogin ? LogIn(onClickedSignUp: toggle) : SignUp(onClickedSigIn: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
