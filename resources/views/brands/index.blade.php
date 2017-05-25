@extends('layouts.default')

@section('title', 'Brands')

@section('breadcrumb-content')
	<li class="active">{{ trans('brands.index') }}</li>
@endsection

@section('content')
<div class="row brands">
	@foreach ($brands as $brand)
	<div class="col-md-6 col-sm-12 brand-container">
		<div class="brand" style="background-image: url('/storage/brands/{{ $brand->slug }}.png');">
			<div class="overlay">
				<h1>{{ $brand->name }}</h1>

				@if (!empty($brand->description))
				<p>{!! nl2br(e($brand->description)) !!}</p>
				@endif

				<p>
					<a href="{{ route('brands.show', $brand->id) }}" class="btn btn-primary">{{ trans('brands.show-decks') }} ({{ $brand->cardsCount}})</a>
					<a href="{{ $brand->website }}" target="_blank" class="btn btn-default">{{ trans('brands.visit-website') }}</a>
				</p>
			</div>
		</div>
	</div>
	@endforeach
</div>
@endsection
