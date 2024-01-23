String transactions = '''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            transactionDate TEXT,
            totalAmount REAL,
            tunai INTEGER
          )
        ''';

String transactionDetails = '''
          CREATE TABLE transactionDetails(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            transactionId INTEGER,
            itemName TEXT,
            quantity INTEGER,
            unitPrice REAL,
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