class SoilState {
  static final SoilState instance = SoilState._();
  double n = 0;
  double p = 0;
  double k = 0;
  double ph = 0;
  double oc = 0;
  SoilState._();
  void update({
    required double n,
    required double p,
    required double k,
    required double ph,
    required double oc,
  }) {
    this.n = n;
    this.p = p;
    this.k = k;
    this.ph = ph;
    this.oc = oc;
  }
}
