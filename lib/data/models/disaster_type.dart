class DisasterType {
  int? levelOfDanger;
  DisasterType(this.levelOfDanger);

  factory DisasterType.fromMap(Map<String, dynamic> map) =>
      DisasterType(map['levelOfDanger']);

  Map<String, dynamic> toMap() => {"levelOfDanger": levelOfDanger};
}

class Flood extends DisasterType {
  int? waterLevel;
  Flood({this.waterLevel}) : super(waterLevel);
}

class Rain extends DisasterType {
  int? rainfallIntensity;
  Rain({this.rainfallIntensity}) : super(rainfallIntensity);
}

class Fire extends DisasterType {
  int? size;
  Fire({this.size}) : super(size);
}

class BuildingCollapse extends DisasterType {
  int? numberOfCasualties;
  BuildingCollapse(this.numberOfCasualties) : super(numberOfCasualties);
}

class Accident extends DisasterType {
  int? numberOfVehiclesInvolved;
  Accident(this.numberOfVehiclesInvolved) : super(numberOfVehiclesInvolved);
}

class Explosion extends DisasterType {
  int? blastRadius;
  Explosion(this.blastRadius) : super(blastRadius);
}
