(function($){
$.fn.marquee=function(options){
var opt=$.extend({},$.fn.marquee.defaults,options);
return this.each(function(){
var l=$(this).children(),h=(opt.dir=="left"||opt.dir=="right")?1:0,s=h?l.get(0).scrollWidth:l.get(0).scrollHeight;
if(s<(h?$(this).width():$(this).height())) return;
l.append(l.children().clone());
var c=1/20,f=0,t=s,a={},e=this,s=h?"scrollLeft":"scrollTop";
if(opt.dir=="right"||opt.dir=="down") f=t,t=0;
a[s]=t;
var r,d=Math.abs(f-t)/c*opt.step;
function m(v){if(r)clearTimeout(r);$(e).stop().animate(a,v||d,"linear",function(){$(e)[s](f);r=setTimeout(m,16)})};
$(this).ready(function(){m(Math.abs(e[s]-t)/c*opt.step)}).hover(function(){$(e).stop()},function(){m(Math.abs(e[s]-t)/c*opt.step)});
})},
$.fn.marquee.defaults={loop:0,dir:"left",step:1},
$.fn.marquee.setDefaults=function(settings){$.extend($.fn.marquee.defaults,settings)}
})(jQuery);
