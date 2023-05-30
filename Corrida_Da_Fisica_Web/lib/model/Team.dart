import 'dart:ui';
import 'Player.dart';

class Team {
  final String id;
  String name;
  String image;
  List<Player> players = [];
  Player? teamLeader;
  Image? loadedImage;
  int square = 0;
  bool imageAltered = true;

  Team(this.name, this.image, this.id);

  @override
  String toString() {
    return 'Team{id: $id, name: $name, image: $image, players: $players, teamLeader: $teamLeader, loadedImage: $loadedImage, square: $square, imageAltered: $imageAltered}';
  }

  getPlayerById(id){
    return players.firstWhere((player) => player.id == id);
  }

  setImageAltered(bool imageAltered) {
    imageAltered = imageAltered;
  }

  addPlayer(Player player) {
    teamLeader ??= player;
    players.add(player);
  }

  changeTeamLeader(Player newLeader) {
    teamLeader = newLeader;
  }

  changeTeamName(String newName) {
    name = newName;
  }

  changeImage(String newImage) {
    image = newImage;
  }

  changeSquare(int newSquare) {
    square = newSquare;
  }

  setImage(Image image) {
    loadedImage = image;
  }
}
