$('.statusFlag').children().andSelf().contents().each(
	function () {
	console.log('records');
	if (this.nodeType == 3) {
		$(this).replaceWith(function () {
				var t='';
				var flags=parseInt($(this).text());	
				if ((flags & 1) == 1)	{
						t = t + '<span class="flagSystem">u</span>';
				};		
				if ((flags & 2) == 2)	{
						t = t + '<span class="flagBegin">u</span>';
				};	
				if ((flags & 4) == 4)	{
						t = t + '<span class="flagDefault">u</span>';
				};	
				return t;	
			}
		)
	};
}
);