@extends('layouts.default')

@section('title', $brand->name)

@section('breadcrumb-content')
	<li><a href="{{ route('brands.index') }}">{{ trans('brands.index') }}</a></li>
	<li class="active">{{ $brand->name }}</li>
@endsection

@section('content')

<div class="brand">
	<div class="row brand-info-wrapper">
		<div class="col-md-12">
			<div class="brand-info">
				<div class="row">
					<div class="col-md-6 col-no-right-padding">
						<h1 class="name">{{ $brand->name }}</h1>
						<p class="text-justify">
							{!! nl2br(e($brand->description)) !!}
						</p>
					</div>
					<div class="col-md-6">
						<img class="splash-picture" src="/storage/brands/{{ $brand->slug }}.png" alt="" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

@include('fragments.cards.list', ['cards' => $brand->cards()->paginate(24)])

@endsection
