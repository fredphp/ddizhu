function JSONWebService(webServiceURL,parameters,callback){
    $.ajax({
      data:parameters,
      url: webServiceURL,
      type: "POST",
      contentType: "application/json;utf-8",
      dataType:'json',
      cache: false,
      success: function(json){
          callback(json.d);
      }
    });
}



JQueryExtend={
    EvalJSON:function(strJson){
        return eval( "(" + strJson + ")");
    }
}


