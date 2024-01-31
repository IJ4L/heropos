enum AppRoute {
  splash(path: "/splash"),
  activity(path: "/activity"),
  chasier(path: "/chasier"),
  troli(path: "troli"),
  payment(path: "payment"),
  paymentsuccess(path: "paymentsuccess"),
  struk(path: "struk"),
  editprofile(path: "editprofile"),
  printingtest(path: "printingtest"),
  produk(path: "produk"),
  addproduk(path: "addproduk"),
  toko(path: "/toko");

  final String path;
  const AppRoute({required this.path});
}
