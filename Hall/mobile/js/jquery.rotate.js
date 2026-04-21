(function($){
  function I(e){
    var d=e.data("_ARS_data");
    if(!d){
      d={unit:"deg",scale:1,rotate:0,ox:e.outerWidth()/2,oy:e.outerHeight()/2};
      e.data("_ARS_data",d);
      if(!e.style[R[e.get(0)]]) e.css({filter:"progid:DXImageTransform.Microsoft.Matrix(M11=1.0,M12=0.0,M21=0.0,M22=1.0,Dx=0,Dy=0)"});
    }
    return d;
  }
  function T(e,d){
    e.css("transform","rotate("+d.rotate+d.unit+") scale("+d.scale+","+d.scale+")");
    if(R[e.get(0)]&&!e.style[R[e.get(0)]]){
      var r=d.rotate*Math.PI/180,c=Math.cos(r)*d.scale,s=Math.sin(r)*d.scale;
      var m=e.get(0).filters["DXImageTransform.Microsoft.Matrix"];
      m.M11=c,m.M12=-s,m.M21=s,m.M22=c,m.Dx=-d.ox*c+d.oy*s+d.ox,m.Dy=-d.ox*s-d.oy*c+d.oy;
    }
  }
  function R(e){
		var t,a=['transform','WebkitTransform','msTransform','MozTransform','OTransform'];
		while(t=a.shift()) if(e.style[t]!=undefined) return t;
		return 'transform';
	}
	var n='transform',o=null,s=$.fn.css;
	$.fn.css=function(a,v){
	  o=o||$.cssProps||$.props||{};
		if(!o[n]&&(a==n||a&&a[n])) o[n]=R(this.get(0));
		if(o[n]!=n){
			if(a==n){
				a=o[n];
				if(!v&&$.style) return $.style(this.get(0),a);
			}else if(a&&a[n]){
				a[o[n]]=a[n];
				delete a[n];
			}
		}
		return s.apply(this,arguments);
	};
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
  $.fx.prototype.cur=function(){return this.prop=='rotate'?parseFloat($(this.elem).rotate()):this.prop=='scale'?parseFloat($(this.elem).scale()):c.apply(this,arguments)};
  $.fx.step.rotate=function(x){$(x.elem).rotate(x.now+I($(x.elem)).unit)};
  $.fx.step.scale=function(x){$(x.elem).scale(x.now)};
  var a=$.fn.animate;
  $.fn.animate=function(p){
    if(p['rotate']){
      var d,m=p['rotate'].toString().match(/^(([+-]=)?(-?\d+(\.\d+)?))(.+)?$/);
      if(m&&m[5]) d=I($(this)),d.unit=m[5];
      p['rotate']=m[1];
    }
    return a.apply(this,arguments);
  };
})(jQuery);