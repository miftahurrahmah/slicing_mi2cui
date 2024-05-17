import 'package:flutter/material.dart';
import 'page_cyber_security.dart'; // Import halaman PageCyberSecurity
import 'page_machine_learning.dart'; // Import halaman PageMachineLearning

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  List<String> ListDevice = []; // Isi ListDevice dengan data

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
        body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(10),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    ),
    child: Row(
    children: [
    Expanded(
    child: TextField(
    controller: txtCari,
    decoration: InputDecoration(
    hintText: 'Hi Liza!',
    hintStyle: TextStyle(color: Colors.black),
    border: InputBorder.none,
    ),
    style: TextStyle(color: Colors.black),
    ),
    ),
    IconButton(
    onPressed: () {},
    icon: Icon(Icons.search, color: Colors.black),
    ),
    ],
    ),
    ),
    SizedBox(height: 10),
    Center(
    child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height / 3,
    child: Image.asset(
    'assests/gambar/slicing.png',
    fit: BoxFit.cover,
    ),
    ),
    ),
    ),
    SizedBox(height: 25),
    Text(
    'Categories',
    style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    SizedBox(height: 10),
    SizedBox(
    height: 100,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 3,
    itemBuilder: (context, index) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: InkWell(
    onTap: () {
    if (index == 0) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => PageCyberSecurity(),
    ),
    );
    }
    },
    child: Card(
    color: Colors.white,
    elevation: 3,
    shadowColor: Colors.white,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
    width: 150,
    height: 50,
    color: Colors.white,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Text(
    index == 0
    ? 'Cyber Security'
        : index == 1
    ? 'Data Science'
        : 'Cyber',
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    ),
    SizedBox(height: 5),
    Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Text(
    index == 0
    ? '145 courses'
        : index == 1
    ? '125 courses'
        : '120 courses',
    style: TextStyle(
    fontSize: 12,
    color: Colors.black,
    ),
    ),
    ),
    ],
    ),
    Icon(
    index == 0
    ? Icons.security
        : index == 1
    ? Icons.science
        : Icons.computer,
    size: 30,
    color: Colors.purple,
    ),
    ],
    ),
    ),
    ),
    ),
    ),
    );
    },
    ),
    ),
    SizedBox(height: 25),
    Text(
    'Top Courses',
    style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    SizedBox(height: 10),
    SizedBox(
    height: 210, // Increased height
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 2,
    itemBuilder: (context, index) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: InkWell(
    onTap: () {
    if (index == 0) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => PageCyberSecurity(),
    ),
    );
    } else if (index == 1) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PageMachineLearning(),
      ),
      );
    }
    },
      child: Card(
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10), // Increased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200, // Increased width
                height: 120, // Increased height
                color: Colors.white,
                child: Image.asset(
                  index == 0
                      ? 'assests/gambar/datascience.jpeg'
                      : 'assests/gambar/machinelearning.png',
                  width: 200, // Increased width
                  height: 120, // Increased height
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10), // Increased spacing
              Text(
                index == 0 ? 'Data Science' : 'Machine Learning',
                style: TextStyle(
                  fontSize: 16, // Increased font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18, // Increased icon size
                  ),
                  SizedBox(width: 5),
                  Text(
                    '4.5', // Rating dapat diganti dengan nilai sesuai kebutuhan
                    style: TextStyle(fontSize: 16), // Increased font size
                  ),
                  SizedBox(width: 5),
                  Text(
                    '10.5k Learners', // Teks 10.5k Learners
                    style: TextStyle(fontSize: 16), // Increased font size
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    );
    },
    ),
    ),
      SizedBox(height: 25),
      Text(
        'Popular Blogs',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 180, // Adjusted height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                color: Colors.white,
                elevation: 3,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 150, // Changed to square dimensions
                        color: Colors.white,
                        child: Image.asset(
                          index == 0
                              ? 'assests/gambar/excel.jpeg'
                              : 'assests/gambar/java.jpeg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            index == 0 ? 'Rian Mendela' : 'Liza Nisel',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            index == 0
                                ? 'How To Improve Microsoft Excel Skills'
                                : 'Top 10 Java Tools for 2021', // Adjusted author name
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: 150, // Limit the width to ensure wrapping
                            child: Text(
                              index == 0
                                  ? 'Most people know the power Excel can wield, especially when used properly. But fewer people know how to make the most of Excel...'
                                  : 'Java is the most widely used high level object oriented programming language across the globe. Oracle Corporation purchased SUN MiCROSYSTEM in 2010...',
                              style: TextStyle(fontSize: 12, color: Colors.black),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),



      SizedBox(height: 25),
      isCari
          ? ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: ListDevice.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ListDevice[index]),
          );
        },
      )
          : CreateFilterList(),
    ],
    ),
        ),
        ),
    );
  }

  Widget CreateFilterList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filterDevice.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filterDevice[index]),
        );
      },
    );
  }
}

