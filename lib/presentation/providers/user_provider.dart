import 'package:estrailurtarrak/presentation/users/user_box.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  List<UserBox> participantList = [
    const UserBox(
        name: 'Paul',
        surname: 'Navarlaz',
        imageUrl: 'https://img2.rtve.es/i/?w=1600&i=1658387876662.jpg'),
    const UserBox(
        name: 'Malen',
        surname: 'Dominguez',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/5/5b/Gal_Gadot_cropped_lighting_corrected_2b.jpg'),
  ];

  List<UserBox> spectatorList = [
    const UserBox(
        name: 'Lide',
        surname: 'Fernandez',
        imageUrl:
            'https://www.elnacional.cat/enblau/uploads/s1/43/16/49/15/scarlett-johansson.jpeg'),
    const UserBox(
        name: 'Iñigo',
        surname: 'Gorrotxategi',
        imageUrl:
            'https://images.hola.com/imagenes/actualidad/20221108220543/chris-evans-el-mas-sexy/1-162-60/chris-evans-gtres1-t.jpg'),
    const UserBox(name: 'Olaia', surname: 'Antero', imageUrl: 'https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/media/image/2021/05/elizabeth-olsen-2322363.jpg?tf=3840x'),
    const UserBox(name: 'Sare', surname: 'Esparza', imageUrl: 'https://static.wikia.nocookie.net/doblaje/images/7/73/Brie_Larson_2020.jpg/revision/latest?cb=20200217235146&path-prefix=es')
  ];

  Future<void> sendMessage(String text) async {
    // TODO
  }

  void moveScrollToTop() async {
    // TODO
  }
}
