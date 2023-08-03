import 'package:flutter/material.dart';
import '../components/new_card.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: Text('HomePage'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: MyCard2(),
              ),
              Center(
                child: MyCard2(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
