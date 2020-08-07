class LinkSpec {
  final String linkText;
  final String link;

  LinkSpec(this.linkText, this.link);
}

class SectionSpec {
  final String title;
  final String text;

  final List<LinkSpec> links;

  SectionSpec(this.title, this.text, {this.links});
}

class PageSpec {
  final List<SectionSpec> sections;

  PageSpec(this.sections);
}

String pageHeader = """
{
  "type": "ListView",
  "shrinkWrap": true,
  "physics" : {
    "type": "NeverScrollableScrollPhysics"
  },
  "padding": "10, 10, 10, 10",
  "children":[""";

String pageFooter = """
  ]
}""";

String sectionHeader = """
    {
      "type": "ListTile",
      "title": {
        "type": "Text",
        "data": "\${title}",
        "style": { "fontSize": 20.0, "fontWeight": "bold" }
      },
      "subtitle": {
        "type": "Text",
        "data": "\${text}",
        "style": { "fontSize": 20.0 }
      }
    },
    { "type": "SizedBox", "height": 20.0, "child":{} },""";

String sectionFooter = "";

String linksHeader = """
    {
      "type": "Wrap",
      "spacing" : 8.0,
      "runSpacing" : 8.0,
      "alignment":"center", 
      "runAlignment" : "start",
      "crossAxisAlignment":"center",
      "children": [""";

String linkContent = """
        {
            "type": "RaisedButton",
            "padding": "8,8,8,8",
            "splashColor" : "#00FF00",
            "click_event" : "page://\${link}",
            "child" : {
              "type": "Text",
              "data": "\${title}"
            }  
        },""";

String linksFooter = """
      ]
    },
    { "type": "SizedBox", "height": 20.0, "child":{} },""";

class DynamicHelper {
  static String _replace(String template, { Map<String, String> parameters }) {
    if (parameters != null) {
      String processed = template;
      parameters.forEach((key, value) {
        processed = processed.replaceAll(key, value);
      });
      return processed;
    } else {
      return template;
    }
  }

  static String _removeTrailingComma(String value) {
    if (value[value.length -1] == ",")
      return value.substring(0, value.length-1);
    return value;
  }

  static String getPage(PageSpec pageSpec) {
    String value = pageHeader;
    int sectionLen = pageSpec.sections.length;
    for (int i = 0; i < sectionLen; i++) {
      SectionSpec section = pageSpec.sections[i];
      String sectionValue = _replace(sectionHeader,
          parameters: <String, String> {
            "\${title}": "${section.title}",
            "\${text}": "${section.text}"});
      String linksValue = linksHeader;
      if (section.links != null) {
        int lenLinks = section.links.length;
        for (int j = 0; j < lenLinks; j++) {
          LinkSpec link = section.links[j];
          linksValue = linksValue + _replace(linkContent,
              parameters: <String, String>{
                "\${link}": "${link.link}",
                "\${title}": "${link.linkText}"});
        }
        linksValue = _removeTrailingComma(linksValue);
        linksValue = linksValue + linksFooter;
        sectionValue = sectionValue + linksValue;
      }
      sectionValue = sectionValue + sectionFooter;
      value = value + sectionValue;
    }
    value = _removeTrailingComma(value);
    value = value + pageFooter;
    return value;
  }
}