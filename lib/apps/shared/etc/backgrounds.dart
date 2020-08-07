import 'package:eliud_model/shared/background_model.dart';
import 'package:eliud_model/shared/decoration_color_model.dart';
import 'package:eliud_model/shared/rgb_model.dart';
import 'package:eliud_model/shared/shadow_model.dart';
import 'package:flutter/cupertino.dart';

class Backgrounds {
  static BackgroundModel _construct({String appId, String documentId, RgbModel fromColor, RgbModel toColor, ShadowModel withShadow, StartGradientPosition startPosition, EndGradientPosition endPosition, }) {
    List<DecorationColorModel> decorationColorModels = List();
    DecorationColorModel decorationColorModel1 = DecorationColorModel(
      documentID: "1",
      color: fromColor,
    );
    decorationColorModels.add(decorationColorModel1);
    DecorationColorModel decorationColorModel2 = DecorationColorModel(
      documentID: "2",
      color: toColor,
    );

    decorationColorModels.add(decorationColorModel2);
    BackgroundModel backgroundModel = BackgroundModel(
      documentID: documentId,
      appId: appId,
      beginGradientPosition: startPosition != null ? startPosition : StartGradientPosition.CenterLeft,
      endGradientPosition: endPosition != null ? endPosition : EndGradientPosition.CenterRight,
      decorationColors: decorationColorModels,
      shadow: withShadow,
    );
    return backgroundModel;
  }


  static BackgroundModel gradient({String appId, String documentId, RgbModel fromColor, RgbModel toColor, ShadowModel withShadow, StartGradientPosition startPosition, EndGradientPosition endPosition, }) {
    return _construct(appId: appId, documentId: documentId, fromColor: fromColor, toColor: toColor, withShadow: withShadow, startPosition: startPosition, endPosition: endPosition);
  }

  static BackgroundModel solid(String appId, String documentId, RgbModel color, ShadowModel withShadow) {
    return _construct(appId: appId, documentId: documentId, fromColor: color, toColor: color, withShadow: withShadow);
  }
}
