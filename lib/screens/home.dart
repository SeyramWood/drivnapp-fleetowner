// import 'package:flutter/material.dart';

// import '../components/home_card.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//      home: Scaffold(
//       body: SafeArea(child: MyCard(),),
//      ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(HomePage());
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('My Cars'),
//         ),
//         body: Container(
//           child: Text(
//             'Welcome to Flutter!',
//             style: TextStyle(fontSize: 24.0),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

// import '../components/home_card.dart';
import '../components/new_card.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
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
                // child: Text(
                //   'Tab 1 Content',
                //   style: TextStyle(fontSize: 24.0),
                // ),
                child: MyCard2(),

              ),
              Center(
                // child: Text(
                //   'Tab 2 Content',
                //   style: TextStyle(fontSize: 24.0),
                // ),
                child: MyCard2(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
