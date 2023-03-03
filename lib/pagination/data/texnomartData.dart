class TexnomartData {
  TexnomartData({
    required this.items,
    required this.meta,
  });

  List<Item> items;
  Meta meta;

 factory TexnomartData.empty() =>TexnomartData.fromJson({});

  factory TexnomartData.fromJson(Map<String, dynamic> json) => TexnomartData(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        meta: Meta.fromJson(json["_meta"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "_meta": meta.toJson(),
      };
}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.image,
    this.stik,
    required this.allStock,
    required this.availability,
    required this.reviewsCount,
    required this.reviewsMiddleRate,
    required this.salePrice,
    required this.fSalePrice,
    required this.loanPrice,
    required this.fLoanPrice,
    this.oldPrice,
    this.fOldPrice,
    required this.axiomMonthlyPrice,
    required this.kodProduct,
    this.discount,
  });

  int id;
  String name;
  String image;
  dynamic stik;
  int allStock;
  Availability availability;
  int reviewsCount;
  int reviewsMiddleRate;
  int salePrice;
  String fSalePrice;
  int loanPrice;
  String fLoanPrice;
  dynamic oldPrice;
  dynamic fOldPrice;
  String axiomMonthlyPrice;
  String kodProduct;
  dynamic discount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        stik: json["stik"],
        allStock: json["allStock"],
        availability: Availability.fromJson(json["availability"]),
        reviewsCount: json["reviewsCount"],
        reviewsMiddleRate: json["reviewsMiddleRate"],
        salePrice: json["sale_price"],
        fSalePrice: json["f_sale_price"],
        loanPrice: json["loan_price"],
        fLoanPrice: json["f_loan_price"],
        oldPrice: json["old_price"],
        fOldPrice: json["f_old_price"],
        axiomMonthlyPrice: json["axiomMonthlyPrice"],
        kodProduct: json["kod_product"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "stik": stik,
        "allStock": allStock,
        "availability": availability.toJson(),
        "reviewsCount": reviewsCount,
        "reviewsMiddleRate": reviewsMiddleRate,
        "sale_price": salePrice,
        "f_sale_price": fSalePrice,
        "loan_price": loanPrice,
        "f_loan_price": fLoanPrice,
        "old_price": oldPrice,
        "f_old_price": fOldPrice,
        "axiomMonthlyPrice": axiomMonthlyPrice,
        "kod_product": kodProduct,
        "discount": discount,
      };
}

class Availability {
  Availability({
    required this.type,
    required this.text,
  });

  String type;
  String text;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        type: json["type"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
      };
}

class Meta {
  Meta({
    required this.totalCount,
    required this.pageCount,
    required this.currentPage,
    required this.perPage,
  });

  int totalCount;
  int pageCount;
  int currentPage;
  int perPage;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalCount: json["totalCount"],
        pageCount: json["pageCount"],
        currentPage: json["currentPage"],
        perPage: json["perPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "pageCount": pageCount,
        "currentPage": currentPage,
        "perPage": perPage,
      };
}
