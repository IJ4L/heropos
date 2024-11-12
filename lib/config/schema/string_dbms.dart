String transactions = '''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            transactionDate TEXT,
            totalAmount REAL,
            tunai INTEGER
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
          )
        ''';

String transactionDetails = '''
          CREATE TABLE transactionDetails(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            transactionId INTEGER,
            itemName TEXT,
            quantity INTEGER,
            unitPrice REAL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (transactionId) REFERENCES transactions (id)
          )
        ''';

String profile = '''
  CREATE TABLE profile (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    alamat TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    img TEXT NOT NULL
  )
''';

String pdefaultProfile = '''
  INSERT INTO profile (name, alamat, email, phone, img)
  VALUES ('Edit Profile Toko', 'Default Address', 'edit@example.com', '123-456-7890', 'assets/images/img_toko.png')
''';

String products = '''
   CREATE TABLE products (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NamaProduk TEXT NOT NULL,
    KodeProduk TEXT UNIQUE NOT NULL,
    Harga_Beli REAL NOT NULL,
    Harga_Jual REAL NOT NULL,
    Harga_Grosir REAL,
    Stok INTEGER NOT NULL,
    KategoriProduk TEXT,
    GambarProduk TEXT,
    TanggalKadaluarsa DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
  );
''';
