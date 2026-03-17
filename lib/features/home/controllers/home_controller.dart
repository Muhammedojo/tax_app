import 'package:flutter/material.dart';

import '../contract/home_contract.dart';
import '../views/home_view.dart';




class HomeScreen extends StatefulWidget {
  static const route = 'Home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin 
    implements HomeControllerContract{
  late final HomeViewContract view;



  @override
  void initState() {
    super.initState();

    view = HomeView(controller: this);



  }




  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
  

}
