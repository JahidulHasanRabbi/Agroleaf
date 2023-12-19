import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'package:agro/main.dart';

class DiseaseCategory extends StatefulWidget {
  @override
  _DiseaseCategoryState createState() => _DiseaseCategoryState();
}

class _DiseaseCategoryState extends State<DiseaseCategory> {
  List<Map<String, String>> diseaseData = [];

  @override
  void initState() {
    super.initState();
    loadDataFromXml();
  }

  Future<void> loadDataFromXml() async {
    const String xmlString = '''
      <?xml version="1.0" encoding="UTF-8"?>
      <rice_diseases>
        <disease>
          <name>Bacterial Leaf Blight</name>
          <image>assets/bacterial_leaf_b.JPG</image>
          <symptoms>
            Bacterial Leaf Blight is a common rice disease caused by the bacterium Xanthomonas oryzae. Symptoms include water-soaked lesions on leaves, which later turn yellow and form irregular stripes. These lesions can coalesce and lead to wilting and death of the affected leaf areas.
          </symptoms>
        </disease>
        <disease>
          <name>Brown Spot</name>
          <image>assets/brown_spot (59).jpg</image>
          <symptoms>
            Brown Spot is characterized by small, dark brown to black lesions on rice leaves. These spots can coalesce, causing leaf blighting. Infected leaves may also have yellow margins, and the disease is favored by high humidity.
          </symptoms>
        </disease>
        <disease>
          <name>Leaf Blast</name>
          <image>assets/leaf_blast (130).jpg</image>
          <symptoms>
            Leaf Blast, caused by the fungus Magnaporthe oryzae, results in circular or spindle-shaped lesions with a gray center and brown margins on rice leaves. These lesions may also have a white, fluffy appearance under high humidity.
          </symptoms>
        </disease>
        <disease>
          <name>Leaf Scald</name>
          <image>assets/leaf_scald (14).jpg</image>
          <symptoms>
            Leaf Scald is caused by the bacterium Rhizoctonia solani. It leads to long, water-soaked lesions on leaves, which turn straw-colored with age. Infected plants may exhibit stunting and poor grain development.
          </symptoms>
        </disease>
        <disease>
          <name>Narrow Brown Spot</name>
          <image>assets/narrow_brown (4).jpg</image>
          <symptoms>
            Narrow Brown Spot is characterized by small, oval to spindle-shaped lesions on rice leaves, which are initially yellow and later turn brown. These lesions are often surrounded by a yellow halo.
          </symptoms>
        </disease>
      </rice_diseases>
    ''';

    final XmlDocument document = XmlDocument.parse(xmlString);

    final Iterable<XmlElement> diseaseElements =
        document.findAllElements('disease');
    for (final diseaseElement in diseaseElements) {
      final String name = diseaseElement.findElements('name').first.text;
      final String image = diseaseElement.findElements('image').first.text;
      final String symptoms = diseaseElement
          .findElements('symptoms')
          .first
          .text
          .trimLeft(); // Remove leading whitespace

      diseaseData.add({
        'name': name,
        'image': image,
        'symptoms': symptoms,
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, camerahome);
        return true; // Return true to allow the back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Disease Categories'),
          backgroundColor: Colors.green,
          leading: BackButton(
            onPressed: () {
              Navigator.pushNamed(context, camerahome);
            },
          ),
        ),
        body: ListView.builder(
          itemCount: diseaseData.length,
          itemBuilder: (context, index) {
            final disease = diseaseData[index];
            final symptomLines = disease['symptoms']!.split('\n').map((line) =>
                Text(line,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)));
            return Padding(
              padding: EdgeInsets.all(5),
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            disease['name']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset(
                          disease['image']!,
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                    Column(
                      children: symptomLines.toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
