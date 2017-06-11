@extends('layouts.default')

@section('title', $card->name . ' - ' . $card->brand->name)

@section('breadcrumb-content')
	<li><a href="{{ route('brands.show', $card->brand->id) }}">{{ $card->brand->name }}</a></li>
	<li class="active">{{ $card->name }}</li>
@endsection

@section('content')

<div class="card-page">
	<div class="row card-block-wrapper">
		<div class="col-md-12">
			<div class="card-info">
				<div class="row">
					<div class="col-md-6">
						<img class="splash-picture" src="{{ $card->splashPicture->path ?? '/img/misc/card-splash-default.png' }}" alt="{{ trans('cards.splash_picture_alt') }}" />
					</div>
					<div class="col-md-6 col-no-left-padding">
						<h1 class="name">{{ $card->name }}</h1>
						<h3 class="brand">{{ trans('cards.by_brand', ['brand' => $card->brand->name]) }}</h3>
						<p class="text-justify">
							{!! nl2br(e($card->description)) !!}
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row card-block-wrapper">
		<div class="col-md-9 col-no-right-padding">
			<div class="stores-comparator">
				@if (count($card->variations) > 1)
				<ul class="nav nav-tabs" role="tablist">
					@foreach ($card->variations as $variation)
					<li role="presentation"
						@if ($loop->first) class="active" @endif
						>
						<a href="#{{ str_slug($variation->name) }}" aria-controls="{{ str_slug($variation->name) }}" role="tab" data-toggle="tab">
							{{ $variation->name }}
						</a>
					</li>
					@endforeach
				</ul>
				@endif
				<div class="tab-content">
					@foreach ($card->variations as $variation)
					<div role="tabpanel" class="tab-pane @if ($loop->first) active @endif" id="{{ str_slug($variation->name) }}">
						<table class="table table-hover">
							<thead>
								<tr>
									<th class="col-md-8">{{ trans('stores.store') }}</th>
									<th class="col-md-2">{{ trans('stores.availability') }}</th>
									<th class="col-md-2">{{ trans('stores.price') }}</th>
								</tr>
							</thead>
							<tbody>
								@if (empty($variation->stores) || count($variation->stores) == 0)
								<tr>
									<td colspan="3" class="text-center">{{ trans('stores.no_stores_available_for_card') }}</td>
								</tr>
								@endif
								@foreach ($variation->stores as $store)
								<tr>
									<td>
										<a href="{{ $store->pivot->url }}" target="_blank">{{ $store->name }}</a>
									</td>
									<td>
										{{ $store->pivot->in_stock ? trans('stores.in_stock') : trans('stores.sold_out') }}
									</td>
									<td>
										<a href="{{ $store->pivot->url }}" target="_blank">${{ $store->pivot->price }}</a>
									</td>
								</tr>
								@endforeach
							</tbody>
						</table>
					</div>
					@endforeach
				</div>
			</div>
		</div>

		<div class="col-md-3">
			<div class="pictures-sidebar">
				@if (!empty($card->mainBackPicture))
				<div class="row card-block-wrapper">
					<div class="col-md-12">
						<figure>
							<a href="{{ $card->mainBackPicture->path }}" target="_blank">
								<img src="{{ $card->mainBackPicture->path }}" class="card-picture" alt="{{ trans('cards.back_picture_alt') }}" />
							</a>
							<figcaption>{{ trans('cards.back_picture') }}</figcaption>
						</figure>
					</div>
				</div>
				@endif
				@if (!empty($card->mainFrontPicture))
				<div class="row">
					<div class="col-md-12">
						<figure>
							<a href="{{ $card->mainFrontPicture->path }}" target="_blank">
								<img src="{{ $card->mainFrontPicture->path }}" class="card-picture" alt="{{ trans('cards.front_picture_alt') }}" />
							</a>
							<figcaption>{{ trans('cards.front_picture') }}</figcaption>
						</figure>
					</div>
				</div>
				@endif
			</div>
		</div>
	</div>
</div>

@endsection
