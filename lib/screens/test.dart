  Widget getWidgetForCard(int index) {
    switch (index) {
      case 0:
        return Transactions();
      case 1:
        return Resellers();
      case 2:
        return Omcs();
      case 3:
        return Orders();
      case 4:
        return Customers();
      default:
        return Container(); // Return an empty container by default
    }
  }
}
if (selectedCardIndex == index) getWidgetForCard(index),

GestureDetector(
                            onTap: () {
                              // Toggle the selected card index when a card is clicked
                              setState(() {
                                selectedCardIndex = index;
                              });
                            },