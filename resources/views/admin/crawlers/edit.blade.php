@extends('layouts.admin')

@section('title', trans('crawlers.create'))

@section('content')

<form action="{{ route('admin.crawlers.update', $crawler) }}" method="post">
	{{ csrf_field() }}
	{{ method_field('PUT') }}

	@include('fragments.forms.errors', ['errors' => $errors])

	<dl>
		<dt>{{ trans('stores.store') }}</dt>
		<dd>{{ $crawler->store->name }}</dd>
	</dl>

	<div class="form-group">
		<label for="list_url">{{ trans('crawlers.list_url') }}</label>
		<input type="text" name="list_url" id="list_url" value="{{ $crawler->list_url }}" placeholder="{{ trans('crawlers.list_url') }}" class="form-control" required="required" />
	</div>

	<div class="form-group">
		<label for="list_frequency">{{ trans('crawlers.list_frequency') }}</label>
		<input type="text" name="list_frequency" id="list_frequency" value="{{ $crawler->list_frequency }}" placeholder="{{ trans('crawlers.list_frequency') }}" class="form-control" required="required" />
	</div>

	<div class="form-group">
		<label for="cards_frequency">{{ trans('crawlers.cards_frequency') }}</label>
		<input type="text" name="cards_frequency" id="cards_frequency" value="{{ $crawler->cards_frequency }}" placeholder="{{ trans('crawlers.cards_frequency') }}" class="form-control" required="required" />
	</div>

	<fieldset>
		<legend>{{ trans('crawlers.list_selectors') }}</legend>

		<div class="form-group">
			<label for="individual_selector">{{ trans('crawlers.individual_selector') }}</label>
			<input type="text" name="individual_selector" id="individual_selector" value="{{ $crawler->individual_selector }}" placeholder="{{ trans('crawlers.individual_selector') }}" class="form-control" required="required" />
		</div>

		<div class="form-group">
			<label for="url_selector">{{ trans('crawlers.url_selector') }}</label>
			<input type="text" name="url_selector" id="url_selector" value="{{ $crawler->url_selector }}" placeholder="{{ trans('crawlers.url_selector') }}" class="form-control" required="required" />
		</div>
	</fieldset>

	<fieldset>
		<legend>{{ trans('crawlers.card_page_selectors') }}</legend>

		<div class="form-group">
			<label for="brand_selector">{{ trans('crawlers.brand_selector') }}</label>
			<input type="text" name="brand_selector" id="brand_selector" value="{{ $crawler->brand_selector }}" placeholder="{{ trans('crawlers.brand_selector') }}" class="form-control" />
		</div>

		<div class="form-group">
			<label for="name_selector">{{ trans('crawlers.name_selector') }}</label>
			<input type="text" name="name_selector" id="name_selector" value="{{ $crawler->name_selector }}" placeholder="{{ trans('crawlers.name_selector') }}" class="form-control" />
		</div>

		<div class="form-group">
			<label for="description_selector">{{ trans('crawlers.description_selector') }}</label>
			<input type="text" name="description_selector" id="description_selector" value="{{ $crawler->description_selector }}" placeholder="{{ trans('crawlers.description_selector') }}" class="form-control" />
		</div>

		<div class="form-group">
			<label for="in_stock_selector">{{ trans('crawlers.in_stock_selector') }}</label>
			<input type="text" name="in_stock_selector" id="in_stock_selector" value="{{ $crawler->in_stock_selector }}" placeholder="{{ trans('crawlers.in_stock_selector') }}" class="form-control" />
		</div>

		<div class="form-group">
			<label for="price_selector">{{ trans('crawlers.price_selector') }}</label>
			<input type="text" name="price_selector" id="price_selector" value="{{ $crawler->price_selector }}" placeholder="{{ trans('crawlers.price_selector') }}" class="form-control" />
		</div>
	</fieldset>

	<div class="form-group">
		<input type="submit" value="{{ trans('crawlers.update') }}" class="btn btn-primary" />
	</div>

</form>

@endsection