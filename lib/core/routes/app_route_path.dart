enum AppRoute {
  splash(path: "/splash"),
  activity(path: "/activity"),
  chasier(path: "/chasier"),
  troli(path: "troli"),
  payment(path: "payment"),
  paymentsuccess(path: "paymentsuccess"),
  toko(path: "/toko");

  final String path;
  const AppRoute({required this.path});
}
