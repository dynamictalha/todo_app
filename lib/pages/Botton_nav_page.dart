
import 'package:flutter/material.dart';

import 'package:mytodoapp/pages/Add_page.dart';
import 'package:mytodoapp/pages/Histry_page.dart';
import 'package:mytodoapp/pages/Home_page.dart';
import 'package:mytodoapp/pages/Profile_page.dart';
import 'package:mytodoapp/pages/Search_page.dart';

class Botton_nav extends StatefulWidget {
  const Botton_nav({super.key});

  @override
  State<Botton_nav> createState() => _Botton_navState(); // private class return _is used for private 
}

class _Botton_navState extends State<Botton_nav> {
  var pages = [Home_page(),Search_page(),Add_page(),Histry_page(),Profile_page()]; 
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Color(0xFF0C36CC), 
        title: Center(
         child:  Text("New Task",
         style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
         ),
         ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30) ,
          )
        ),
         elevation: 10,
        shadowColor: Colors.black,
      ),
      body: pages[_selectedPage],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            )
          ]
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HOME"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "SEARCH"
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: ""
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "HISTORY"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "PROFILE"
            ),
          ],
          currentIndex: _selectedPage,
          selectedItemColor: Color(0xFF0C36CC),
          unselectedItemColor:Color(0xFF000000) ,
          onTap: (value){
            setState(() {
              _selectedPage = value;
            });
          },
          type: BottomNavigationBarType.fixed,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Add_page()));
        },
        backgroundColor: Color(0xFF0C36CC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        child: Icon(Icons.add, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
    
  }
}