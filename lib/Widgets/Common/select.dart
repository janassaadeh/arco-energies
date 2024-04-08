import 'package:flutter/material.dart';

class SelectionList extends StatefulWidget {
  final List<String> itemList;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  SelectionList({
    required this.itemList,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  _SelectionListState createState() => _SelectionListState();
}

class _SelectionListState extends State<SelectionList> {
  TextEditingController searchController = TextEditingController();
  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.itemList;
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent, // Set canvas color to transparent
      ),
      child: Container(
        height: 300,
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  height: 40,
                  padding: EdgeInsets.only(left: 11),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Payment Methods',
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      // Handle search functionality if needed
                      setState(() {
                        filteredList = widget.itemList
                            .where((item) =>
                                item.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(filteredList[index]),
                      trailing: widget.selectedIndex == index
                          ? Icon(Icons.check, color: Color(0xFF72D4AB))
                          : null,
                      onTap: () {
                        final originalIndex = widget.itemList.indexOf(filteredList[index]);
                        widget.onItemSelected(originalIndex);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
