import 'package:flutter/foundation.dart';

import '../models/Post.dart';

class postProvider with ChangeNotifier {
  List<Post> list = [];

  void addItem(Post item) {
    list.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    list.removeAt(index);
    notifyListeners();
  }

  Post getAtIndex(int index){
    return list[index];
  }

  Post? getById(String id){

    var findById = (taskTile) => taskTile.id == id;
    var result = list.where(findById);
    return result.length > 0 ? result.first : null;

  }


  int getLength(){
    return list.length;
  }
}
