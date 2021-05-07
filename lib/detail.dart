class Detail {
  String title;
  String description;
  String dbCollection;

  Detail({this.title, this.description, this.dbCollection});
}

final detailsList = [
  Detail(
      title: "Interview Q&A",
      description:
          "Do you want to crack interview? Follow our 100 days posting to learn the 100 basic Interview questions and answers.",
      dbCollection: "Interview Q&A"),
  Detail(
      title: "Government Job",
      description: "All Government job will be posted in this section.",
      dbCollection: "Govt Job"),
  Detail(
      title: "Private Job",
      description:
          "All kind of jobs such as IT,CIVIL,MECH,ECE,EEE,NON IT job details are available in this section.",
      dbCollection: "Non Govt Job"),
  Detail(
      title: "Internship",
      description:
          "The best thing you can do while being in college is Internship. To know the company offering internship, just explore and apply.",
      dbCollection: "Internship"),
  Detail(
      title: "Walkin",
      description: "Find out the walk-In details in your city.",
      dbCollection: "Walkin"),
  Detail(
      title: "Scholarship",
      description:
          "Apply for all kinds of eligible scholarship through this section.",
      dbCollection: "Scholarship"),
  Detail(
      title: "Events",
      description:
          "Various programs that are going to take place in the upcoming days.",
      dbCollection: "Events"),
];
