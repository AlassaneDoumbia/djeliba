

import 'package:djeliba/locator.dart';
import 'package:djeliba/models/auth_data.model.dart';
import 'package:djeliba/services/auth.service.dart';
import 'package:djeliba/services/secure_storage.service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/home_layout.dart';

class HomeScreen extends StatefulWidget {
  // final String uid;
  // final bool? change;
  // final String? content;

  const HomeScreen({Key? key});
  // const HomeScreen({Key? key,required this.uid, this.change, this.content}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: HomeLayout(),
        )
    );
  }
}