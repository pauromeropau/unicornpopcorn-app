class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });
  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstatic.popcornopolis.com%2Fmedia%2Fcatalog%2Fproduct%2Fcache%2F1%2Fimage%2F650x%2F7b8fef0172c2eb72dd8fd366c999954c%2Fu%2Fn%2Funicornpopcorn_logo.jpg&f=1&nofb=1';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
