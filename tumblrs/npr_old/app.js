var $_window = $(window);
var $_document = $(document);
var $video_containers = null;

var sizeVideoContainers = function(element) {
    var scope = element || document;
    var $video_iframe = $(scope).find('.tumblr_video_iframe, .video-container img, .text-wrapper .tmblr-embed.tmblr-full iframe');

    $video_iframe.each(function() {
        var $this = $(this);

        // Don't recalculate if we've already assigned an aspect ratio
        if ($this.parents('.video-container, .tmblr-embed.tumblr-full').hasClass('nine-by-sixteen vertical square sixteen-by-nine')) {
            return;
        }

        var height = parseInt($this.attr('height'));
        var width = parseInt($this.attr('width'));
        console.log($this);
        console.log(height);
        console.log(width);
        console.log('------');

        if (height > width) {
            $this.parents('.video-container, .tmblr-embed.tumblr-full').addClass('nine-by-sixteen');
            $this.parents('.video-wrapper, .tmblr-embed.tumblr-full').addClass('vertical');
        } else if (height == width) {
            $this.parents('.video-container, .tmblr-embed.tumblr-full').addClass('square');
        } else {
            $this.parents('.video-container, .tmblr-embed.tumblr-full').addClass('sixteen-by-nine');
        }

        $this.parent().attr('style', '');
    });
}

var fixPhotosetWidths = function(element) {
    var scope = element || document;
    var $photosets = $(scope).find('iframe.photoset');

    $photosets.each(function() {
        $(this).attr('width', $(this).parent().width());
    });
}

$(function() {
    $video_containers = $('.video-container, .tmblr-embed.tmblr-full');

    $_window.on('resize', function() {
        $vine_embeds = $_document.find('iframe.vine-embed');
        $vine_embeds.each(function() {
            var vid_src = $(this).attr('src');
            $(this).attr('src', vid_src);
        });

        fixPhotosetWidths();
    });

    sizeVideoContainers();
    $video_containers.fitVids({ customSelector: 'video'});
    fixPhotosetWidths();


    var colors = new Array(
        [249,126,80],
        [249,116,80],
        [240,91,78],
        [206,66,66],
        [183,55,89],
        [147,50,86],
        [123,44,98],
        [101,50,121],
        [82,65,137],
        [87,86,165],
        [65,106,184],
        [65,91,184]
    );

    var step = 0;
    var colorIndices = [0,1,2,3];
    var gradientSpeed = 0.004;

    function updateGradient() {
        var c0_0 = colors[colorIndices[0]];
        var c0_1 = colors[colorIndices[1]];
        var c1_0 = colors[colorIndices[2]];
        var c1_1 = colors[colorIndices[3]];

        var istep = 1 - step;
        var r1 = Math.round(istep * c0_0[0] + step * c0_1[0]);
        var g1 = Math.round(istep * c0_0[1] + step * c0_1[1]);
        var b1 = Math.round(istep * c0_0[2] + step * c0_1[2]);
        var color1 = "rgb("+r1+","+g1+","+b1+")";

        var r2 = Math.round(istep * c1_0[0] + step * c1_1[0]);
        var g2 = Math.round(istep * c1_0[1] + step * c1_1[1]);
        var b2 = Math.round(istep * c1_0[2] + step * c1_1[2]);
        var color2 = "rgb("+r2+","+g2+","+b2+")";

         $('.blog-header').css({
            background: "-webkit-gradient(linear, left top, right top, from("+color1+"), to("+color2+"))"}).css({
            background: "-moz-linear-gradient(left, "+color1+" 0%, "+color2+" 100%)"
        });

        step += gradientSpeed;
        if ( step >= 1 ) {
            step %= 1;
            colorIndices[0] = colorIndices[1];
            colorIndices[2] = colorIndices[3];

            //pick two new target color indices
            //do not pick the same as the current one
            colorIndices[1] = ( colorIndices[1] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;
            colorIndices[3] = ( colorIndices[3] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;

          }
    }

    // setInterval(updateGradient,10);
});