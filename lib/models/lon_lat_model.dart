class LonLatModel {
  String? name;
  LocalNames? localNames;
  double? lat;
  double? lon;
  String? country;
  String? state;

  LonLatModel(
      {this.name,
      this.localNames,
      this.lat,
      this.lon,
      this.country,
      this.state});

  LonLatModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localNames = json['local_names'] != null
        ? LocalNames.fromJson(json['local_names'])
        : null;
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (localNames != null) {
      data['local_names'] = localNames!.toJson();
    }
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}

class LocalNames {
  String? zh;
  String? uk;
  String? ascii;
  String? ur;
  String? en;
  String? oc;
  String? ru;
  String? gu;
  String? ar;
  String? he;
  String? de;
  String? featureName;
  String? or;
  String? hi;
  String? kn;
  String? ml;
  String? ja;
  String? eo;
  String? pl;
  String? mr;
  String? cs;
  String? ta;
  String? pa;
  String? te;

  LocalNames(
      {this.zh,
      this.uk,
      this.ascii,
      this.ur,
      this.en,
      this.oc,
      this.ru,
      this.gu,
      this.ar,
      this.he,
      this.de,
      this.featureName,
      this.or,
      this.hi,
      this.kn,
      this.ml,
      this.ja,
      this.eo,
      this.pl,
      this.mr,
      this.cs,
      this.ta,
      this.pa,
      this.te});

  LocalNames.fromJson(Map<String, dynamic> json) {
    zh = json['zh'];
    uk = json['uk'];
    ascii = json['ascii'];
    ur = json['ur'];
    en = json['en'];
    oc = json['oc'];
    ru = json['ru'];
    gu = json['gu'];
    ar = json['ar'];
    he = json['he'];
    de = json['de'];
    featureName = json['feature_name'];
    or = json['or'];
    hi = json['hi'];
    kn = json['kn'];
    ml = json['ml'];
    ja = json['ja'];
    eo = json['eo'];
    pl = json['pl'];
    mr = json['mr'];
    cs = json['cs'];
    ta = json['ta'];
    pa = json['pa'];
    te = json['te'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zh'] = zh;
    data['uk'] = uk;
    data['ascii'] = ascii;
    data['ur'] = ur;
    data['en'] = en;
    data['oc'] = oc;
    data['ru'] = ru;
    data['gu'] = gu;
    data['ar'] = ar;
    data['he'] = he;
    data['de'] = de;
    data['feature_name'] = featureName;
    data['or'] = or;
    data['hi'] = hi;
    data['kn'] = kn;
    data['ml'] = ml;
    data['ja'] = ja;
    data['eo'] = eo;
    data['pl'] = pl;
    data['mr'] = mr;
    data['cs'] = cs;
    data['ta'] = ta;
    data['pa'] = pa;
    data['te'] = te;
    return data;
  }
}
