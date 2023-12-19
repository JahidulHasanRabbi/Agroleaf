import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageDisplayScreen extends StatelessWidget {
  final File imageFile;

  ImageDisplayScreen(this.imageFile);

  Future<String> fetchClassFromApi() async {
    final Uri url = Uri.parse("https://agroleaf.tech/predict");
    final request = http.MultipartRequest('POST', url)
      ..files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
        ),
      );
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final megValue = jsonResponse["class"];
      return megValue;
    } else {
      return "Error fetching data from API";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String>(
          future: fetchClassFromApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the response, show a loading indicator.
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If there's an error in the API call, display an error message.
              return Text("Error: ${snapshot.error}");
            } else {
              // If data is available, display the image and the API response.
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.file(imageFile),
                  SizedBox(height: 16.0),
                  Text(
                    snapshot.data ?? "No Data",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
