<!DOCTYPE html>
<html class="no-js">
    <head>
        <title>{Title}{block:SearchPage} ({lang:Search results for SearchQuery}){/block:SearchPage}{block:PermalinkPage}{block:PostSummary}  {PostSummary}{/block:PostSummary}{/block:PermalinkPage} : NPR</title>

        <meta charset="utf-8">
        <meta name="description" content="{block:IndexPage}{block:Description}{MetaDescription}{/block:Description}{/block:IndexPage}{block:PermalinkPage}{block:PostSummary}{PostSummary}{/block:PostSummary}{/block:PermalinkPage}" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0" />

        <meta name="google-site-verification" content="iihv-RXkz1bDb-QKTITQm_p77vy7yNdIO9BUZsvAU2A" />
        <meta name="google-site-verification" content="244PFHlcVC8LNFl_V3wRuaGc0ifMOmT-hznl0xEk0bw" />

        <meta name="font:Body" content="'Helvetica Neue', Helvetica, Arial, sans-serif"/>
        <meta name="image:Background" content="{HeaderImage}">
        <meta name="color:Heading text" content="{TitleColor}">
        <meta name="color:Background" content="{AccentColor}">

        <!-- Appearance option -->
        <meta name="if:Use black NPR logo" content="0"/>
        <meta name="if:Show copyright in footer" content="0"/>

        <link rel="shortcut icon" href="http://www.npr.org/favicon.ico" />
        <link rel="alternate" type="application/rss+xml" title="RSS" href="{RSS}"/>

        <!-- Font loader -->
        <script src="//ajax.googleapis.com/ajax/libs/webfont/1.4.10/webfont.js"></script>
        <script>
            WebFont.load({
                 custom: {
                     families: [
                         'Gotham SSm:n4,n7',
                         // 'Gotham:n4,n7',
                         'Knockout 31 4r:n4'
                     ],
                     urls: [
                         'http://s.npr.org/templates/css/fonts/GothamSSm.css',
                         // 'http://s.npr.org/templates/css/fonts/Gotham.css',
                         'http://s.npr.org/templates/css/fonts/Knockout.css'
                     ]
                 },
                 timeout: 10000
             });
        </script>

        {{ static(file_path='modernizr.js') }}

        <!-- Project CSS -->
        {{ static(file_path='app.less.css') }}

        <style>
            .blog-header {
                background-image: url('{image:Background}');
            }

            .blog-header h3 a {
                background-color: {color:Background};
                color: {color:Heading text};
            }
            .fixed-nav h1 a {
                color: {color:Heading text};
            }
            .fixed-nav {
                background-color: {color:Background};
            }

        </style>
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
        <meta property="og:site_name" content="NPR.org" />
        <meta property="fb:app_id" content="138837436154588" />
        <meta property="og:description" content="{{ copy.og_description }}" />

        {block:IndexPage}
        <meta property="og:title" content="{Title}" />
        <meta property="og:url" content="{{ copy.og_url }}" />
        <meta property="og:type" content="blog" />
        <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png" />
        {/block:IndexPage}

        {block:PostSummary}
        <meta property="og:title" content="{PlaintextPostSummary}" />
        {/block:PostSummary}

        {block:Permalink}
            <meta property="og:type" content="article" />
            <meta property="og:url" content="{Permalink}" />
            {block:Posts}
                {block:Text}
                    <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png"/>
                {/block:Text}
                {block:Photo}
                    <meta property="og:image" content="{PhotoURL-500}"/>
                {/block:Photo}
                {block:Photoset}
                    <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png"/>
                {/block:Photoset}
                {block:Quote}
                    <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png"/>
                {/block:Quote}
                {block:Link}
                    <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png"/>
                {/block:Link}
                {block:Chat}
                    <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png"/>
                {/block:Chat}
                {block:Video}
                    <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png"/>
                {/block:Video}
                {block:Audio}
                    <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png"/>
                {/block:Audio}
                {block:Answer}
                    <meta property="og:image" content="{{ S3_BASE_URL }}/img/{{ slug }}/og_image.png"/>
                {/block:Answer}
            {/block:Posts}
        {/block:Permalink}


    </head>
    <body class="{block:IndexPage}index-page{/block:IndexPage}{block:PermalinkPage}permalink-page{/block:PermalinkPage}">

        {block:IndexPage}
        <header class="blog-header">
            <div class="container-fluid">
                <div class="row">
                    <div class="blog-title">
                        <h2 class="npr-logo"><a href="http://npr.org">
                        {block:IfUseBlackNPRLogo}
                        {{ static(file_path='npr-logo-black.svg') }}
                        {/block:IfUseBlackNPRLogo}{block:IfNotUseBlackNPRLogo}
                        {{ static(file_path='npr-logo-white.svg') }}
                        {/block:IfNotUseBlackNPRLogo}
                        </a></h2>
                        <h3><a href="/">{Title}</a></h3>
                        <!-- <h1>{{ static(file_path='drawmazing_text.gif', classes='img-responsive', alt="It's Drawmazing!") }}</h1> -->
                        <p class="description">{Description}</p>
                    </div>
                </div>
            </div>
        </header>
        {/block:IndexPage}

        {block:HasPages}
        <nav>
            <div class="container-fluid">
                <div class="row">
                    <div id="header-nav">
                        <ul>
                        {block:Pages}
                            <li><a href="{URL}">{Label}</a></li>
                        {/block:Pages}
                            <li><a href="/archive/">Archive</a></li>
                            <li><a href="/ask/">Questions?</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        {/block:HasPages}

        <div class="fixed-nav">
            <div class="nav-wrapper">
                <h2 class="npr-logo"><a href="http://npr.org">
                        {block:IfUseBlackNPRLogo}
                        {{ static(file_path='npr-logo-black.svg') }}
                        {/block:IfUseBlackNPRLogo}{block:IfNotUseBlackNPRLogo}
                        {{ static(file_path='npr-logo-white.svg') }}
                        {/block:IfNotUseBlackNPRLogo}</a></h2>
                <h1><a href="/">{Title}</a></h1>
            </div>
        </div>

        <div id="container" class="group container-fluid">
            <div class="row">
                <section id="post-wrap">

                    {block:TagPage}
                        <div class="row">
                            <h2 class="tag-header">{Tag}</h2>
                        </div>
                    {/block:TagPage}

                    <div id="posts">
                    <!-- START POSTS -->
                    {block:Posts}
                        <article class="post {TagsAsClasses} {block:Text}text{/block:Text}{block:Quote}quote{/block:Quote}{block:Link}link{/block:Link}{block:Video}video{/block:Video}{block:Audio}audio{/block:Audio}{block:Photo}photo{/block:Photo}{block:Photoset}photoset{/block:Photoset}{block:Panorama}panorama{/block:Panorama}{block:Chat}chat{/block:Chat}{block:Answer}answer{/block:Answer}">


                                {block:IndexPage}
                                <div class="post-header">
                                        {block:NewDayDate}
                                            <p class="pubdate"><a href="{Permalink}" class="permalink">{block:Date}{Month} {DayOfMonth}, {Year} {12Hour}:{Minutes} {AmPm}{/block:Date}</a></p>
                                        {/block:NewDayDate}
                                        {block:SameDayDate}<p class="pubdate"><a href="{Permalink}" class="permalink">{block:Date}{Month} {DayOfMonth}, {Year} {12Hour}:{Minutes} {AmPm}{/block:Date}</a></p>{/block:SameDayDate}
                                </div>
                                {/block:IndexPage}

                                <div class="post-content">
                                    <div class="post-content-wrapper">
                                        {block:Text}
                                            {block:IndexPage}
                                                {block:Title}<h3><a href="{Permalink}" class="permalink">{Title}</a></h3>{/block:Title}
                                            {/block:IndexPage}
                                            {block:PermalinkPage}
                                                {block:Title}<h3>{Title}</h3>{/block:Title}
                                            {/block:PermalinkPage}
                                            <div class="text-wrapper">
                                                {Body}
                                            </div>
                                        {/block:Text}
                                        {block:Quote}
                                            <div class="quote-wrapper">
                                                <blockquote class="words {Length}"><span class="quote-open">&#8220;</span>{Quote}</blockquote>
                                                {block:Source}<div class="source">{Source}</div>{/block:Source}
                                            </div>
                                        {/block:Quote}
                                        {block:Link}
                                            <h3><a href="{URL}" {Target}>{Name} <i class="icon icon-external-link"></i></a></h3>
                                            <div class="caption">
                                                <blockquote>{block:Excerpt}{Excerpt}{/block:Excerpt}</blockquote>
                                                {block:Description}{Description}{/block:Description}
                                            </div>
                                        {/block:Link}
                                        {block:Video}
                                            <div class="media-wrapper video-wrapper">
                                                <div class="video-container">
                                                    {Video-700}
                                                </div>
                                            </div>
                                            {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                                        {/block:Video}
                                        {block:Audio}
                                            {block:AlbumArt}<img src="{AlbumArtURL}" alt="">{/block:AlbumArt}
                                            {AudioPlayerGrey}
                                            {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                                        {/block:Audio}
                                        {block:Photo}
                                                <div class="media-wrapper">
                                                    {LinkOpenTag}<img src="{PhotoURL-HighRes}" class="img-responsive" alt="{PhotoAlt}"/>{LinkCloseTag}
                                                </div>
                                                {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                                        {/block:Photo}

                                        {block:Photoset}
                                        <div class="photoset-700">{Photoset}</div>
                                        {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                            {/block:Photoset}

                                        {block:Panorama}
                                            {LinkOpenTag}<img src="{PhotoURL-Panorama}" class="img-responsive" alt="{PhotoAlt}" />{LinkCloseTag}
                                            {block:Caption}<div class="caption">{Caption}</div>{/block:Caption}
                                        {/block:Panorama}

                                        {block:Chat}
                                            {block:Title}<h3><a href="{Permalink}" class="permalink">{Title}</a></h3>{/block:Title}
                                            <ul class="list-unstyled conversation">
                                                {block:Lines}
                                                <li class="line {Alt}">
                                                    {block:Label}<span class="person">{Label}</span>{/block:Label}
                                                    <span class="person-said">{Line}</span>
                                                </li>
                                                {/block:Lines}
                                            </ul>
                                        {/block:Chat}
                                        {block:Answer}
                                            <div class="qa-asker">
                                                <img src="{AskerPortraitURL-40}">
                                                {Asker} asks:
                                            </div>
                                            <div class="qa-question">{Question}</div>
                                            <div class="qa-response">{Answer}</div>
                                        {/block:Answer}

                                        <div class="post-meta">

                                            {block:PermalinkPage}
                                                {block:Posts}
                                                    <p class="pubdate">{block:Date}{Month} {DayOfMonth}, {Year}{/block:Date}</p>
                                                    <div class="sharing"> {LikeButton color="grey"}{ReblogButton color="grey"} </div>
                                                {/block:Posts}
                                            {/block:PermalinkPage}
                                            {block:IndexPage}
                                                <p class="note-count"><a href="{Permalink}" class="permalink"><i class="icon icon-comment"></i> {NoteCountWithLabel}</a></p>
                                                <div class="sharing">{LikeButton color="grey"}{ReblogButton color="grey"}</div>
                                            {/block:IndexPage}
                                        </div>
                                    </div><!-- end .post-content-wrapper -->
                                </div><!-- end .post-content -->




                            {block:PermalinkPage}
                                {block:PostNotes}
                                    <div class="post-notes">
                                        <h3>{NoteCountWithLabel}</h3>
                                        {PostNotes-64}
                                    </div>
                                {/block:PostNotes}

                                <nav class="pagination-index">
                                    <a href="/">See More Posts <i class="fa fa-angle-right"></i></a>
                                </nav>
                            {/block:PermalinkPage}
                        </article>
                    {/block:Posts}
                    <!-- END POSTS -->
                    </div>


                    <footer id="footer">
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
        {{ static(file_path='jquery.fitvids.js') }}
        {{ static(file_path='app.js') }}

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
                        var new_post_div = '.page' + _current_page;
                        // Insert posts and update counters
                        $('#posts').append('<div class="page' + _current_page + '">' + new_posts_html + '</div>');
                        sizeVideoContainers(new_post_div);
                        $(new_post_div).fitVids({ customSelector: "video"});

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
