import 'package:accounting/service/model.dart';

abstract class AbstractModel implements Model {
  int id_;
  int id;

  int getId() {
    return id;
  }
  int getId_() {
    return id;
  }

}