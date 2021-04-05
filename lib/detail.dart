class Detail {
  String title;
  String description;
  String dbCollection;

  Detail({this.title, this.description, this.dbCollection});
}

final detailsList = [
  Detail(
      title: "Government Job",
      description: "Get to know all the opening government jobs.",
      dbCollection: "Govt Job"),
  Detail(
      title: "Non-Government Job",
      description: "Get to know all private companies job openings.",
      dbCollection: "Non Govt Job"),
  Detail(
      title: "Internship",
      description:
          "An opportunity for career exploration and development, and to learn new skills.",
      dbCollection: "Internship"),
  Detail(
      title: "Walkin",
      description: "Find out the walk-in details in your city.",
      dbCollection: "Walkin"),
  Detail(
      title: "Scholarship",
      description: "It is a payment made to support student's education.",
      dbCollection: "Scholarship"),
  Detail(
      title: "Events",
      description:
          "Various programs that are going to take place in the upcoming days.",
      dbCollection: "Events"),
];
