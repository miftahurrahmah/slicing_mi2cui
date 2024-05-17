import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slicing_mi2cui/LatihanSlicing/page_detail.dart';

class PageMyCourse extends StatefulWidget {
  const PageMyCourse({super.key});

  @override
  State<PageMyCourse> createState() => _PageMyCourseState();
}

class _PageMyCourseState extends State<PageMyCourse> {
  List<String> ListDevice = [
    'Machine Learning',
    'Data Science',
  ];

  bool isCari = true;
  List<String> filterDevice = [];
  TextEditingController txtCari = TextEditingController();

  @override
  void initState() {
    super.initState();
    txtCari.addListener(() {
      setState(() {
        isCari = txtCari.text.isEmpty;
        filterDevice = ListDevice
            .where((device) => device.toLowerCase().contains(txtCari.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    txtCari.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: txtCari,
              decoration: InputDecoration(
                hintText: "My Courses",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(1),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: isCari ? CreateDeviceList() : CreateFilterList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget CreateDeviceList() {
    return ListView.builder(
      itemCount: ListDevice.length < 2 ? ListDevice.length : 2, // Limit to 2 items
      itemBuilder: (context, index) {
        // Modify the title and content for the first card
        if (index == 0) {
          return CourseCard(
            title: 'Machine Learning', // Updated title
            content: 'The Machine learning basics program is designed to offer a solid foundation & work-ready skills for ML engineers...', // Updated content
            duration: "4 hours",
            completionPercent: (index + 1) * 20, // Example percentage
            onPressed: () {
              // Navigate to detail page when Start Learning is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage()),
              );
            },
          );
        } else {
          return CourseCard(
            title: 'Data Science', // Updated title
            content: 'Most people know the power Excel can wield, especially when used properly. But fewer people know how to make...', // Updated content
            duration: "2 hours",
            completionPercent: (index + 1) * 20, // Example percentage
            onPressed: () {
              // Add your action here
              print('Start Learning Data Science');
            },
          );
        }
      },
    );
  }


  Widget CreateFilterList() {
    filterDevice = [];
    for (int i = 0; i < ListDevice.length; i++) {
      var item = ListDevice[i];
      if (item.toLowerCase().contains(txtCari.text.toLowerCase())) {
        filterDevice.add(item);
      }
    }
    return HasilSearch();
  }

  Widget HasilSearch() {
    return ListView.builder(
      itemCount: filterDevice.length < 2 ? filterDevice.length : 2, // Limit to 2 items
      itemBuilder: (context, index) {
        return CourseCard(
          title: filterDevice[index],
          content: "This is the content for ${filterDevice[index]}.",
          duration: "10 hours",
          completionPercent: (index + 1) * 20, // Example percentage
          onPressed: () {
            // Add your action here
            print('Start Learning ${filterDevice[index]}');
          },
        );
      },
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String content;
  final String duration;
  final int completionPercent;
  final VoidCallback? onPressed;

  const CourseCard({
    required this.title,
    required this.content,
    required this.duration,
    required this.completionPercent,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      duration,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "$completionPercent%",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(width: 4),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        value: completionPercent / 100.0,
                        strokeWidth: 2.0,
                        color: completionPercent == 100 ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8), // Add space between completion info and button
            Center(
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text('Start Learning'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


