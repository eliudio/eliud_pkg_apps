import 'dart:async';

import 'package:eliud_core_main/model/abstract_repository_singleton.dart';
import 'package:eliud_core_main/model/member_model.dart';
import 'package:eliud_pkg_feed_model/model/abstract_repository_singleton.dart'
    as pr;
import 'package:eliud_pkg_feed_model/model/member_profile_model.dart';
import 'package:eliud_pkg_shop/wizards/builders/util/image_tools.dart';

import '../minkey_app.dart';

class ExampleProfile {
  final MemberProfileAccessibleByGroup accessibleByGroup;

  static String identifier = "exampleProfile";

  ExampleProfile(this.accessibleByGroup);

  Future<void> run(MemberModel member, String feedId) async {
    await exampleMemberProfileModel(member, feedId);
  }

  Future<MemberProfileModel> exampleMemberProfileModel(
      MemberModel member, String feedId) async {
    var memberPublicInfo =
        await memberPublicInfoRepository()!.get(member.documentID);
    if (memberPublicInfo == null) {
      throw Exception("ERROR: can't retrieve member data");
    }
    var profilePhoto = await ImageTools.createMemberMediumModelPhoto(
        MinkeyApp.app,
        member.documentID,
        'packages/eliud_pkg_apps/assets/minkey_app/profile/exampleprofile.png');
    var profileBackground = await ImageTools.createMemberMediumModelPhoto(
        MinkeyApp.app,
        member.documentID,
        'packages/eliud_pkg_apps/assets/minkey_app/profile/pexels-pixabay-258109.jpg');
    var value = MemberProfileModel(
      documentID: "${memberPublicInfo.documentID}-$feedId",
      appId: MinkeyApp.app.documentID,
      authorId: member.documentID,
      feedId: feedId,
      profileBackground: profileBackground,
      profileOverride: profilePhoto.url,
      accessibleByGroup: accessibleByGroup,
      profile: kHtml,
      readAccess: [
        member.documentID
      ], // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
    );

    await pr
        .memberProfileRepository(appId: MinkeyApp.app.documentID)!
        .add(value);
    return value;
  }
}

const kHtml = '''
<h1>Heading 1</h1>
<h2>Heading 2</h2>
<h3>Heading 3</h3>
<h4>Heading 4</h4>
<h5>Heading 5</h5>
<h6>Heading 6</h6>

<p>
  <a name="top"></a>A paragraph with <strong>&lt;strong&gt;</strong>, <em>&lt;em&gt;phasized</em>
  and <span style="color: red">colored</span> text.
  With an inline Flutter logo:
  <img src="https://github.com/daohoangson/flutter_widget_from_html/raw/master/demo_app/logos/android.png" style="width: 1em" />.
</p>

<p>&lt;RUBY&gt; <ruby style="font-size: 200%">明日 <rp>(</rp><rt>Ashita</rt><rp>)</rp></ruby></td></p>
<p>&lt;SUB&gt; C<sub>8</sub>H<sub>10</sub>N<sub>4</sub>O<sub>2</sub></p>
<p>&lt;SUP&gt; <var>a<sup>2</sup></var> + <var>b<sup>2</sup></var> = <var>c<sup>2</sup></var></p>

<h4>&lt;IFRAME&gt; of YouTube:</h4>
<iframe src="https://www.youtube.com/embed/jNQXAC9IVRw" width="560" height="315">
  Your browser does not support IFRAME.
</iframe>

<h4>&lt;IMG&gt; of a cat:</h4>
<figure>
  <img src="https://media.giphy.com/media/6VoDJzfRjJNbG/giphy-downsized.gif" width="250" height="171" />
  <figcaption>Source: <a href="https://gph.is/QFgPA0">https://gph.is/QFgPA0</a></figcaption>
</figure>

<h4>Lists:</h4>
<table border="1" cellpadding="4">
  <tr>
    <th>&lt;UL&gt; unordered list</th>
    <th>&lt;OL&gt; ordered list</th>
  </tr>
  <tr>
    <td>
      <ul>
        <li>One</li>
        <li>
          Two
          <ul>
            <li>2.1</li>
            <li>2.2</li>
            <li>
              2.3
              <ul>
                <li>2.3.1</li>
                <li>2.3.2</li>
              </ul>
            </li>
          </ul>
        </li>
      </ul>
    </td>
    <td>
      <ol>
        <li>One</li>
        <li>
          Two
          <ol type="a">
            <li>2.1</li>
            <li>2.2</li>
            <li>
              2.3
              <ol type="i">
                <li>2.3.1</li>
                <li>2.3.2</li>
              </ul>
            </li>
          </ul>
        </li>
      </ul>
    </td>
  </tr>
</table>
<br />

<!-- enhanced only -->
<h4>&lt;TABLE&gt; with colspan / rowspan:</h4>
<table border="1" cellpadding="4">
  <tr>
    <td colspan="2">colspan=2</td>
  </tr>
  <tr>
    <td rowspan="2">rowspan=2</td>
    <td>Foo</td>
  </tr>
  <tr>
    <td>Bar</td>
  </tr>
</table>
<!-- /enhanced only -->

<!-- enhanced only -->
<h4>&lt;SVG&gt; of Flutter logo</h4>
<svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 166 202">
    <defs>
        <linearGradient id="triangleGradient">
            <stop offset="20%" stop-color="#000000" stop-opacity=".55" />
            <stop offset="85%" stop-color="#616161" stop-opacity=".01" />
        </linearGradient>
        <linearGradient id="rectangleGradient" x1="0%" x2="0%" y1="0%" y2="100%">
            <stop offset="20%" stop-color="#000000" stop-opacity=".15" />
            <stop offset="85%" stop-color="#616161" stop-opacity=".01" />
        </linearGradient>
    </defs>
    <path fill="#42A5F5" fill-opacity=".8" d="M37.7 128.9 9.8 101 100.4 10.4 156.2 10.4"/>
    <path fill="#42A5F5" fill-opacity=".8" d="M156.2 94 100.4 94 79.5 114.9 107.4 142.8"/>
    <path fill="#0D47A1" d="M79.5 170.7 100.4 191.6 156.2 191.6 156.2 191.6 107.4 142.8"/>
    <g transform="matrix(0.7071, -0.7071, 0.7071, 0.7071, -77.667, 98.057)">
        <rect width="39.4" height="39.4" x="59.8" y="123.1" fill="#42A5F5" />
        <rect width="39.4" height="5.5" x="59.8" y="162.5" fill="url(#rectangleGradient)" />
    </g>
    <path d="M79.5 170.7 120.9 156.4 107.4 142.8" fill="url(#triangleGradient)" />
    Your browser does not support inline SVG.
</svg>
<!-- /enhanced only -->

<!-- enhanced only -->
<h4>&lt;VIDEO&gt;</h4>
<figure>
  <video controls width="320" height="176">
    <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">
    <source src="https://www.w3schools.com/html/mov_bbb.ogg" type="video/ogg">
    Your browser does not support HTML5 video.
  </video>
  <figcaption>Source: <a href="https://www.w3schools.com/html/html5_video.asp">w3schools</a></figcaption>
</figure>
<!-- /enhanced only -->

<p>Anchor: <a href="#top">Scroll to top</a>.</p>
<br />
<br />
''';
