import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constand/constants.dart';
import 'helper/auth_helper.dart';
import 'helper/cloud_firestore_helper.dart';
import 'model/chat_model/chat_model.dart';
import 'view/chat_screen/Model/Receiver_Details_Model/receiver_details_model.dart';
import 'Widgets/appbar.dart';

class Chat_Screen extends StatelessWidget {
  Chat_Screen({super.key});

  TextEditingController messageController = TextEditingController();
  String? message;

  @override
  Widget build(BuildContext context) {
    Receiver receiver = ModalRoute.of(context)!.settings.arguments as Receiver;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Column(
        children: [
          chatAppBar(),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder(
                          stream: messageData,
                          builder: (ctx, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text("${snapshot.error}"));
                            } else if (snapshot.hasData) {
                              QuerySnapshot? querysnapshot = snapshot.data;
                              List<QueryDocumentSnapshot>? chats =
                                  querysnapshot?.docs;
                              if ((chats!.isEmpty == true)) {
                                return const Center(
                                    child: Text("No Chat Found..."));
                              } else {
                                return ListView.builder(
                                    reverse: true,
                                    itemCount: chats.length,
                                    itemBuilder: (ctx, i) {
                                      return Row(
                                        mainAxisAlignment: (Auth_Helper
                                                    .auth_helper
                                                    .auth
                                                    .currentUser
                                                    ?.uid ==
                                                chats[i]['sentby'])
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: (Auth_Helper
                                                        .auth_helper
                                                        .auth
                                                        .currentUser
                                                        ?.uid ==
                                                    chats[i]['sentby'])
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              Material(
                                                elevation: 1,
                                                color: (Auth_Helper
                                                            .auth_helper
                                                            .auth
                                                            .currentUser
                                                            ?.uid ==
                                                        chats[i]['sentby'])
                                                    ? Colors.teal
                                                    : Colors.black
                                                        .withOpacity(0.5),
                                                borderRadius: (Auth_Helper
                                                            .auth_helper
                                                            .auth
                                                            .currentUser
                                                            ?.uid ==
                                                        chats[i]['sentby'])
                                                    ? const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                        bottomRight:
                                                            Radius.circular(10))
                                                    : const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(0)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                                  child: Text(
                                                    "${chats[i]['message']}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                              (chats[i]['timestamp'] == null)
                                                  ? const Text(" ")
                                                  : Text(
                                                      "${chats[i]['timestamp'].toDate().toString().split(" ")[1].split(":")[0]}:"
                                                      "${chats[i]['timestamp'].toDate().toString().split(" ")[1].split(":")[1]}"),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey.shade100),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: messageController,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff9C9EB9)),
                                          onChanged: (val) {
                                            message = val;
                                          },
                                          onFieldSubmitted: (value) {
                                            ChatDetails chatdetails =
                                                ChatDetails(
                                                    receiverUid: receiver.uid,
                                                    senderUid: Auth_Helper
                                                        .auth_helper
                                                        .auth
                                                        .currentUser!
                                                        .uid,
                                                    message: message!);

                                            Firestore_Helper.firestore_helper
                                                .sendMessage(
                                                    chatDetails: chatdetails);
                                            log("$message");
                                            messageController.clear();
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 0.0),
                                            hintText: 'Message...',
                                            hintStyle: TextStyle(
                                              color: Color(0xff8E8E93),
                                            ),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.attach_file),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(Icons.camera_alt),
                                      const SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.mic,
                              size: 19,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
