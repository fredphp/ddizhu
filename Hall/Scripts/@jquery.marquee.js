(function($){
$.fn.marquee=function(options){
var opt=$.extend({},$.fn.marquee.defaults,options);
return this.each(function(){
var obj=$(this).get(0),scw=$(this).width(),sch=$(this).height(),$el=$(this).children(),$cs=$el.children(),scs=0,_hv=(opt.dir=="left"||opt.dir=="right")?1:0;
if(_hv) $el.css("white-space","nowrap");
if(opt.isEqual) scs=$cs[_hv?"outerWidth":"outerHeight"]()*$cs.length;else $cs.each(function(){scs+=$(this)[_hv?"outerWidth":"outerHeight"]()});
if(scs<(_hv?scw:sch)) return;
$el.append($cs.clone());
var pause,num=0,aid=0;

var last=0;
if(!window.requestAnimationFrame){window.requestAnimationFrame=function(c){var curr=new Date().getTime();var time=Math.max(0,16-(curr-last));return window.setTimeout(function(){c(last=curr+time)},time)};window.cancelAnimationFrame=clearTimeout}

function scroll(){if(!pause){var dir=(opt.dir=="left"||opt.dir=="right")?"scrollLeft":"scrollTop";if(opt.loop>0){num+=opt.step;if(num>scs*opt.loop){obj[dir]=0;return pause=true}}if(opt.dir=="left"||opt.dir=="up"){var pos1=obj[dir]+opt.step;if(pos1>=scs) pos1-=scs;obj[dir]=pos1}else{var pos2=obj[dir]-opt.step;if(pos2<=0) pos2+=scs;obj[dir]=pos2}}aid=requestAnimationFrame(scroll);try{window.cancelAnimationFrame(aid-1)}catch(e){}}

$(this).ready(function(){aid=requestAnimationFrame(scroll)}).hover(function(){pause=true},function(){pause=false});
})},
$.fn.marquee.defaults={isEqual:true,loop:0,dir:"left",step:1},
$.fn.marquee.setDefaults=function(settings){$.extend($.fn.marquee.defaults,settings)}
})(jQuery);