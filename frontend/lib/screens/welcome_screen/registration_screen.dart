import 'package:flutter/material.dart';
import 'package:ltm/common/buttonlogin_registration.dart';
import 'package:ltm/common/notification.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:ltm/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late IO.Socket socket;
  String user = "";
  String passWord = "";

  Future registe() async {
    if (await context.read<UserState>().registe(user, passWord)
    ) {
      Navigator.pushNamedAndRemoveUntil(context, MyHome.id, (route) => false);
    } else {
      alert(context, "Tài khoản đã tồn tại");
    }
    
  }

  connect(){
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.130.112:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    print(1);
    socket.connect();
    print(2);
    socket.emit("signin", "widget.sourchat.id");
    print(3);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        // setMessage("destination", msg["message"]);
        // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  user = value;
                },
                decoration:
                    kTextfiledecoration.copyWith(hintText: 'username')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                onChanged: (value) {
                  passWord = value;
                },
                decoration: kTextfiledecoration.copyWith(
                    hintText: 'password')),
            SizedBox(
              height: 24.0,
            ),
            buttonlogin_registration(
              coulour: Colors.blueAccent,
              tittle: 'Register',
              onPress: () async {
                connect();
                // try {
                //   registe();
                // } catch (e) {
                //   print(e);
                // }
              },
            )
          ],
        ),
      ),
    );
  }
}
