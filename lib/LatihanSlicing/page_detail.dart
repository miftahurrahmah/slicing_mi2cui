import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool overviewClicked = false;
  bool lecturesClicked = false;
  bool similarCoursesClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Image.asset(
                'assests/gambar/image2.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Data Science',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '4.5',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '10.5k Learners',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 18,
                          color: overviewClicked ? Colors.purple : Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          overviewClicked = true;
                          lecturesClicked = false;
                          similarCoursesClicked = false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Lectures',
                        style: TextStyle(
                          fontSize: 18,
                          color: lecturesClicked ? Colors.purple : Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          overviewClicked = false;
                          lecturesClicked = true;
                          similarCoursesClicked = false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Similar Courses',
                        style: TextStyle(
                          fontSize: 18,
                          color: similarCoursesClicked ? Colors.purple : Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          overviewClicked = false;
                          lecturesClicked = false;
                          similarCoursesClicked = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                '6 Hours',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.access_time),
            ),
            ListTile(
              title: Text(
                'Completion Certificate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.file_copy_rounded),
            ),
            ListTile(
              title: Text(
                'Beginner',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.auto_graph),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What will I learn ?',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'The Machine learning basics program is designed to offer a solid foundation & work-ready skills for ML engineers. The Machine learning basics program is designed to offer a solid foundation & work-ready skills for ML engineers. Read More',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ratings and Reviews',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              title: Text(
                '3.4',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'Start Learning',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  color: Colors.purple,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
