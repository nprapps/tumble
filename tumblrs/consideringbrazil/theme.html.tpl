<html class="no-js">
    <head>
        <title>{Title}{block:SearchPage} ({lang:Search results for SearchQuery}){/block:SearchPage}{block:PermalinkPage}{block:PostSummary}  {PostSummary}{/block:PostSummary}{/block:PermalinkPage} : NPR</title>

        <meta charset="utf-8">
        <meta name="description" content="{block:IndexPage}{block:Description}{MetaDescription}{/block:Description}{/block:IndexPage}{block:PermalinkPage}{block:PostSummary}{PostSummary}{/block:PostSummary}{/block:PermalinkPage}" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0" />

        <meta name="font:Body" content="'Helvetica Neue', Helvetica, Arial, sans-serif"/>

        <!-- Appearance option -->
        <meta name="if:Two column posts" content="1"/>
        <meta name="if:Show blog title" content="1"/>
        <meta name="if:Show blog description" content="1"/>
        <meta name="if:Show profile photo" content="0"/>
        <meta name="if:Use endless scrolling" content="1"/>
        <meta name="if:Use larger font for quotes" content="0"/>
        <meta name="if:Show image shadows" content="1"/>
        <meta name="if:Show post notes" content="1"/>
        <meta name="if:Show copyright in footer" content="0"/>
        <meta name="text:Disqus Shortname" content="" />

        <link rel="shortcut icon" href="http://www.npr.org/favicon.ico" />
        <link rel="alternate" type="application/rss+xml" title="RSS" href="{RSS}"/>

        <!-- HTML5 Shiv -->
        <!--[if lt IE 9]>
                <script src="http://static.tumblr.com/hriofhd/Qj0m8pn7q/html5shiv.js"></script>
        <![endif]-->
        {{ static(file_path='modernizr.js') }}

        <!-- Reset CSS -->
        <link rel="stylesheet" href="http://static.tumblr.com/thpaaos/DIcklyl4z/reset.css" type="text/css">

        <!-- Project CSS -->
        {{ static(file_path='app.less.css') }}

        <!--[if lt IE 9]>
            <style type="text/css">
                #container { width: 980px; }
            </style>
        <![endif]-->


        <!-- GOOGLE ANALYTICS -->
         <script>
             (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
             (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
             m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
             })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

             ga('create', 'UA-5828686-63', 'tumblr.com');
             ga('send', 'pageview');
         </script>

        <meta name="twitter:card" content="summary">
        <meta property="og:title" content="{Title}" />
        <meta property="og:url" content="{{ copy.og_url }}" />
        <meta property="og:type" content="article" />
        <meta property="og:description" content="{{ copy.og_description }}" />
        <meta property="og:image" content="{{ copy.og_image }}" />
        <meta property="og:site_name" content="NPR.org" />
        <meta property="fb:app_id" content="138837436154588" />

    </head>
    <body class="{block:IndexPage}index-page{/block:IndexPage}{block:PermalinkPage}permalink-page{/block:PermalinkPage}">

        <div id="container" class="group container-fluid">
            <div class="row-fluid">
                <header class="span3">
                    <div id="blog_info">
                        <div class="fix-wrap">
                            <h2 class="npr"><a href="http://npr.org"><img src="http://media.npr.org/chrome/news/nprlogo_138x46.gif" alt="NPR" /></a></h2>
                            {block:IfShowBlogTitle}
                            <h1><a href="/">
                                <img class="visible-tablet visible-desktop" alt="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAANwAAABwCAMAAABCWu4mAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDowNTgwMTE3NDA3MjA2ODExOTJCMEMxMEI0OTJGMEFGNSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDoyQTYwRUI5RTBEQkQxMUUzOERGRERFM0MxRDYxNTQ0RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDoyQTYwRUI5RDBEQkQxMUUzOERGRERFM0MxRDYxNTQ0RCIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1IE1hY2ludG9zaCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkMxRDA1NjlDMzUyMDY4MTFBNUVDOERCQkI4QjgyNDNGIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjA1ODAxMTc0MDcyMDY4MTE5MkIwQzEwQjQ5MkYwQUY1Ii8+IDwvcmRmOkRlc2NyaXB0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" />
                                <img class="visible-phone" alt="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAdoAAAAyCAMAAADMWurGAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDowNTgwMTE3NDA3MjA2ODExOTJCMEMxMEI0OTJGMEFGNSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpBMDc4M0NDODBEOEUxMUUzOERGRERFM0MxRDYxNTQ0RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpBMDc4M0NDNzBEOEUxMUUzOERGRERFM0MxRDYxNTQ0RCIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1IE1hY2ludG9zaCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjA3ODAxMTc0MDcyMDY4MTFBNUVDOERCQkI4QjgyNDNGIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjA1ODAxMTc0MDcyMDY4MTE5MkIwQzEwQjQ5MkYwQUY1Ii8+IDwvcmRmOkRlc2NyaXB0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" />
                            </a></h1>
                            {/block:IfShowBlogTitle}
                            <p>{Description}</p>
                        </div>
                    </div>
                </header>

                <section id="post-wrap" class="span9">

                    {block:TagPage}<h2 class="tag-header">{Tag}</h2>{/block:TagPage}

                    <div id="posts">
                        <!-- START POSTS -->
                        {block:Posts}
                        <article class="post {TagsAsClasses}">
                            {block:Text}
                            <div class="text">
                                {block:Title}<h3>{Title}</h3>{/block:Title}
                                {Body}
                            </div>
                            {/block:Text}
                            {block:Quote}
                            <div class="quote">
                                <blockquote class="words {Length}">&#8220;{Quote}&#8221;</blockquote>
                                {block:Source}<p class="source">&mdash; {Source}</p>{/block:Source}
                            </div>
                            {/block:Quote}
                            {block:Link}
                            <div class="link">
                                <h3><a href="{URL}" {Target}>{Name} <i class="icon icon-external-link"></i></a></h3>
                                {block:Description}<div class="caption">{Description}</div>{/block:Description}
                            </div>
                            {/block:Link}
                            {block:Video}
                            <div class="video">
                                <div class="video-container">
                                    {VideoEmbed-700}
                                </div>
                                {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                            </div>
                            {/block:Video}
                            {block:Audio}
                            <div class="audio">
                                {block:AlbumArt}<img src="{AlbumArtURL}" alt="">{/block:AlbumArt}
                                {AudioPlayerGrey}
                                {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                            </div>
                            {/block:Audio}
                            {block:Photo}
                            <div class="photo">
                                    {LinkOpenTag}<img src="{PhotoURL-HighRes}" alt="{PhotoAlt}"/>{LinkCloseTag}
                                    {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                            </div>
                            {/block:Photo}

                            {block:Photoset}
                            <div class="photoset">
                                <div class="photoset-500">{Photoset-500}</div>
                                <div class="photoset-250">{Photoset-250}</div>
                                {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                            </div>
                            {/block:Photoset}

                            {block:Panorama}
                            <div class="panorama">
                                {LinkOpenTag}<img src="{PhotoURL-Panorama}" alt="{PhotoAlt}" />{LinkCloseTag}
                                {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                            </div>
                            {/block:Panorama}

                            {block:Chat}
                            <div class="chat">
                                {block:Title}<h3>{Title}</h3>{/block:Title}
                                <ul class="conversation">
                                    {block:Lines}
                                    <li class="line {Alt}">
                                        {block:Label}<span class="person">{Label}</span>{/block:Label}
                                        <span class="person-said">{Line}</span>
                                    </li>
                                    {/block:Lines}
                                </ul>
                            </div>
                            {/block:Chat}

                            {block:Answer}
                            <div class="answer">
                                <div class="qa-asker">
                                    <img src="{AskerPortraitURL-40}">
                                    {Asker} asks:
                                </div>
                                <div class="qa-question">{Question}</div>
                                <div class="qa-response">{Answer}</div>
                            </div>
                            {/block:Answer}

                            <div class="post-meta">

                            {block:IndexPage}
                                <p class="pubdate"><a href="{Permalink}" class="permalink">{block:Date}{Month} {DayOfMonth}, {Year}{/block:Date}</a></p>
                                <p class="note-count"><a href="{Permalink}" class="permalink"><i class="icon icon-comment"></i> {NoteCountWithLabel}</a></p>
                            {/block:IndexPage}
                            {block:PermalinkPage}
                                <p class="pubdate">{block:Date}{Month} {DayOfMonth}, {Year}{/block:Date}</p>
                            {/block:PermalinkPage}

                            {block:HasTags}
                                <div class="tags">
                                    {block:Tags}<a href="{TagURL}" class="tag">{Tag}<span class="triangle"></span></a>{/block:Tags}
                                </div>
                            {/block:HasTags}

                            </div>

                            <!--
                            <ul class="unstyled sharing-tools">
                                <li><a rel="external" href="http://twitter.com/share?text=Read this post from &ldquo;{Title}&rdquo;%3a&amp;url={Permalink}" alt="Share on Twitter" target="_blank" onclick="_gaq.push(['_trackEvent', 'Social', 'Click Twitter In Post', '{Title}']);" title="Share This Page On Twitter"><i class="icon icon-twitter"></i></a></li>
                                <li><a rel="external" href="https://www.facebook.com/dialog/feed?app_id=138837436154588&amp;link={Permalink}&picture={PhotoURL-HighRes}&name={Title}&redirect_uri={Permalink}" alt="Share on Facebook" target="_blank" onclick="_gaq.push(['_trackEvent', 'Social', 'Click Facebook In Post', 'Read this post from &ldquo;{Title}&rdquo;']);" title="Like This Page On Facebook"><i class="icon icon-facebook-sign"></i></a></li>
                            </ul>
                            -->

                            {block:PermalinkPage}
                            {block:PostNotes}
                                <div class="post-notes">
                                    <h3>Notes</h3>
                                    {PostNotes}
                                </div>
                            {/block:PostNotes}
                            {/block:PermalinkPage}
                        </article>
                        {/block:Posts}
                        <!-- END POSTS -->
                    </div>


                    <footer id="footer">
                        {block:PermalinkPage}
                            <nav class="pagination-index">
                                <a href="/">See More Posts <i class="icon icon-chevron-sign-right"></i></a>
                            </nav>
                        {/block:PermalinkPage}

                        {block:Pagination}
                            <nav class="pagination">
                                <section class="buttons">
                                    {block:PreviousPage}<a href="{PreviousPage}" class="left">{lang:Previous page}<span class="arrow"></span></a>{/block:PreviousPage}
                                    {block:NextPage}<a href="{NextPage}" class="right">{lang:Next page}<span class="arrow"></span></a>{block:NextPage}
                                </section>
                                <section class="disabled buttons">
                                    <li class="left"><span class="arrow"></span></li>
                                    <li class="right"><span class="arrow"></span></li>
                                </section>
                                <section class="count">Page  {CurrentPage} / {TotalPages}</section>
                            </nav>
                        {/block:Pagination}
                    </footer>
                </section> <!-- #post-wrap -->
            </div>
        </div> <!-- #container -->


        <script type="text/javascript" src="http://assets.tumblr.com/javascript/jquery-1.7.2.min.js"></script>
        {{ static(file_path='app.js') }}
        {{ static(file_path='jquery.fitvids.js') }}

        {block:IfUseEndlessScrolling}
        <script type="text/javascript">
            var Tumblelog = {};

            // AJAX
            Tumblelog.Ajax = (function(url, callbackFunction) {
                this.bindFunction = function (caller, object) {
                    return function() {
                        return caller.apply(object, [object]);
                    };
                };

                this.stateChange = function (object) {
                    if (this.request.readyState==4) {
                        this.callbackFunction(this.request.responseText);
                    }
                };

                this.getRequest = function() {
                    if (window.ActiveXObject)
                        return new ActiveXObject('Microsoft.XMLHTTP');
                    else if (window.XMLHttpRequest)
                        return new XMLHttpRequest();
                    return false;
                };

                this.postBody = (arguments[2] || "");
                this.callbackFunction=callbackFunction;
                this.url=url;
                this.request = this.getRequest();

                if(this.request) {
                    var req = this.request;
                    req.onreadystatechange = this.bindFunction(this.stateChange, this);

                    if (this.postBody!=="") {
                        req.open("POST", url, true);
                        req.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                        req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                        req.setRequestHeader('Connection', 'close');
                    } else {
                        req.open("GET", url, true);
                    }

                    req.send(this.postBody);
                }
            });

            // Infinite Scroll
            Tumblelog.Infinite = (function() {

                var _$window          = $(window);
                var _$posts           = $('#posts');
                var _trigger_post     = null;

                var _current_page     = {CurrentPage};
                var _total_pages      = {TotalPages};
                var _url              = document.location.href;
                var _infinite_timeout = null;
                var _is_loading       = false;
                var _posts_loaded     = false;

                var _Ajax = Tumblelog.Ajax;

                function init() {
                    set_trigger();
                    enable_scroll();
                }

                function set_trigger () {
                    var $all_posts = _$posts.find('article.post');

                    if (!_posts_loaded) {
                        _posts_loaded = $all_posts.length;
                    }

                    if (_posts_loaded >= 4) {
                        _trigger_post = _$posts.find('article.post:eq(' + ($all_posts.length - 4) + ')').get(0);
                    } else if (_posts_loaded >= 3) {
                        _trigger_post = _$posts.find('article.post:eq(' + ($all_posts.length - 3) + ')').get(0);
                    } else {
                        _trigger_post = _$posts.find('article.post:last').get(0);
                    }

                };

                function in_viewport (el) {
                    if (el == null) return;
                    var top = el.offsetTop;
                    var height = el.offsetHeight;

                    while (el.offsetParent) {
                        el = el.offsetParent;
                        top += el.offsetTop;
                    }

                    return (top < (window.pageYOffset + window.innerHeight));
                };

                function enable_scroll() {
                    $('#footer .pagination').hide();
                    _$window.scroll(function(){
                        clearTimeout(_infinite_timeout);
                        infinite_timeout = setTimeout(infinite_scroll, 100);
                    });
                }

                function disable_scroll() {
                    clearTimeout(_infinite_timeout);
                    $(window).unbind('scroll');
                }

                function infinite_scroll() {
                    if (_is_loading) return;

                    if (in_viewport(_trigger_post)) {
                        load_more_posts(); // w00t
                    }
                };

                function load_more_posts() {
                    if (_is_loading) return;
                    _is_loading = true;

                    // Build URL
                    if (_url.charAt(_url.length - 1) != '/') _url += '/';
                    if (_current_page === 1) _url += 'page/1';
                    _current_page++;
                    _url = _url.replace('page/' + (_current_page - 1), 'page/' + _current_page);

                    // Fetch
                    _Ajax(_url, function(data) {
                        var new_posts_html = data.split('<!-- START' + ' POSTS -->')[1].split('<!-- END' + ' POSTS -->')[0];
                        var $new_posts = $('#posts', data);

                        // Insert posts and update counters
                        $('#posts').append(new_posts_html);
                        sizeVideoContainers();

                        _posts_loaded = $new_posts.find('article.post').length;

                        if ((_posts_loaded > 0) && (_current_page < _total_pages)) {
                            set_trigger();
                            _is_loading = false;
                        } else {
                            disable_scroll();
                        }
                    });

                    // Stats
                    {block:IfGoogleAnalyticsID}
                        if (typeof window._gaq != 'undefined') {
                            _gaq.push(['_trackPageview', _url]);
                        }
                    {/block:IfGoogleAnalyticsID}
                }

                return {
                    init: init
                };
            });

            $(function() {
                {block:IndexPage}
                if ( !($.browser.msie && (parseInt($.browser.version, 10) < 9) ) ) {
                    var InfiniteScroll = new Tumblelog.Infinite;
                    InfiniteScroll.init();
                }
                {/block:IndexPage}
            });
        </script>
        {/block:IfUseEndlessScrolling}

        <!-- CHARTBEAT -->
        <script type="text/javascript">
            var _sf_async_config={};
            /** CONFIGURATION START **/
            _sf_async_config.uid = 18888;
            _sf_async_config.domain = "npr.org";
            /** CONFIGURATION END **/
            (function(){
                function loadChartbeat() {
                    window._sf_endpt=(new Date()).getTime();
                    var e = document.createElement("script");
                    e.setAttribute("language", "javascript");
                    e.setAttribute("type", "text/javascript");
                    e.setAttribute("src",
                        (("https:" == document.location.protocol) ?
                         "https://a248.e.akamai.net/chartbeat.download.akamai.com/102508/" :
                         "http://static.chartbeat.com/") +
                        "js/chartbeat.js");
                    document.body.appendChild(e);
                }
                var oldonload = window.onload;
                window.onload = (typeof window.onload != "function") ?
                    loadChartbeat : function() { oldonload(); loadChartbeat(); };
            })();
        </script>


        {block:IfUseEndlessScrolling}<script type="text/javascript" src="http://assets.tumblr.com/javascript/tumblelog.js"></script>{/block:IfUseEndlessScrolling}
    </body>
</html>