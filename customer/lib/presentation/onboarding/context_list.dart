class ContextList {
  const ContextList({this.text,this.message});
  final String? text;
  final String? message;
}

List<ContextList> documentListModel = <ContextList>[
  const ContextList(text:'Your Acoride information & content',message: "Acoride collects personal information that you share with us, such as your name, e-mail, phone number, registered favorite places and photo that you upload to Acoride.  Acoride uses this information to identify you, find you, connect you to an approved payment system, get in touch with you, pair you with a driver, and improve your user experience.",),
  const ContextList(text:'Location Access ',message: "Acoride collects location data to enable system search for driver within your location.",),
];
