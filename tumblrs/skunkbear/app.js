$(function() {
	var $_window = $(window);
	var $_document = $(document);
	var $video_containers = $('.video-container');

	sizeVideoContainers = function(){
		var $video_iframe = $(document).find('.tumblr_video_iframe, .video-container img');

		$video_iframe.each(function(){
			var $this = $(this);
			var height = parseInt($this.attr('height'));
			var width = parseInt($this.attr('width'));

			if (height > width){
				$this.parents('.video-container').addClass('nine-by-sixteen');
				$this.parents('.video-wrapper').addClass('vertical');
			} else if (height == width) {
				$this.parents('.video-container').addClass('square');
			} else {
				$this.parents('.video-container').addClass('sixteen-by-nine');
			}
		});
	}

	$video_containers.fitVids({ customSelector: "video"});

	$_window.on('resize', function(){
		$vine_embeds = $_document.find('iframe.vine-embed');
		$vine_embeds.each(function(){
			var vid_src = $(this).attr('src');
			$(this).attr('src', vid_src);
		});
	});

	sizeVideoContainers();

});