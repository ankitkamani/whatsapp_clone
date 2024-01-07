import 'package:flutter/material.dart';
import 'package:whatsapp_clone/view/login.dart';
import 'package:whatsapp_clone/view/status_view.dart';

import '../helper/auth_helper.dart';
import '../setting_screen.dart';
import 'calls_view.dart';
import 'chat_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  late TabController tabController;
  var fabIcon = Icons.message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(vsync: this, length: 4)
      ..addListener(() {
        setState(() {
          switch (tabController.index) {
            case 0:
              fabIcon = Icons.camera_alt_outlined;
              break;
            case 1:
              fabIcon = Icons.chat;
              break;
            case 2:
              fabIcon = Icons.camera_alt_outlined;
              break;
            case 3:
              fabIcon = Icons.message;
              break;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:  AppBar(
        title:   Text(
          "WhatsApp",
          style:   Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
        ),
        actions:  <Widget>  [
          Padding(
            padding:  const EdgeInsets.only(right: 20.0),
            child: InkWell(onTap: () {
              Auth_Helper.auth_helper.signOut();
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const Login()),(route) => false,);
            },child: const Icon(Icons.logout)),
          ),
          PopupMenuButton(
              enabled: true,
              icon: const Icon(Icons.more_vert_outlined),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text("New Group" ,  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text("Linked devices") ,
                ),
                PopupMenuItem(
                  value: 2,
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
                      },
                      child: const Text("Setting")) ,
                )
              ]
          ),

        ],
        bottom:  TabBar(
          tabs: const [
            Tab(
                child: Icon(Icons.camera_alt)),
            Tab(
              child: Text("CHATS"),
            ),
            Tab(
                child: Text(
                  "STATUS",
                )),
            Tab(
                child: Text(
                  "CALLS",
                )),

          ],

          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          Icon(Icons.camera_alt),
          ChatListView(),
          StatusScreen(),
          CallsView(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(fabIcon),
      ),
    );
  }
}
