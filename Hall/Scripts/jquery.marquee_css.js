(function($){
$.fn.marquee=function(options){
var opt=$.extend({},$.fn.marquee.defaults,options);
return this.each(function(){
var l=$(this).children(),h=(opt.dir=="left"||opt.dir=="right")?true:false,s=h?"width":"height",v=0;
l.each(function(i,e){v+=$(e)[s]()});

console.log($(this));

if(v<$(this)[s]()) return;
l.clone().appendTo(this);
var f=0,t=-v,a={},e=$(">*",this),s=h?"left":"top";
if(opt.dir=="right"||opt.dir=="down") f=t,t=0;


a[s]=t;
var r,d=Math.abs(f-t)*opt.step;
(function m(v){if(r)clearTimeout(r);$(e).stop().animate(a,v||d,"linear",function(){$(e)[s](f);r=setTimeout(m,16)})})(Math.abs(e[s]-t)*opt.step);

/*
body>div>ul{animation:ma 15s linear infinite}
@keyframes ma{0%{left:0}100%{left:-100%}}
body>div>ul:hover{animation-play-state:paused}
//*/

})},
$.fn.marquee.defaults={loop:0,dir:"left",step:20},
$.fn.marquee.setDefaults=function(settings){$.extend($.fn.marquee.defaults,settings)}
})(jQuery);