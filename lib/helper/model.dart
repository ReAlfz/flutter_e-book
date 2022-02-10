class Config {
  final bool appMode;
  final String data;
  final int opsi_ad;
  final int interstitial_interval;
  final int list_native_interval;

  final String android_interstitial_admob;
  final String android_native_admob;
  final String ios_interstitial_admob;
  final String ios_native_admob;

  final String html_condition;
  final String html_privacy;

  Config({
    required this.appMode,
    required this.data,
    required this.opsi_ad,
    required this.interstitial_interval,
    required this.list_native_interval,

    required this.android_interstitial_admob,
    required this.android_native_admob,
    required this.ios_native_admob,
    required this.ios_interstitial_admob,

    required this.html_privacy,
    required this.html_condition,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    appMode: json['appmode'],
    data: json['data'],
    opsi_ad: json['opsi_ad'],
    interstitial_interval: json['interstitial_interval'],
    list_native_interval: json['list_native_interval'],

    android_interstitial_admob: json['android_interstitial_admob'],
    android_native_admob: json['android_native_admob'],
    ios_interstitial_admob: json['ios_interstitial_admob'],
    ios_native_admob: json['ios_native_admob'],

    html_condition: json['html_condition'],
    html_privacy: json['html_privacy']
  );
}

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

class Base {
  final List<ListHome> listed;
  
  Base({
    required this.listed,
  });
  
  factory Base.fromJson(Map<String, dynamic> json) => Base(
      listed: List<ListHome>.from(json['base'].map((data) => ListHome.fromJson(data)))
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