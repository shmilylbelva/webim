layui.define('jquery', function (exports) {
	"use strict";
	var $ = layui.jquery;
!function(t,n,e,i){var o=function(t,n){this.init(t,n)};o.prototype={init:function(t,n){this.ele=t,this.defaults={menu:[{text:"菜单一",callback:function(t){}}],target:function(t){},width:140,itemHeight:30,bgColor:"#fff",color:"#333",fontSize:15,hoverBgColor:"#009bdd",hoverColor:"#fff"},this.opts=e.extend(!0,{},this.defaults,n),this.random=(new Date).getTime()+parseInt(1e3*Math.random()),this.eventBind()},renderMenu:function(){$(".ul-context-menu").remove();var t=this,n="#uiContextMenu_"+this.random;if(!(e(n).length>0)){var t=this,i='<ul class="ul-context-menu '+this.opts.contextItem+'" id="uiContextMenu_'+this.random+'">';e.each(this.opts.menu,function(t,n){
						n.nav ? (
						n.icon ? i += '<li class="ui-context-menu-item '+n.nav+'"><a href="javascript:void(0);"><i class="layui-icon">' + n.icon + '</i><span style="margin-left: 10px;">' + n.text + '</span><i class="layui-icon" style="float:right">' + n.navIcon + "</i></a>"+n.navBody+"</li>" 
						: i += '<li class="ui-context-menu-item '+n.nav+'"><a href="javascript:void(0);"><span>' + n.text + '</span><i class="layui-icon" style="float:right">' + n.navIcon + "</i></a>"+n.navBody+"</li>"
							):(
						n.icon ? i += '<li class="ui-context-menu-item"><a href="javascript:void(0);"><i class="layui-icon">' + n.icon + '</i><span style="margin-left: 10px;">' + n.text + "</span></a></li>" 
						: i += '<li class="ui-context-menu-item"><a href="javascript:void(0);"><span>' + n.text + "</span></a></li>"
							)
}),i+="</ul>",e("body").append(i).find(".ul-context-menu").hide(),this.initStyle(n),e(n).on("click",".ui-context-menu-item",function(n){t.menuItemClick(e(this)),n.stopPropagation()})}},initStyle:function(t){var n=this.opts;e(t).css({width:n.width,backgroundColor:n.bgColor}).find(".ui-context-menu-item a").css({color:n.color,fontSize:n.fontSize,height:n.itemHeight,lineHeight:n.itemHeight+"px"}).hover(function(){e(this).css({backgroundColor:n.hoverBgColor,color:n.hoverColor})},function(){e(this).css({backgroundColor:n.bgColor,color:n.color})})},menuItemClick:function(t){var n=this,e=t.index();t.parent(".ul-context-menu").hide(),n.opts.menu[e].callback&&"function"==typeof n.opts.menu[e].callback&&n.opts.menu[e].callback(t)},setPosition:function(t){var n = this.opts;var obj_h = n.menu.length * n.itemHeight + 12;var obj_w = n.width;var max_x = $(window).width();var max_y = $(window).height();var this_x = t.clientX ;var this_y = t.clientY ;var x = t.clientX+4;var y = t.clientY+4;if (max_x-this_x < (obj_w-4)) {x = max_x -obj_w;}if (max_y-this_y < (obj_h-4)) {y = max_y -obj_h;}e("#uiContextMenu_"+this.random).css({left:x,top:y }).show();

},eventBind:function(){var t=this;this.ele.on("contextmenu",function(n){n.preventDefault(),t.renderMenu(),t.setPosition(n),t.opts.target&&"function"==typeof t.opts.target&&t.opts.target(e(this))}),e(n).on("click",function(){e(".ul-context-menu").hide()})}},e.fn.contextMenu=function(t){return new o(this,t),this}}(window,document,$);
exports('contextMenu');
});
