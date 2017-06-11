<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="stylesheet" href="/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/app.css">

	<script type="text/javascript" src="/js/jquery.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap.min.js"></script>

	<title>@yield('title') | TooManyDecks</title>
</head>

<body>
<div class="app-content">
	@include('layouts.default.header')

	<div class="super-content">
		@yield('super-content')
	</div>

	<div class="container page-content">
		@yield('content')
	</div>

	@include('layouts.default.footer')
</div>
<script type="text/javascript" src="/js/count.js"></script>
</body>
</html>
