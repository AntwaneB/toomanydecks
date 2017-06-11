@extends('layouts.default')

@section('title', 'Home')

@section('super-content')

<div class="jumbotron">
	<div class="container">
		<h1>{{ trans('app.welcome_title') }}</h1>

		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras gravida neque bibendum est semper, eget fermentum arcu facilisis. Nullam molestie nunc eget facilisis condimentum.</p>

		<p>Etiam a sodales ligula. Fusce molestie felis vel ornare sollicitudin. Sed blandit justo nec lectus pharetra porta. Ut tempus sed tortor non ornare.</p>

		<p>Cras vitae orci faucibus, dapibus nibh et, vulputate nibh. In sit amet blandit justo. Nullam velit lorem, viverra nec interdum sit amet, porta vel elit. Vivamus fringilla nisi ut ante ullamcorper, ac vestibulum odio vestibulum. </p>

		<p>
			<a class="btn btn-primary btn-lg" href="{{ route('cards.index') }}">{{ trans('app.browse_decks') }}</a>
			<a class="btn btn-default btn-lg" href="{{ route('app.about') }}">{{ trans('app.about') }}</a>
		</p>
	</div>
</div>

@endsection

@section('content')

<div class="row">
	<div class="col-md-12">
		<h2 class="no-top-margin">{{ trans('app.browse') }}...</h2>

		<div class="row stats">
			<div class="col-md-4">
				<div class="stat-block" style="background-image: url('/img/home/stats_decks.png');">
					<a href="{{ route('cards.index') }}" class="content">
						<h3 class="count">{{ $stats->decksCount }}</h3>
						<p>{{ strtolower(trans('cards.index')) }}</p>
					</a>
				</div>
			</div>
			<div class="col-md-4">
				<div class="stat-block" style="background-image: url('/img/home/stats_brands.png');">
					<a href="{{ route('brands.index') }}" class="content">
						<h3 class="count">{{ $stats->brandsCount }}</h3>
						<p>{{ strtolower(trans('brands.index')) }}</p>
					</a>
				</div>
			</div>
			<div class="col-md-4">
				<div class="stat-block" style="background-image: url('/img/home/stats_stores.png');">
					<a href="{{ route('stores.index') }}" class="content">
						<h3 class="count">{{ $stats->storesCount }}</h3>
						<p>{{ strtolower(trans('stores.index')) }}</p>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<h2>{{ trans('app.recently_added') }}</h2>

		<div class="row recent-decks">
		@foreach ($recentDecks as $deck)
			<div class="col-md-3">
				<div class="proportional-container">
					<a href="{{ route('cards.show', $deck->id) }}">
						<img src="{{ !empty($deck->mainBackPicture) ? $deck->mainBackPicture->path : '/img/misc/card-back-default.png' }}" alt="" />
					</a>
				</div>
			</div>
		@endforeach
		</div>
	</div>
</div>

@endsection
