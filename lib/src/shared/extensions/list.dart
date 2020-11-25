extension DistictList on List {
  bool isDistinct() => this.toSet().length == this.length;
}
