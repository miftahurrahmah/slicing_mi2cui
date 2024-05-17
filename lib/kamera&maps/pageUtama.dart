import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slicing_mi2cui/kamera&maps/page_camera.dart';
import 'package:slicing_mi2cui/kamera&maps/page_maps.dart';


class PageBeranda extends StatelessWidget {
  const PageBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Projek MI 2C'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  // Code untuk pindah page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AksesKamera(),)
                  );
                },
                child: Text(
                  'Kamera',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                color: Colors.green,
                textColor: Colors.white,
              ),
              SizedBox(height: 10),
              MaterialButton(
                onPressed: () {
                  // Code untuk pindah page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapsFlutter()),
                  );
                },
                child: Text(
                  'Maps',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                color: Colors.green,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
