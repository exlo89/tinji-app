import 'package:flutter/material.dart';
import 'package:tinji/screens/home.dart';
import 'package:tinji/screens/login.dart';
import 'package:tinji/screens/matches.dart';
import 'package:tinji/screens/profile.dart';
import 'package:tinji/screens/register.dart';
import 'package:tinji/screens/register_stepper.dart';

final routes = <String, WidgetBuilder>{
  Home.route: (context) => Home(),
  Login.route: (context) => Login(),
  Register.route: (context) => Register(),
  Profile.route: (context) => Profile(),
  Matches.route: (context) => Matches(),
  RegisterStepper.route: (context) => RegisterStepper(),
};
