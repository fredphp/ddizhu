(function($){
  function I(e){
    var d=e.data("_ARS_data");
    if(!d){
      d={unit:"deg",scale:1,rotate:0,ox:e.outerWidth()/2,oy:e.outerHeight()/2};
      e.data("_ARS_data",d);
      if(Modernizr&&!Modernizr.csstransforms) e.css({filter:"progid:DXImageTransform.Microsoft.Matrix(M11=1.0,M12=0.0,M21=0.0,M22=1.0,Dx=0,Dy=0)"});
    }
    return d;
  }

  function T(e,d){
    e.css("transform","rotate("+d.rotate+d.unit+") scale("+d.scale+","+d.scale+")");
    if(Modernizr&&!Modernizr.csstransforms){
      var r=d.rotate*Math.PI/180,c=Math.cos(r)*d.scale,s=Math.sin(r)*d.scale;
      var m=e.get(0).filters["DXImageTransform.Microsoft.Matrix"];
      m.M11=c,m.M12=-s,m.M21=s,m.M22=c,m.Dx=-d.ox*c+d.oy*s+d.ox,m.Dy=-d.ox*s-d.oy*c+d.oy;
    }
  }

  $.fn.rotate=function(v){
    var o=$(this),d=I(o);
    if(v){
      var m=v.toString().match(/^(-?\d+(\.\d+)?)(.+)?$/);
      if(m){
        if(m[3]) d.unit=m[3];
        d.rotate=m[1];
        T(o,d);
      }
      return this;
    }
    return d.rotate+d.unit;
  };

  $.fn.scale=function(v){
    var o=$(this),d=I(o);
    if(v){
      d.scale=v;
      T(o,d);
      return this;
    }
    return d.scale;
  };

  var c=$.fx.prototype.cur;
  $.fx.prototype.cur=function(){
    if(this.prop=='rotate') return parseFloat($(this.elem).rotate());
    else if(this.prop=='scale') return parseFloat($(this.elem).scale());
    return c.apply(this,arguments);
  };

  $.fx.step.rotate=function(x){
    var d=I($(x.elem));
    $(x.elem).rotate(x.now+d.unit);
  };

  $.fx.step.scale=function(x){$(x.elem).scale(x.now)};

  var a=$.fn.animate;
  $.fn.animate=function(p){
    if(p['rotate']){
      var s,d,m=p['rotate'].toString().match(/^(([+-]=)?(-?\d+(\.\d+)?))(.+)?$/);
      if(m&&m[5]){
        s=$(this);
        d=I(s);
        d.unit=m[5];
      }
      p['rotate']=m[1];
    }
    return a.apply(this,arguments);
  };
})(jQuery);