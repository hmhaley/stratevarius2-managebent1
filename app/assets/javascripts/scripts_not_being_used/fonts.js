WebFontConfig = {
	google: {
		families: ['Dosis:400,700,800:latin', 'Exo+2:700,500italic,400:latin' ] 
	}
};

(function() {
	var wf = documnt.createElement('script');
	wf.scr = ('https:' == document.location.protocol ? 'https' : 'http') +
		'://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
	wf.type = 'text/javascript';
	wf.async = 'true';
	var s = document.getElementsByTagName('script')[0];
	s.parentNode.insertBefore(wf, s);
})

();


/////   OTHER FONTS I LIKE /////

// <link href="//fonts.googleapis.com/css?family=Unica+One:400" rel="stylesheet" type="text/css">
// <link href="//fonts.googleapis.com/css?family=Open+Sans:300italic,300,400italic,400,600italic,600,700italic,700,800italic,800" rel="stylesheet" type="text/css">
// <link href="//fonts.googleapis.com/css?family=Lato:100italic,100,300italic,300,400italic,400,700italic,700,900italic,900" rel="stylesheet" type="text/css">
// <link href="//fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
// <link href="//fonts.googleapis.com/css?family=Droid+Sans:400,700" rel="stylesheet" type="text/css">



// .page-wrap {
//   min-height: 100%;
//   margin-bottom: -60px;
// }

// .page-wrap:after {
//   content: "";
//   display: block;
//   height: 60px
// }