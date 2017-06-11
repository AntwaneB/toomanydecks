<nav class="navbar top">
	<div class="container">
		<div class="navbar-header">
			<a href="{{ route('app.index') }}" class="navbar-brand">TooManyDecks</a>
		</div>

		<ul class="nav navbar-nav navbar-right">
			<li>
				<a href="{{ route('app.index') }}" @if (Route::currentRouteName() == 'app.index') class="active" @endif>
				   {{ trans('app.index') }}
				</a>
			</li>
			<li>
				<a href="{{ route('brands.index') }}" @if (preg_match('#^brands\..+#', Route::currentRouteName())) class="active" @endif>
				   {{ trans('brands.index') }}
				</a>
			</li>
			<li>
				<a href="{{ route('cards.index') }}" @if (preg_match('#^cards\..+#', Route::currentRouteName())) class="active" @endif>
				   {{ trans('cards.index') }}
				</a>
			</li>
		</ul>
	</div>
</nav>
<nav class="navbar bottom">
	<div class="container">
		<ol class="breadcrumb">
			@if (Route::currentRouteName() != 'app.index')
			<li><a href="{{ route('app.index') }}">{{ trans('app.index') }}</a></li>
			@else
			<li class="active">{{ trans('app.index') }}</li>
			@endif

			@yield('breadcrumb-content')
		</ol>
	</div>
</nav>