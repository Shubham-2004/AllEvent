import 'package:allevent/Domain/logics/homepagelogic.dart';
import 'package:allevent/presentation/search/Screen/event_item.dart';
import 'package:allevent/presentation/search/Screen/filter_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageLogic(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('AllEvents'),
          backgroundColor: Colors.blueAccent,
          actions: [
            Consumer<HomePageLogic>(
              builder: (context, logic, child) {
                return IconButton(
                  icon: Icon(
                      logic.isGridView ? Icons.view_list : Icons.grid_view),
                  onPressed: logic.toggleView,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
                onBackgroundImageError: (exception, stackTrace) {
                  // Handle image loading error
                },
                child: Icon(Icons.person),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Consumer<HomePageLogic>(
                      builder: (context, logic, child) {
                        return TextField(
                          controller: logic.searchController,
                          onChanged: logic.filterd,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    FilterSelection(),
                    SizedBox(height: 20),
                    Text(
                      'Events',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Consumer<HomePageLogic>(
                      builder: (context, logic, child) {
                        return logic.events.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: logic.isTyping
                                    ? logic.filter.length
                                    : logic.events.length,
                                itemBuilder: (context, index) {
                                  var event = logic.isTyping
                                      ? logic.filter[index]
                                      : logic.events[index];
                                  return EventItem(event: event);
                                },
                              )
                            : logic.events.isEmpty
                                ? Text("No Events Found")
                                : CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
