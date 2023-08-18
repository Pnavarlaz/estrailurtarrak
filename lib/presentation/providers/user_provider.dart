import 'package:estrailurtarrak/presentation/users/user_box.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  List<UserBox> userList = [
    UserBox(name: 'Paul', surname: 'Navarlaz', imageUrl: 'https://img2.rtve.es/i/?w=1600&i=1658387876662.jpg'),
    UserBox(name: 'Malen', surname: 'Dominguez', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/5b/Gal_Gadot_cropped_lighting_corrected_2b.jpg'),
    UserBox(name: 'Lide', surname: 'Fernandez', imageUrl: 'https://www.elnacional.cat/enblau/uploads/s1/43/16/49/15/scarlett-johansson.jpeg')
  ];

  Future<void> sendMessage(String text) async {
    // TODO
  }

  void moveScrollToTop() async {
    // TODO
  }
}
