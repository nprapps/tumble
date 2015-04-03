$(function() {
	var $_window = $(window);
	var $_document = $(document);
	var $video_containers = $('.video-container');

	var sizeVideoContainers = function(element){
		var scope = element||document;
		var $video_iframe = $(scope).find('.tumblr_video_iframe, .video-container img');

		$video_iframe.each(function(){
			var $this = $(this);

			// Don't recalculate if we've already assigned an aspect ratio
			if ($this.parents('.video-container').hasClass('nine-by-sixteen vertical square sixteen-by-nine')){
				return;
			}

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

			$this.parent().attr('style', '');
		});
	}

	var fixPhotosetWidths = function(element){
		var scope = element||document;
		var $photosets = $(scope).find('iframe.photoset');

		$photosets.each(function(){
			$(this).attr('width', $(this).parent().width());
		});
	}

	$video_containers.fitVids({ customSelector: "video"});

	$_window.on('resize', function(){
		$vine_embeds = $_document.find('iframe.vine-embed');
		$vine_embeds.each(function(){
			var vid_src = $(this).attr('src');
			$(this).attr('src', vid_src);
		});

		fixPhotosetWidths();
	});

	sizeVideoContainers();
	fixPhotosetWidths();

});