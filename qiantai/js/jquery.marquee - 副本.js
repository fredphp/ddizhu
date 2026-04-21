(function($){
$.fn.marquee=function(options){
var opt=$.extend({},$.fn.marquee.defaults,options);
return this.each(function(){
var l=$(this).children(),h=(opt.dir=="left"||opt.dir=="right")?true:false,s=h?"width":"height",v=0;
l.each(function(i,e){v+=$(e)[s]()});
if(v<$(this)[s]()) return;
l.clone().appendTo(this);
var f=0,t=v,a={},e=this,s=h?"scrollLeft":"scrollTop";
if(opt.dir=="right"||opt.dir=="down") f=t,t=0;
a[s]=t;
var r,d=Math.abs(f-t)*opt.step;
(function m(v){$(e).stop().animate(a,v||d,"linear",function(){$(e)[s](f);r=setTimeout(m,16)})})(Math.abs(e[s]-t)*opt.step)
})},
$.fn.marquee.defaults={loop:0,dir:"left",step:20},
$.fn.marquee.setDefaults=function(settings){$.extend($.fn.marquee.defaults,settings)}
})(jQuery);