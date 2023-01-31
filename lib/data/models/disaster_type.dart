abstract class DisasterType {
  int? levelOfDanger;
  DisasterType({this.levelOfDanger});
}

class Flood extends DisasterType {
  int? waterLevel;
  Flood(this.waterLevel) : super() {
    this.levelOfDanger = levelOfDanger;
  }
}

class Rain extends DisasterType {
  int? rainfallIntensity;
  Rain({this.rainfallIntensity}) : super() {
    this.levelOfDanger = levelOfDanger;
  }
}

class Fire extends DisasterType {
  int? size;
  Fire({this.size}) : super() {
    this.levelOfDanger = levelOfDanger;
  }
}

class BuildingCollapse extends DisasterType {
  int? numberOfCasualties;
  BuildingCollapse(this.numberOfCasualties) : super() {
    this.levelOfDanger = levelOfDanger;
  }
}

class Accident extends DisasterType {
  int? numberOfVehiclesInvolved;
  Accident(this.numberOfVehiclesInvolved) : super() {
    this.levelOfDanger = levelOfDanger;
  }
}

class Explosion extends DisasterType {
  int? blastRadius;
  Explosion(this.blastRadius) : super() {
    this.levelOfDanger = levelOfDanger;
  }
}
