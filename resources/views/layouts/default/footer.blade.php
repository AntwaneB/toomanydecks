<footer class="footer">
	<div class="container">
		<div class="row">
			<div class="col-md-4 text-left">
				{{ trans('app.created_by', ['name' => 'Antoine Buchser']) }}
				-
				<a href="http://antoine.buchser.fr" target="_blank">{{ trans('app.see_online') }}</a>
			</div>
			<div class="col-md-4 text-center">
				TooManyDecks &copy; 2017
			</div>
			<div class="col-md-4 text-right">
				<a href="{{ route('app.about') }}">{{ trans('app.about') }}</a>
				-
				<a href="#">{{ trans('app.contact') }}</a>
			</div>
		</div>
	</div>
</footer>