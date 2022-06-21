class ListChapter {
  final String judul_chapter;
  final String link;

  ListChapter({
    required this.judul_chapter,
    required this.link,
  });

  factory ListChapter.fromJson(Map<String, dynamic> json) => ListChapter(
      judul_chapter: json['judul'],
      link: json['link']
  );
}

class ListHome {
  final String name_book;
  final List<ListChapter> list;

  ListHome({
    required this.name_book,
    required this.list,
  });

  factory ListHome.fromJson(Map<String, dynamic> json) => ListHome(
    name_book: json['name_book'],
    list: List<ListChapter>.from(json['data'].map((data) => ListChapter.fromJson(data))),
  );
}