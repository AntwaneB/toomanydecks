<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="csrf-token" content="{{ csrf_token() }}">

	<link rel="stylesheet" href="/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/app.css">

	<script type="text/javascript" src="/js/jquery.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap.min.js"></script>

	<title>@yield('title') | Admin | TooManyDecks</title>
</head>

<body>
<div class="app-content">
	@include('layouts.admin.header')

	<div class="container page-content" id="app">
		@yield('content')
	</div>

	@include('layouts.admin.footer')
</div>

<script type="text/javascript" src="/js/app.js"></script>
</body>
</html>
