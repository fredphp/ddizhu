(function($){
	function T(e){
		var p,a=['transform','WebkitTransform','msTransform','MozTransform','OTransform'];
		while(p=a.shift()) if(e.style[p]) return p;
		return 'transform';
	}
	var o=null,p=$.fn.css;
	$.fn.css=function(a,v){
		if(o===null){
			if($.cssProps) o=$.cssProps;
			else if($.props) o=$.props;
			else o={}
		}
		if(o['transform']){}else if((a=='transform'||(a&&a['transform']))) o['transform']=T(this.get(0));
		if(o['transform']!='transform'){
			if(a=='transform'){
				a=o['transform'];
				if(v){}else if($.style) return $.style(this.get(0),a);
			}else if(a&&a['transform']){
				a[o['transform']]=a['transform'];
				delete a['transform'];
			}
		}
		return p.apply(this,arguments);
	};
})(jQuery);