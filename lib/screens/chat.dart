
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/models/message.dart';
import 'package:m_admin/models/rdv.dart';
import 'package:m_admin/widget/input.dart';


class ChatScreenAdmin extends StatefulWidget {
  final String? telephoneuser;
  final RdvModel data;
  const ChatScreenAdmin({
    super.key,
    required this.telephoneuser,
    required this.data,
    /*  required this.data */
  });

  @override
  State<ChatScreenAdmin> createState() => _ChatScreenAdminState();
}

class _ChatScreenAdminState extends State<ChatScreenAdmin> {
  TextEditingController _text = TextEditingController();
  late int tel = 0;

  _connect() async {
    // tel = int.parse(widget.telephoneuser);
    // await ZIMKit().connectUser(id: widget.data.id_rdv.toString());
    print('___Connect_to__ZIM');
    return await ApiRdv().getMessageBy(widget.data.id_rdv, widget.telephoneuser);
  }

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  Widget build(BuildContext context) {
    late double width = MediaQuery.of(context).size.width;
    late double height = MediaQuery.of(context).size.height;

    var sendTo = 0;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 10,
                child: Container(
                  child: FutureBuilder(
                    future: ApiRdv().getMessageBy(
                        widget.data.id_rdv, widget.data.telephoneuser),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ));

                      List<Message> data = snapshot.data;
                      print("object");

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          print("___LENGTH__${data.length}");

                          sendTo = data[index].from_num;

                          return Column(
                            children: [
                              data[index].to_num == widget.telephoneuser
                                  ? ChatBubble(
                                      clipper: ChatBubbleClipper1(
                                          type: BubbleType.receiverBubble),
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(top: 20),
                                      backGroundColor: Colors.blue,
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                        ),
                                        child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : ChatBubble(
                                      clipper: ChatBubbleClipper1(
                                          type: BubbleType.sendBubble),
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(top: 20),
                                      backGroundColor: Colors.blue,
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                        ),
                                        child: Text(
                                          data[index].content,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                            ],
                          );
                        },
                      );
                    },
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TiInput(
                      color: Colors.black,
                      hintText: 'Message',
                      // height: height * .08,
                      icon: '',
                      hintColor: Colors.white,
                      // border: Border.all(width: .1, color: Colors.white),
                      inputController: _text,
                      keyboardType: TextInputType.text,
                      readonly: false,
                      width: width * .7),
                  GestureDetector(
                    onTap: () {
                      var admin = 'admin';
                      ApiRdv().addMessage(sendTo, widget.telephoneuser,
                          _text.text, admin, widget.data.id_rdv);
            
                      setState(() {
                        _text.text = "";
                      });
                    },
                    child: Container(
                      width: width * .15,
                      height: height * .08,
                      color: Colors.grey,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
