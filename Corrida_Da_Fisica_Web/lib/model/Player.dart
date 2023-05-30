

class Player{

  final String name;
  final String id;
  final String image;
  final int color;

  Player(this.name, this.id, this.image, this.color);

  @override
  String toString() {
    return 'Player{name: $name, id: $id, image: $image, color: $color}';
  }
}