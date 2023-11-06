import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.messageText,
  });
  final Message messageText;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 5, bottom: 5, top: 15),
      /*  padding:
            const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),*/
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:const EdgeInsets.only(left: 15, top: 15, bottom: 8, right: 15),
              child: Text(
                messageText.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 8, right: 18),
              child: Text(
                messageText.id.substring(0,getIndex(messageText.id)),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ChatBubbleFromOthers extends StatelessWidget {
  const ChatBubbleFromOthers({
    super.key,
    required this.messageText,
  });
  final Message messageText;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 5, bottom: 5, top: 15),
        decoration: const BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding:const EdgeInsets.only(left: 15, top: 15, bottom: 4, right: 15),
              child: Text(
                messageText.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5, bottom: 8, left: 18),
              child: Text(
                messageText.id.substring(0,getIndex(messageText.id)),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    
}
int? getIndex (String email){
  int? index;
  for(int i=0 ;i<email.length;i++){
    if(email[i]=='@'){
      index = i;
    }
  }
  return index;
}