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

        <!-- Font loader -->
        <script src="//ajax.googleapis.com/ajax/libs/webfont/1.4.10/webfont.js"></script>
        <script>
            WebFont.load({
                 custom: {
                     families: [
                         'Gotham SSm:n4,n7'
                     ],
                     urls: [
                         'http://s.npr.org/templates/css/fonts/GothamSSm.css'
                     ]
                 },
                 timeout: 10000
             });
        </script>

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
        <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png" />
        <meta property="og:site_name" content="NPR.org" />
        <meta property="fb:app_id" content="138837436154588" />

    </head>
    <body class="{block:IndexPage}index-page{/block:IndexPage}{block:PermalinkPage}permalink-page post{PostID}{/block:PermalinkPage}">

        <div id="container" class="group container-fluid">
            <div class="row-fluid">
                <header class="span3">
                    <div id="blog_info">
                        <div class="fix-wrap">
                            <h2 class="npr"><a href="http://npr.org"><img src="http://media.npr.org/chrome/news/nprlogo_138x46.gif" alt="NPR" /></a></h2>
                            {block:IfShowBlogTitle}
                            <h1><a href="/">
                                {{ static(file_path='header-lg.svg', classes='visible-tablet visible-desktop') }}
                                {{ static(file_path='header.svg', classes='visible-phone') }}
                            </a></h1>
                            {/block:IfShowBlogTitle}
                            <p>{Description}</p>
                            {block:HasPages} 
                            <ul class="list-unstyled pages">
                                {block:Pages} 
                                <li><a href="{URL}" title="{Label}">{Label}</a></li>
                                {/block:Pages}

                                {block:SubmissionsEnabled} 
                                <li class="submit"><a href="/submit">{SubmitLabel}</a></li>
                                {/block:SubmissionsEnabled}

                                {block:AskEnabled}
                                <li class="ask"><a href="/ask">{AskLabel}</a></li>
                                {/block:AskEnabled}
                            </ul>
                            {/block:HasPages}
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
                                    {Video-700}
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


        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
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
                        $('#posts').append('<div class="page' + _current_page + '">' + new_posts_html + '</div>');
                        sizeVideoContainers('.page' + _current_page);

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