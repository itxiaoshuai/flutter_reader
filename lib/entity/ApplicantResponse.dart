class ApplicantResponse {
  /**
   * id : 26
   * corpid : 26
   * name : 科技哦哦哦
   * corpname : 科技哦哦哦
   * linkman : 科技
   * phone : 13148809784
   * mobile : 13148808584
   * email : 1175088986@qq.com
   * verify_email : 0
   * verify_email_name : 未验证
   * province : 辽宁省
   * city : 沈阳市
   * area : 和平区
   * address : 网易
   * status_name : 待审核
   */

  String keyword; //申请词
  String productid; //产品id
  String product_name; //产品名称
  String feetype; //服务类型， Z :注册, X：续费
  String year; //年限
  String price; //单价
  String total; //总价



  Map toJson() => {
    "productid": productid,
    "product_name": product_name,
    "keyword": keyword,
    "year": year,
    "price": price,
    "total": total,

  };
  ApplicantResponse({
    this.productid,
    this.product_name,
    this.keyword,
    this.year,
    this.price,
    this.total,
  });
}
