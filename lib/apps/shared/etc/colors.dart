import 'package:eliud_model/model/menu_def_model.dart';
import 'package:eliud_model/shared/rgb_model.dart';

class EliudColors {
  static RgbModel lightRed = RgbModel(r: 145, g: 0, b: 0, opacity: 0.50);
  static RgbModel red = RgbModel(r: 255, g: 0, b: 0, opacity: 1.00);
  static RgbModel white = RgbModel(r: 255, g: 255, b: 255, opacity: 1.00);
  static RgbModel whiteTransparent = RgbModel(r: 255, g: 255, b: 255, opacity: 0.50);
  static RgbModel blackTransparent = RgbModel(r: 0, g: 0, b: 0, opacity: .80);
  static RgbModel black = RgbModel(r: 0, g: 0, b: 0, opacity: 1.00);
  static RgbModel green = RgbModel(r: 0, g: 255, b: 0, opacity: 1.00);
  static RgbModel grayTransparent = RgbModel(r: 145, g: 121, b: 145, opacity: 0.30);
  static RgbModel gray = RgbModel(r: 145, g: 121, b: 145, opacity: 1);
  //static RgbModel bordeauxRed = RgbModel(r: 0x6f, g: 0x1c, b: 0x36, opacity: 1);
  static RgbModel bordeauxRed = RgbModel(r: 0x5c, g: 0x02, b: 0x1e, opacity: 1);
  static RgbModel lightbordeauxRed = RgbModel(r: 0x7c, g: 0x02, b: 0x1e, opacity: 1);
  static RgbModel ochre = RgbModel(r: 0xda, g: 0x9b, b: 0x00, opacity: 1);
  static RgbModel ochreTransparent = RgbModel(r: 0xda, g: 0x9b, b: 0x00, opacity: .2);
  static RgbModel lightBlueTransparent = RgbModel(r: 0xa3, g: 0x92, b: 0xf9, opacity: 1);
}
