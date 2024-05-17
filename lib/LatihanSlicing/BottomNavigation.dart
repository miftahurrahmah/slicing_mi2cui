import 'package:flutter/material.dart';
import 'package:slicing_mi2cui/LatihanSlicing/Home.dart';
import 'package:slicing_mi2cui/LatihanSlicing/page_mycourse.dart';

class PageBottomNavigationBar extends StatefulWidget {
  const PageBottomNavigationBar({Key? key});

  @override
  State<PageBottomNavigationBar> createState() =>
      _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Color? containerColor;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    containerColor = Colors.transparent;
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      containerColor = Colors.purple;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            containerColor = Colors.purple;
          });
        },
        child: TabBarView(
          controller: tabController,
          children: const [
            // content
            PageHome(),
            PageMyCourse()

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TabBar(
            controller: tabController,
            labelColor: Colors.purple,
            tabs: const [
              Tab(
                text: "Home",
                icon: Icon(Icons.home),
              ),
              Tab(
                text: "My Courses",
                icon: Icon(Icons.play_circle_outline_outlined),
              ),
              Tab(
                text: "Blogs",
                icon: Icon(Icons.my_library_books_sharp),
              ),
              Tab(
                text: "My Profile",
                icon: Icon(Icons.person_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
